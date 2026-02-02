import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/core/services/cache/LocalHelper.dart';

abstract class SettingdataSource {
  Future<Either<Failure, bool>> editProfile(String name, String pathImage);

  Future<Either<Failure, bool>> addNewProduct();

  Future<Either<Failure, bool>> NewInjectionMolding();
}

class SettingDataSourceImp extends SettingdataSource {
  @override
  Future<Either<Failure, bool>> NewInjectionMolding() {
    // TODO: implement NewInjectionMolding
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> addNewProduct() {
    // TODO: implement addNewProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> editProfile(
    String name,
    String pathImage,
  ) async {
    try {
      if (name.isNotEmpty && name != '') {
        await FirebaseAuth.instance.currentUser?.updateDisplayName(name);
        Localhelper.setString(Localhelper.kUserName, name);
      }

      if (pathImage.isNotEmpty && pathImage != '') {
        Localhelper.setString(Localhelper.kUserImage, pathImage);
      }
      return Right(true);
    } on Exception catch (e) {
      log(e.toString());
      return Left(Failure(message: 'Wrong'));
    }
  }
}
