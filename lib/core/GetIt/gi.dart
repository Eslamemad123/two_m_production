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

import 'package:two_m_production/features/pages/RecordSale/Data/DataSource/addOrderDateSource.dart';
import 'package:two_m_production/features/pages/RecordSale/Data/RepoImp/addOrder_RepoImp.dart';
import 'package:two_m_production/features/pages/RecordSale/Domain/Repo/addOrder_Repo.dart';
import 'package:two_m_production/features/pages/RecordSale/Domain/Usecase/addOrder_UseCse.dart';
import 'package:two_m_production/features/pages/Setting/Domain/UseCase/addProductUseCase.dart';
import 'package:two_m_production/features/pages/Setting/Domain/UseCase/getInjectionUseCase.dart';
import 'package:two_m_production/features/pages/Setting/Domain/UseCase/stopInjectionUseCase.dart';
import 'package:two_m_production/features/pages/oreder/Data/DataSource/addOrderDateSource.dart';
import 'package:two_m_production/features/pages/oreder/Data/RepoImp/addOrder_RepoImp.dart';

import 'package:two_m_production/features/pages/oreder/Domain/Repo/addOrder_Repo.dart';
import 'package:two_m_production/features/pages/oreder/Domain/Usecase/getOrdersUseCse.dart';
import 'package:two_m_production/features/pages/oreder/Domain/Usecase/filterOrderUseCase.dart';
import 'package:two_m_production/features/pages/oreder/Domain/Usecase/searchOrderUseCse.dart';
import 'package:two_m_production/features/pages/oreder/Domain/Usecase/getOrdersPaginatedUseCase.dart';

import 'package:two_m_production/features/pages/Setting/Data/DataSource/settingDataSource.dart';
import 'package:two_m_production/features/pages/Setting/Data/RepoImp/settingRepoImp.dart';
import 'package:two_m_production/features/pages/Setting/Domain/Repo/settingRepo.dart';
import 'package:two_m_production/features/pages/Setting/Domain/UseCase/editProfileUseCase.dart';
import 'package:two_m_production/features/pages/Setting/Domain/UseCase/updateLastConnectionUseCase.dart';

import 'package:two_m_production/features/pages/Profits/Data/DataSource/profitsDataSource.dart';
import 'package:two_m_production/features/pages/Profits/Data/RepoImp/profitsRepoImp.dart';
import 'package:two_m_production/features/pages/Profits/Domain/Repo/profitsRepo.dart';
import 'package:two_m_production/features/pages/Profits/Domain/UseCase/getSalesDataUseCase.dart';
import 'package:two_m_production/features/pages/Profits/Domain/UseCase/getProductNamesUseCase.dart';

final gi = GetIt.instance;

Future<void> setupServiceLocator() async {
  /// 🔹 Firebase
  gi.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  /// 🔹 Data Sources
  gi.registerLazySingleton<AuthDataSourc>(() => AuthDataSourcImp());

  gi.registerLazySingleton<SettingdataSource>(() => SettingDataSourceImp());

  gi.registerLazySingleton<HomeDataSource>(
    () => HomeDataSourceImp(gi<FirebaseFirestore>()),
  );

  gi.registerLazySingleton<AddOrderDataSource>(
    () => AddorderDataSourceImp(gi<FirebaseFirestore>()),
  );

  /// 🔴 Orders DataSource
  gi.registerLazySingleton<OrdersDataSource>(
    () => OrderDataSourceImp(gi<FirebaseFirestore>()),
  );

  /// 🔹 Repositories
  gi.registerLazySingleton<AuthRepo>(
    () => AuthRepoImp(dataSource: gi<AuthDataSourc>()),
  );

  gi.registerLazySingleton<SettingRepo>(
    () => SettingRepoImp(dataSource: gi<SettingdataSource>()),
  );

  gi.registerLazySingleton<HomeRepo>(
    () => HomeRepoImp(homeDataSource: gi<HomeDataSource>()),
  );

  gi.registerLazySingleton<AddOrderRepo>(
    () => AddOrderRepoImp(orderDataSource: gi<AddOrderDataSource>()),
  );

  /// 🔴 OrdersRepo (المفقود)
  gi.registerLazySingleton<OrdersRepo>(
    () => OrdersRepoImp(orderDataSource: gi<OrdersDataSource>()),
  );

  /// 🔹 Use Cases
  gi.registerLazySingleton<AuthUseCase>(
    () => AuthUseCase(loginRepo: gi<AuthRepo>()),
  );

  gi.registerLazySingleton<Editprofileusecase>(
    () => Editprofileusecase(settingRepo: gi<SettingRepo>()),
  );

  gi.registerLazySingleton<UpdateLastConnectionUseCase>(
    () => UpdateLastConnectionUseCase(settingRepo: gi<SettingRepo>()),
  );
  gi.registerLazySingleton<AddProductUseCase>(
    () => AddProductUseCase(settingRepo: gi<SettingRepo>()),
  );
  gi.registerLazySingleton<StopInjectionUsecase>(
    () => StopInjectionUsecase(settingRepo: gi<SettingRepo>()),
  );
  gi.registerLazySingleton<GetInjectionUsecase>(
    () => GetInjectionUsecase(settingRepo: gi<SettingRepo>()),
  );

  gi.registerLazySingleton<GetHomeSectionUseCase>(
    () => GetHomeSectionUseCase(homeRepo: gi<HomeRepo>()),
  );

  gi.registerLazySingleton<AddProductStock>(
    () => AddProductStock(homeRepo: gi<HomeRepo>()),
  );

  gi.registerLazySingleton<AddOrderUseCase>(
    () => AddOrderUseCase(addOrderRepo: gi<AddOrderRepo>()),
  );

  /// 🔴 Orders UseCases
  gi.registerLazySingleton<getOrdersUseCase>(
    () => getOrdersUseCase(ordersRepo: gi<OrdersRepo>()),
  );

  gi.registerLazySingleton<GetOrdersPaginatedUseCase>(
    () => GetOrdersPaginatedUseCase(ordersRepo: gi<OrdersRepo>()),
  );

  gi.registerLazySingleton<FilterOrdersUseCase>(
    () => FilterOrdersUseCase(ordersRepo: gi<OrdersRepo>()),
  );

  gi.registerLazySingleton<SearchOrdersUseCase>(
    () => SearchOrdersUseCase(ordersRepo: gi<OrdersRepo>()),
  );

  /// 🔹 Profits
  gi.registerLazySingleton<ProfitsDataSource>(
    () => ProfitsDataSourceImp(gi<FirebaseFirestore>()),
  );

  gi.registerLazySingleton<ProfitsRepo>(
    () => ProfitsRepoImp(dataSource: gi<ProfitsDataSource>()),
  );

  gi.registerLazySingleton<GetSalesDataUseCase>(
    () => GetSalesDataUseCase(profitsRepo: gi<ProfitsRepo>()),
  );

  gi.registerLazySingleton<GetProductNamesUseCase>(
    () => GetProductNamesUseCase(profitsRepo: gi<ProfitsRepo>()),
  );
}
