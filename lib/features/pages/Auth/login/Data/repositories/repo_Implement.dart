import 'package:dartz/dartz.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/features/pages/Auth/login/Data/datasources/dataSouce.dart';
import 'package:two_m_production/features/pages/Auth/login/Domain/repositories/repo_abstract.dart';

class AuthRepoImp implements AuthRepo {
  final AuthDataSourc dataSource;

  AuthRepoImp({required this.dataSource});
  @override
  Future<Either<Failure, bool>> loginRepo(String email,String password) {
       return dataSource.loginDataSource(email, password);
  }
}
