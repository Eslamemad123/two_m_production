import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

import 'package:two_m_production/features/pages/Auth/login/Data/datasources/dataSouce.dart';
import 'package:two_m_production/features/pages/Auth/login/Data/repositories/repo_Implement.dart';
import 'package:two_m_production/features/pages/Auth/login/Domain/repositories/repo_abstract.dart';
import 'package:two_m_production/features/pages/Auth/login/Domain/usecases/login_useCase.dart';

import 'package:two_m_production/features/pages/Home/Data/DataSource/homeDataSource.dart';
import 'package:two_m_production/features/pages/Home/Data/RepoImp/homeRepoImp.dart';
import 'package:two_m_production/features/pages/Home/Domain/Repo/homeRepo.dart';
import 'package:two_m_production/features/pages/Home/Domain/UseCase/addProductStockUseCase.dart';
import 'package:two_m_production/features/pages/Home/Domain/UseCase/getHomeSectionUseCase.dart';

import 'package:two_m_production/features/pages/Setting/Data/DataSource/settingDataSource.dart';
import 'package:two_m_production/features/pages/Setting/Data/RepoImp/settingRepoImp.dart';
import 'package:two_m_production/features/pages/Setting/Domain/Repo/settingRepo.dart';
import 'package:two_m_production/features/pages/Setting/Domain/UseCase/editProfileUseCase.dart';

final gi = GetIt.instance;

Future<void> setupServiceLocator() async {
  /// 🔹 Firebase
  if (!gi.isRegistered<FirebaseFirestore>()) {
    gi.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance,
    );
  }

  /// 🔹 Data Sources
  if (!gi.isRegistered<AuthDataSourc>()) {
    gi.registerLazySingleton<AuthDataSourc>(
      () => AuthDataSourcImp(),
    );
  }

  if (!gi.isRegistered<SettingdataSource>()) {
    gi.registerLazySingleton<SettingdataSource>(
      () => SettingDataSourceImp(),
    );
  }

  if (!gi.isRegistered<HomeDataSource>()) {
    gi.registerLazySingleton<HomeDataSource>(
      () => HomeDataSourceImp(gi<FirebaseFirestore>()),
    );
  }

  /// 🔹 Repositories
  if (!gi.isRegistered<AuthRepo>()) {
    gi.registerLazySingleton<AuthRepo>(
      () => AuthRepoImp(dataSource: gi<AuthDataSourc>()),
    );
  }

  if (!gi.isRegistered<SettingRepo>()) {
    gi.registerLazySingleton<SettingRepo>(
      () => SettingRepoImp(dataSource: gi<SettingdataSource>()),
    );
  }

  if (!gi.isRegistered<HomeRepo>()) {
    gi.registerLazySingleton<HomeRepo>(
      () => HomeRepoImp(homeDataSource: gi<HomeDataSource>()),
    );
  }

  /// 🔹 Use Cases
  if (!gi.isRegistered<AuthUseCase>()) {
    gi.registerLazySingleton<AuthUseCase>(
      () => AuthUseCase(loginRepo: gi<AuthRepo>()),
    );
  }

  if (!gi.isRegistered<Editprofileusecase>()) {
    gi.registerLazySingleton<Editprofileusecase>(
      () => Editprofileusecase(settingRepo: gi<SettingRepo>()),
    );
  }

  if (!gi.isRegistered<GetHomeSectionUseCase>()) {
    gi.registerLazySingleton<GetHomeSectionUseCase>(
      () => GetHomeSectionUseCase(homeRepo: gi<HomeRepo>()),
    );
  }
if (!gi.isRegistered<AddProductStock>()) {
    gi.registerLazySingleton<AddProductStock>(
      () => AddProductStock(homeRepo: gi<HomeRepo>()),
    );
  }

  /// 🔹 Cubit (Factory أفضل)

}
