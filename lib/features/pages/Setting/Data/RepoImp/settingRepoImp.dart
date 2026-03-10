import 'package:dartz/dartz.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/features/pages/Home/Data/Model/productModel.dart';
import 'package:two_m_production/features/pages/Setting/Data/DataSource/settingDataSource.dart';
import 'package:two_m_production/features/pages/Setting/Domain/Repo/settingRepo.dart';

class SettingRepoImp extends SettingRepo {
  final SettingdataSource dataSource;
  SettingRepoImp({required this.dataSource});
  @override
  Future<Either<Failure, bool>> NewInjectionMolding(String product) {
    return dataSource.NewInjectionMolding(product);
  }

  @override
  Future<Either<Failure, bool>> addNewProduct(ProductModel product) {
    return dataSource.addNewProduct(product);
  }
  @override
  Future<Either<Failure, Map<String, dynamic>>> getInjectionData(String product) {
    return dataSource.getInjectionData(product);
  }

  @override
  Future<Either<Failure, bool>> editProfile(String name, String pathImage) {
    return dataSource.editProfile(name, pathImage);
  }

  @override
  Future<Either<Failure, bool>> updateLastConnection() {
    return dataSource.updateLastConnection();
  }
}
