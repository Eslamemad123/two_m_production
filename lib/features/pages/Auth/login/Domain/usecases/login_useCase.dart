import 'package:dartz/dartz.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/features/pages/Auth/login/Domain/repositories/repo_abstract.dart';

class AuthUseCase {
  final AuthRepo loginRepo;
  AuthUseCase({required this.loginRepo});
  Future<Either<Failure, bool>> call(String email,String password) {
    return loginRepo.loginRepo(email, password);
  }
}
