import 'package:dartz/dartz.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/features/pages/RecordSale/Data/model/customer_model.dart';
import 'package:two_m_production/features/pages/oreder/Data/DataSource/addOrderDateSource.dart';
import 'package:two_m_production/features/pages/oreder/Data/Model/paginated_result.dart';
import 'package:two_m_production/features/pages/oreder/Domain/Repo/addOrder_Repo.dart';

class OrdersRepoImp extends OrdersRepo {
  final OrdersDataSource orderDataSource;
  OrdersRepoImp({required this.orderDataSource});

  @override
  Future<Either<Failure, List<CustomerModel>>> filterOrders(String filter) {
    return orderDataSource.filterOrders(filter);
  }

  @override
  Future<Either<Failure, PaginatedResult<CustomerModel>>> getOrdersPaginated({
    int limit = 10,
    dynamic startAfterDoc,
    dynamic endBeforeDoc,
  }) {
    return orderDataSource.getOrdersPaginated(
      limit: limit,
      startAfterDoc: startAfterDoc,
      endBeforeDoc: endBeforeDoc,
    );
  }

  @override
  Future<Either<Failure, List<CustomerModel>>> getOrders() {
    return orderDataSource.getOrders();
  }

  @override
  Future<Either<Failure, List<CustomerModel>>> searchOrders(String order) {
    return orderDataSource.searchOrders(order);
  }
}
