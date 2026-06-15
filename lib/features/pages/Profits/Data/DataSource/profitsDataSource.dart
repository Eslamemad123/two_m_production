import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/features/pages/RecordSale/Data/model/oredeModel.dart';

abstract class ProfitsDataSource {
  Future<Either<Failure, List<OrderModel>>> getOrdersByDateRange(
    String startDate,
    String endDate,
  );

  Future<Either<Failure, List<String>>> getProductNames();
}

class ProfitsDataSourceImp extends ProfitsDataSource {
  final FirebaseFirestore _firestore;

  ProfitsDataSourceImp(this._firestore);

  @override
  Future<Either<Failure, List<OrderModel>>> getOrdersByDateRange(
    String startDate,
    String endDate,
  ) async {
    try {
      // Get all customers
      final snapshot = await _firestore
          .collection('Customers')
          .get();

      final List<OrderModel> orders = [];

      for (var doc in snapshot.docs) {
        final customerData = doc.data();
        final customerName = customerData['name'] ?? '';
        final customerPhone = customerData['phone'] ?? '';
        final ordersList = customerData['orders'] as List? ?? [];

        for (var orderObj in ordersList) {
          final orderMap = Map<String, dynamic>.from(orderObj);
          final orderDate = orderMap['date'] ?? '';

          // Filter by date range
          if (orderDate.compareTo(startDate) >= 0 && orderDate.compareTo(endDate) <= 0) {
            final orderId = orderMap['orderId'] ?? '';
            final price = (orderMap['price'] ?? 0.0).toDouble();
            final vodafoneCash = orderMap['vodafoneCash'] ?? false;
            final inDrive = orderMap['inDrive'] ?? false;
            
            final sizesList = orderMap['sizes'] as List? ?? [];
            final Map<String, int> sizesMap = {};
            for (var sizeObj in sizesList) {
              final sizeMap = Map<String, dynamic>.from(sizeObj);
              final sizeName = sizeMap['size'] ?? '';
              final sizeQty = sizeMap['quantity'] ?? 0;
              sizesMap[sizeName] = sizeQty;
            }

            orders.add(OrderModel(
              name: customerName,
              Phone: customerPhone,
              price: price,
              orderId: orderId,
              date: orderDate,
              sizes: sizesMap,
              vodafoneCash: vodafoneCash,
              inDrive: inDrive,
            ));
          }
        }
      }

      // Sort by date ascending (oldest first)
      orders.sort((a, b) => a.date.compareTo(b.date));

      return Right(orders);
    } on FirebaseException catch (e) {
      log('ProfitsDataSource getOrdersByDateRange error: ${e.message}');
      if (e.code == 'unavailable' || e.code == 'network-request-failed') {
        return Left(Failure(message: 'تحقق من الاتصال بالإنترنت'));
      }
      return Left(Failure(message: e.message ?? 'Firestore error'));
    } catch (e) {
      log('ProfitsDataSource getOrdersByDateRange error: $e');
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getProductNames() async {
    try {
      // Get last 50 customers to extract distinct product/size names
      final snapshot = await _firestore
          .collection('Customers')
          .orderBy('createdAt', descending: true)
          .limit(50)
          .get();

      final Set<String> productNames = {};

      for (var doc in snapshot.docs) {
        final customerData = doc.data();
        final ordersList = customerData['orders'] as List? ?? [];
        for (var orderObj in ordersList) {
          final orderMap = Map<String, dynamic>.from(orderObj);
          final sizesList = orderMap['sizes'] as List? ?? [];
          for (var sizeObj in sizesList) {
            final sizeMap = Map<String, dynamic>.from(sizeObj);
            final sizeName = sizeMap['size'] as String?;
            if (sizeName != null && sizeName.isNotEmpty) {
              productNames.add(sizeName);
            }
          }
        }
      }

      final sortedNames = productNames.toList()..sort();
      return Right(sortedNames);
    } on FirebaseException catch (e) {
      log('ProfitsDataSource getProductNames error: ${e.message}');
      return Left(Failure(message: e.message ?? 'Firestore error'));
    } catch (e) {
      log('ProfitsDataSource getProductNames error: $e');
      return Left(Failure(message: e.toString()));
    }
  }
}
