import 'package:dartz/dartz.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/features/pages/RecordSale/Data/model/customer_model.dart';
import 'package:two_m_production/features/pages/oreder/Data/Model/paginated_result.dart';

abstract class OrdersRepo {
  Future<Either<Failure, List<CustomerModel>>> getOrders();
  Future<Either<Failure, PaginatedResult<CustomerModel>>> getOrdersPaginated({
    int limit = 10,
    dynamic startAfterDoc,
    dynamic endBeforeDoc,
  });
  Future<Either<Failure, List<CustomerModel>>> filterOrders(String filter);
  Future<Either<Failure, List<CustomerModel>>> searchOrders(String order);
}
