import 'package:dartz/dartz.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/features/pages/RecordSale/Data/model/oredeModel.dart';
import 'package:two_m_production/features/pages/oreder/Domain/Repo/addOrder_Repo.dart';

class FilterOrdersUseCase {
  final OrdersRepo ordersRepo;
  FilterOrdersUseCase({required this.ordersRepo});
  Future<Either<Failure, List<OrderModel>>> call(String filter) {
    return ordersRepo.filterOrders(filter);
  }
}
