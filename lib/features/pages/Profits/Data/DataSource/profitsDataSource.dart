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
      final snapshot = await _firestore
          .collection('Orders')
          .where('date', isGreaterThanOrEqualTo: startDate)
          .where('date', isLessThanOrEqualTo: endDate)
          .orderBy('date', descending: false)
          .get();

      final orders = snapshot.docs
          .map((doc) => OrderModel.fromJson(doc.data()))
          .toList();

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
      // Get last 100 orders to extract distinct product/size names
      final snapshot = await _firestore
          .collection('Orders')
          .orderBy('createdAt', descending: true)
          .limit(100)
          .get();

      final Set<String> productNames = {};

      for (var doc in snapshot.docs) {
        final data = doc.data();
        final sizes = data['sizes'] as Map<String, dynamic>?;
        if (sizes != null) {
          productNames.addAll(sizes.keys);
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
