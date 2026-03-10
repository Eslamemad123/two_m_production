import 'package:dartz/dartz.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/features/pages/RecordSale/Data/model/oredeModel.dart';
import 'package:two_m_production/features/pages/oreder/Data/Model/paginated_result.dart';
import 'package:two_m_production/features/pages/oreder/Domain/Repo/addOrder_Repo.dart';

class GetOrdersPaginatedUseCase {
  final OrdersRepo ordersRepo;

  GetOrdersPaginatedUseCase({required this.ordersRepo});

  Future<Either<Failure, PaginatedResult<OrderModel>>> call({
    int limit = 10,
    dynamic startAfterDoc,
    dynamic endBeforeDoc,
  }) {
    return ordersRepo.getOrdersPaginated(
      limit: limit,
      startAfterDoc: startAfterDoc,
      endBeforeDoc: endBeforeDoc,
    );
  }
}
