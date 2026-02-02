import 'package:dartz/dartz.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/features/pages/Home/Data/Model/productModel.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<ProductModel>>> getHomeSection(String section);
  Future<Either<Failure, bool>> addProducStock(int count, String id,String date,String? note);
}
