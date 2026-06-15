import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/features/pages/RecordSale/Data/model/customer_model.dart';
import 'package:two_m_production/features/pages/oreder/Data/Model/paginated_result.dart';

abstract class OrdersDataSource {
  Future<Either<Failure, List<CustomerModel>>> getOrders();
  Future<Either<Failure, PaginatedResult<CustomerModel>>> getOrdersPaginated({
    int limit = 10,
    dynamic startAfterDoc,
    dynamic endBeforeDoc,
  });
  Future<Either<Failure, List<CustomerModel>>> filterOrders(String filter);
  Future<Either<Failure, List<CustomerModel>>> searchOrders(String query);
}

class OrderDataSourceImp extends OrdersDataSource {
  final FirebaseFirestore _firestore;
  OrderDataSourceImp(this._firestore);

  @override
  Future<Either<Failure, PaginatedResult<CustomerModel>>> getOrdersPaginated({
    int limit = 10,
    dynamic startAfterDoc,
    dynamic endBeforeDoc,
  }) async {
    try {
      Query query = _firestore
          .collection('Customers')
          .orderBy('createdAt', descending: true);

      if (startAfterDoc != null) {
        query = query.startAfterDocument(startAfterDoc).limit(limit);
      } else if (endBeforeDoc != null) {
        query = query.endBeforeDocument(endBeforeDoc).limitToLast(limit);
      } else {
        query = query.limit(limit);
      }

      final snapshot = await query.get();
      final customers = snapshot.docs
          .map((doc) => CustomerModel.fromJson(doc.data() as Map<String, dynamic>, docId: doc.id))
          .toList();

      return Right(
        PaginatedResult<CustomerModel>(
          items: customers,
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
  Future<Either<Failure, List<CustomerModel>>> filterOrders(String filter) async {
    try {
      final snapshot = await _firestore
          .collection('Customers')
          .orderBy('createdAt', descending: true)
          .get();

      final customers = snapshot.docs
          .map((doc) => CustomerModel.fromJson(doc.data() as Map<String, dynamic>, docId: doc.id))
          .where((customer) => customer.orders.any((order) => order.date == filter))
          .toList();

      return Right(customers);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CustomerModel>>> getOrders() async {
    try {
      final snapshot = await _firestore
          .collection('Customers')
          .orderBy('createdAt', descending: true)
          .get();
      final customers = snapshot.docs
          .map((doc) => CustomerModel.fromJson(doc.data() as Map<String, dynamic>, docId: doc.id))
          .toList();

      return Right(customers);
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
  Future<Either<Failure, List<CustomerModel>>> searchOrders(String query) async {
    try {
      final snapshot = await _firestore
          .collection('Customers')
          .orderBy('createdAt', descending: true)
          .get();

      final q = query.toLowerCase();
      final customers = snapshot.docs
          .map((doc) => CustomerModel.fromJson(doc.data() as Map<String, dynamic>, docId: doc.id))
          .where(
            (customer) =>
                customer.name.toLowerCase().contains(q) ||
                customer.phone.toLowerCase().contains(q),
          )
          .toList();

      return Right(customers);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
