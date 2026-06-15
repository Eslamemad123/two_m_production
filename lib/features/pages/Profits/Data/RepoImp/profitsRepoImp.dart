import 'package:dartz/dartz.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/features/pages/Profits/Data/DataSource/profitsDataSource.dart';
import 'package:two_m_production/features/pages/Profits/Domain/Repo/profitsRepo.dart';
import 'package:two_m_production/features/pages/RecordSale/Data/model/oredeModel.dart';

class ProfitsRepoImp extends ProfitsRepo {
  final ProfitsDataSource dataSource;

  ProfitsRepoImp({required this.dataSource});

  @override
  Future<Either<Failure, List<OrderModel>>> getOrdersByDateRange(
    String startDate,
    String endDate,
  ) {
    return dataSource.getOrdersByDateRange(startDate, endDate);
  }

  @override
  Future<Either<Failure, List<String>>> getProductNames() {
    return dataSource.getProductNames();
  }
}
