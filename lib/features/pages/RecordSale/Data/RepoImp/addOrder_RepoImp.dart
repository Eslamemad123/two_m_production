import 'package:dartz/dartz.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/features/pages/RecordSale/Data/DataSource/addOrderDateSource.dart';
import 'package:two_m_production/features/pages/RecordSale/Data/model/oredeModel.dart';
import 'package:two_m_production/features/pages/RecordSale/Domain/Repo/addOrder_Repo.dart';

class AddOrderRepoImp extends AddOrderRepo {
  final AddOrderDataSource orderDataSource;
  AddOrderRepoImp({required this.orderDataSource});
  @override
  Future<Either<Failure, bool>> addOrder(OrderModel order) {
    return orderDataSource.addOrder(order);
  }
}
