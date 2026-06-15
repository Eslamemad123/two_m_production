import 'package:dartz/dartz.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/features/pages/RecordSale/Data/model/oredeModel.dart';
import 'package:two_m_production/features/pages/RecordSale/Domain/Repo/addOrder_Repo.dart';

class AddOrderUseCase {
  final AddOrderRepo addOrderRepo;
  AddOrderUseCase({required this.addOrderRepo});
  Future<Either<Failure, bool>> call(OrderModel order) {
    return addOrderRepo.addOrder(order);
  }
}
