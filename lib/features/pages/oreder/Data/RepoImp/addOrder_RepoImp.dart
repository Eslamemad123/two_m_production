import 'package:dartz/dartz.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/features/pages/oreder/Data/DataSource/addOrderDateSource.dart';
import 'package:two_m_production/features/pages/oreder/Domain/Repo/addOrder_Repo.dart';

class OrdersRepoImp extends OrdersRepo {
  final OrdersDataSource orderDataSource;
  OrdersRepoImp({required this.orderDataSource});

  @override
  Future<Either<Failure, bool>> filterOrders(String filter) {
    return orderDataSource.filterOrders(filter);
  }

  @override
  Future<Either<Failure, bool>> getOrders() {
    return orderDataSource.getOrders();
  }

  @override
  Future<Either<Failure, bool>> searchOrders(String order) {
    return orderDataSource.searchOrders(order);
  }
}
