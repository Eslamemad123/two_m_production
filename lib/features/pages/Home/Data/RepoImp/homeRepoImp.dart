import 'package:dartz/dartz.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/features/pages/Home/Data/DataSource/homeDataSource.dart';
import 'package:two_m_production/features/pages/Home/Data/Model/productModel.dart';
import 'package:two_m_production/features/pages/Home/Domain/Repo/homeRepo.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class HomeRepoImp extends HomeRepo {
  final HomeDataSource homeDataSource;
  HomeRepoImp({required this.homeDataSource});
  @override
  Future<Either<Failure, bool>> addProducStock(
    int count,
    String id,
    String date,
    String? note,
  ) async {
    return homeDataSource.addProducStock(count, id, date, note);
  }

  @override
  Stream<Either<Failure, List<ProductModel>>> getHomeSection(
    String section,
  ) async* {
    final result = await Connectivity().checkConnectivity();

    if (result.contains(ConnectivityResult.wifi) ||
        result.contains(ConnectivityResult.mobile)) {
      yield* homeDataSource.getHomeSection(section);
    } else {
      yield* homeDataSource.getHomeSectionNoWiFi(section);
    }
  }
}
