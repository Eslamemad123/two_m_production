import 'package:get_it/get_it.dart';
import 'package:two_m_production/features/pages/Auth/login/Data/datasources/dataSouce.dart';
import 'package:two_m_production/features/pages/Auth/login/Data/repositories/repo_Implement.dart';
import 'package:two_m_production/features/pages/Auth/login/Domain/repositories/repo_abstract.dart';
import 'package:two_m_production/features/pages/Auth/login/Domain/usecases/login_useCase.dart';

final gi = GetIt.instance;

Future<void> setupServiceLocator() async {
  // data Souce
  gi.registerLazySingleton<AuthDataSourc>(() => AuthDataSourcImp());

  //Repo
  gi.registerLazySingleton<AuthRepo>(
    () => AuthRepoImp(dataSource: gi<AuthDataSourc>()),
  );
  //use case
  gi.registerLazySingleton<AuthUseCase>(
    () => AuthUseCase(loginRepo: gi<AuthRepo>()),
  );
}
