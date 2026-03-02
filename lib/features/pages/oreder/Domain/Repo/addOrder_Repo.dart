import 'package:dartz/dartz.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/features/pages/RecordSale/Data/model/oredeModel.dart';

abstract class OrdersRepo {
  Future<Either<Failure, List<OrderModel>>> getOrders();
  Future<Either<Failure, List<OrderModel>>> filterOrders(String filter);
  Future<Either<Failure, List<OrderModel>>> searchOrders(String order);
}
