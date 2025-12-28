import 'package:get_it/get_it.dart';
import 'package:two_m_production/features/pages/Auth/login/Data/datasources/dataSouce.dart';
import 'package:two_m_production/features/pages/Auth/login/Data/repositories/repo_Implement.dart';
import 'package:two_m_production/features/pages/Auth/login/Domain/repositories/repo_abstract.dart';
import 'package:two_m_production/features/pages/Auth/login/Domain/usecases/login_useCase.dart';
import 'package:two_m_production/features/pages/Setting/Data/DataSource/settingDataSource.dart';
import 'package:two_m_production/features/pages/Setting/Data/RepoImp/settingRepoImp.dart';
import 'package:two_m_production/features/pages/Setting/Domain/Repo/settingRepo.dart';
import 'package:two_m_production/features/pages/Setting/Domain/UseCase/editProfileUseCase.dart';

final gi = GetIt.instance;

Future<void> setupServiceLocator() async {
  // data Souce
  gi.registerLazySingleton<AuthDataSourc>(() => AuthDataSourcImp());
  gi.registerLazySingleton<SettingdataSource>(() => SettingDataSourceImp());

  //Repo
  gi.registerLazySingleton<AuthRepo>(
    () => AuthRepoImp(dataSource: gi<AuthDataSourc>()),
  );
  gi.registerLazySingleton<SettingRepo>(
    () => SettingRepoImp(dataSource: gi<SettingdataSource>()),
  );
  //use case
  gi.registerLazySingleton<AuthUseCase>(
    () => AuthUseCase(loginRepo: gi<AuthRepo>()),
  );
  gi.registerLazySingleton<Editprofileusecase>(
    () => Editprofileusecase(settingRepo: gi<SettingRepo>()),
  );
}
