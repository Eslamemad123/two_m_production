import 'package:dartz/dartz.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/features/pages/Home/Data/DataSource/homeDataSource.dart';
import 'package:two_m_production/features/pages/Home/Data/Model/productModel.dart';
import 'package:two_m_production/features/pages/Home/Domain/Repo/homeRepo.dart';

class HomeRepoImp extends HomeRepo {
  final HomeDataSource homeDataSource;
  HomeRepoImp({required this.homeDataSource});
  @override
  Future<Either<Failure, bool>> addProducStock(int count, String id,String date,String? note) {
        return homeDataSource.addProducStock(count,id,date,note);

  }

  @override
  Future<Either<Failure, List<ProductModel>>> getHomeSection(String section) {
    return homeDataSource.getHomeSection(section);
  }
}
