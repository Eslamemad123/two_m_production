import 'package:dartz/dartz.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/features/pages/RecordSale/Data/model/customer_model.dart';
import 'package:two_m_production/features/pages/oreder/Domain/Repo/addOrder_Repo.dart';

class SearchOrdersUseCase {
  final OrdersRepo ordersRepo;
  SearchOrdersUseCase({required this.ordersRepo});
  Future<Either<Failure, List<CustomerModel>>> call(String order) {
    return ordersRepo.searchOrders(order);
  }
}
