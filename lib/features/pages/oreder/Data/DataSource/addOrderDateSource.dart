import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:two_m_production/core/error/failer.dart';

abstract class OrdersDataSource {
  Future<Either<Failure, bool>> getOrders();
  Future<Either<Failure, bool>> filterOrders(String filter);
  Future<Either<Failure, bool>> searchOrders(String order);}
class AddorderDataSourceImp extends OrdersDataSource{
  AddorderDataSourceImp(FirebaseFirestore firebaseFirestore);

  @override
  Future<Either<Failure, bool>> filterOrders(String filter) {
    // TODO: implement filterOrders
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, bool>> getOrders() {
    // TODO: implement getOrders
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, bool>> searchOrders(String order) {
    // TODO: implement searchOrders
    throw UnimplementedError();
  }

}
