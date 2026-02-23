import 'package:dartz/dartz.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/features/pages/RecordSale/Data/model/oredeModel.dart';
import 'package:two_m_production/features/pages/oreder/Domain/Repo/addOrder_Repo.dart';

class getOrdersUseCase {
  final OrdersRepo ordersRepo;
  getOrdersUseCase({required this.ordersRepo});
  Future<Either<Failure, bool>> call(OrderModel order) {
    return ordersRepo.getOrders();
  }
}
