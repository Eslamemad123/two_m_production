import 'package:dartz/dartz.dart';
import 'package:two_m_production/core/error/failer.dart';

abstract class OrdersRepo {
  Future<Either<Failure, bool>> getOrders();
  Future<Either<Failure, bool>> filterOrders(String filter);
  Future<Either<Failure, bool>> searchOrders(String order);
}
