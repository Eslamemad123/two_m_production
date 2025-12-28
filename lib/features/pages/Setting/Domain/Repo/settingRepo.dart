import 'package:dartz/dartz.dart';
import 'package:two_m_production/core/error/failer.dart';

abstract class SettingRepo {
  Future<Either<Failure, bool>> editProfile(String name,String pathImage);

  Future<Either<Failure, bool>> addNewProduct();
  
  Future<Either<Failure, bool>> NewInjectionMolding();
}
