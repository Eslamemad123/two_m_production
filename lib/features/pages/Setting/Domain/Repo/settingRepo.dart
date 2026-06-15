import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/features/pages/Home/Data/Model/productModel.dart';

abstract class SettingRepo {
  Future<Either<Failure, bool>> editProfile(String name, String pathImage,BuildContext context);
  Future<Either<Failure, bool>> updateLastConnection();
  Future<Either<Failure, Map<String, String>>> getProfileData();

  Future<Either<Failure, bool>> addNewProduct(ProductModel product);

  Future<Either<Failure, bool>> NewInjectionMolding(String product);
  Future<Either<Failure, Map<String, dynamic>>> getInjectionData(
    String product,
  );
}
