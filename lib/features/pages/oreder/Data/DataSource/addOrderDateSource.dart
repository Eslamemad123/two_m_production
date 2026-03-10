import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/features/pages/RecordSale/Data/model/oredeModel.dart';

import 'package:two_m_production/features/pages/oreder/Data/Model/paginated_result.dart';

abstract class OrdersDataSource {
  Future<Either<Failure, List<OrderModel>>> getOrders();
  Future<Either<Failure, PaginatedResult<OrderModel>>> getOrdersPaginated({
    int limit = 10,
    dynamic startAfterDoc,
    dynamic endBeforeDoc,
  });
  Future<Either<Failure, List<OrderModel>>> filterOrders(String filter);
  Future<Either<Failure, List<OrderModel>>> searchOrders(String order);
}

class OrderDataSourceImp extends OrdersDataSource {
  OrderDataSourceImp(FirebaseFirestore firebaseFirestore);

  @override
  Future<Either<Failure, PaginatedResult<OrderModel>>> getOrdersPaginated({
    int limit = 10,
    dynamic startAfterDoc,
    dynamic endBeforeDoc,
  }) async {
    try {
      Query query = FirebaseFirestore.instance
          .collection('Orders')
          .orderBy('createdAt', descending: true);

      if (startAfterDoc != null) {
        query = query.startAfterDocument(startAfterDoc).limit(limit);
      } else if (endBeforeDoc != null) {
        query = query.endBeforeDocument(endBeforeDoc).limitToLast(limit);
      } else {
        query = query.limit(limit);
      }

      final snapshot = await query.get();
      final orders = snapshot.docs
          .map((doc) => OrderModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      return Right(
        PaginatedResult<OrderModel>(
          items: orders,
          firstDocument: snapshot.docs.isNotEmpty ? snapshot.docs.first : null,
          lastDocument: snapshot.docs.isNotEmpty ? snapshot.docs.last : null,
        ),
      );
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable' || e.code == 'network-request-failed') {
        return Left(Failure(message: 'check internet'));
      }
      return Left(Failure(message: e.message ?? 'Firestore error'));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<OrderModel>>> filterOrders(String filter) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('Orders')
          .where('date', isEqualTo: filter)
          .get();

      final orders = snapshot.docs
          .map((doc) => OrderModel.fromJson(doc.data()))
          .toList();
      orders.sort((a, b) {
        final aParts = a.orderId.split('-');
        final bParts = b.orderId.split('-');
        if (aParts.length == 2 && bParts.length == 2) {
          final aNum = int.tryParse(aParts[1]) ?? 0;
          final bNum = int.tryParse(bParts[1]) ?? 0;
          return bNum.compareTo(aNum); // Descending
        }
        return b.orderId.compareTo(a.orderId);
      });

      return Right(orders);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<OrderModel>>> getOrders() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('Orders')
          .orderBy('createdAt', descending: true)
          .get();
      final orders = snapshot.docs
          .map((doc) => OrderModel.fromJson(doc.data()))
          .toList();

      return Right(orders);
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable' || e.code == 'network-request-failed') {
        return Left(Failure(message: 'check internet'));
      }

      return Left(Failure(message: e.message ?? 'Firestore error'));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<OrderModel>>> searchOrders(String query) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('Orders')
          .orderBy('createdAt', descending: true)
          .get();

      final q = query.toLowerCase();
      final orders = snapshot.docs
          .map((doc) => OrderModel.fromJson(doc.data()))
          .where(
            (order) =>
                order.name.toLowerCase().contains(q) ||
                order.Phone.toLowerCase().contains(q) ||
                order.orderId.toLowerCase().contains(q),
          )
          .toList();

      return Right(orders);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
