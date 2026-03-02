import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/core/services/cache/LocalHelper.dart';
import 'package:two_m_production/features/pages/Home/Data/Model/productModel.dart';

abstract class SettingdataSource {
  Future<Either<Failure, bool>> editProfile(String name, String pathImage);
  Future<Either<Failure, bool>> updateLastConnection();

  Future<Either<Failure, bool>> addNewProduct(ProductModel product);

  Future<Either<Failure, bool>> NewInjectionMolding();
}

class SettingDataSourceImp extends SettingdataSource {
  @override
  Future<Either<Failure, bool>> NewInjectionMolding() {
    // TODO: implement NewInjectionMolding
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> addNewProduct(ProductModel product) async {
    try {
      var state = await FirebaseFirestore.instance.collection('Products');
      product.copyWith(id: state.doc().id);
      state.doc().set(product.toJson());

      return Right(true);
    } on Exception catch (e) {
      log(e.toString());
      return Left(Failure(message: 'Wrong'));
    }
  }

  @override
  Future<Either<Failure, bool>> editProfile(
    String name,
    String pathImage,
  ) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      Map<String, dynamic> updateData = {};

      if (name.isNotEmpty && name != '') {
        await user?.updateDisplayName(name);
        Localhelper.setString(Localhelper.kUserName, name);
        updateData['name'] = name;
      }

      if (pathImage.isNotEmpty && pathImage != '') {
        Localhelper.setString(Localhelper.kUserImage, pathImage);
        updateData['image'] = pathImage;
      }

      if (user != null && updateData.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .set(updateData, SetOptions(merge: true));
      }

      return Right(true);
    } on Exception catch (e) {
      log(e.toString());
      return Left(Failure(message: 'Wrong'));
    }
  }

  @override
  Future<Either<Failure, bool>> updateLastConnection() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('Users').doc(user.uid).set({
          'lastConnection': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
        return Right(true);
      }
      return Left(Failure(message: 'User no logged in'));
    } catch (e) {
      log(e.toString());
      return Left(Failure(message: 'Failed to update last connection'));
    }
  }
}
