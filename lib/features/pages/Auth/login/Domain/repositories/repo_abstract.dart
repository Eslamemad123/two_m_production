import 'package:dartz/dartz.dart';
import 'package:two_m_production/core/error/failer.dart';

abstract class AuthRepo {
  Future<Either<Failure, bool>> loginRepo(String email,String password);
}
