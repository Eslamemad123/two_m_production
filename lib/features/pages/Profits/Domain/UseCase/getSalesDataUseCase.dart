import 'package:dartz/dartz.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/features/pages/Profits/Domain/Repo/profitsRepo.dart';
import 'package:two_m_production/features/pages/RecordSale/Data/model/oredeModel.dart';

class GetSalesDataUseCase {
  final ProfitsRepo profitsRepo;

  GetSalesDataUseCase({required this.profitsRepo});

  Future<Either<Failure, List<OrderModel>>> call(
    String startDate,
    String endDate,
  ) {
    return profitsRepo.getOrdersByDateRange(startDate, endDate);
  }
}
