import 'package:dartz/dartz.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/features/pages/RecordSale/Data/model/oredeModel.dart';

abstract class ProfitsRepo {
  Future<Either<Failure, List<OrderModel>>> getOrdersByDateRange(
    String startDate,
    String endDate,
  );

  Future<Either<Failure, List<String>>> getProductNames();
}
