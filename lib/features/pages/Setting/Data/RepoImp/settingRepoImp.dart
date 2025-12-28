import 'package:dartz/dartz.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/features/pages/Setting/Data/DataSource/settingDataSource.dart';
import 'package:two_m_production/features/pages/Setting/Domain/Repo/settingRepo.dart';

class SettingRepoImp extends SettingRepo {
  final SettingdataSource dataSource;
  SettingRepoImp({required this.dataSource});
  @override
  Future<Either<Failure, bool>> NewInjectionMolding() {
    return dataSource.NewInjectionMolding();
  }

  @override
  Future<Either<Failure, bool>> addNewProduct() {
    return dataSource.addNewProduct();
  }

  @override
  Future<Either<Failure, bool>> editProfile(String name, String pathImage) {
    return dataSource.editProfile(name, pathImage);
  }
}
