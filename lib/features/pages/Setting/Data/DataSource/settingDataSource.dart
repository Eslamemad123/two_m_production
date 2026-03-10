import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/core/services/cache/LocalHelper.dart';
import 'package:two_m_production/features/pages/Home/Data/Model/productModel.dart';
import 'package:two_m_production/features/pages/Setting/Data/Model/InjectionModel.dart'
    show InjectionModel;

abstract class SettingdataSource {
  Future<Either<Failure, bool>> editProfile(String name, String pathImage);
  Future<Either<Failure, bool>> updateLastConnection();

  Future<Either<Failure, bool>> addNewProduct(ProductModel product);

  Future<Either<Failure, bool>> NewInjectionMolding(String product);
  Future<Either<Failure, Map<String, dynamic>>> getInjectionData(
    String product,
  );
}

class SettingDataSourceImp extends SettingdataSource {
  Future<Either<Failure, Map<String, dynamic>>> getInjectionData(
    String product,
  ) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final closedQuery = await firestore
          .collection('Injection')
          .where('product', isEqualTo: product)
          .where('state', isEqualTo: 'close')
          .orderBy('startDate', descending: true)
          .get();
      final closedList = closedQuery.docs
          .map((e) => InjectionModel.fromJson(e.data()))
          .toList();
      final openQuery = await firestore
          .collection('Injection')
          .where('product', isEqualTo: product)
          .where('state', isEqualTo: 'open')
          .limit(1)
          .get();

      InjectionModel? openRecord;
      if (openQuery.docs.isNotEmpty) {
        openRecord = InjectionModel.fromJson(openQuery.docs.first.data());
      }
      return Right({"open": openRecord, "closed": closedList});
    } catch (e) {
      log('--- 1 7---${e.toString()}-${product}');

      return Left(Failure(message: 'Wrong'));
    }
  }

  @override
  Future<Either<Failure, bool>> NewInjectionMolding(String product) async {
    try {
      final firestore = FirebaseFirestore.instance;

      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      final dateOnly =
          "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

      final query = await firestore
          .collection('Injection')
          .where('product', isEqualTo: product)
          .where('state', isEqualTo: 'open')
          .limit(1)
          .get();

      if (query.docs.isNotEmpty) {
        final doc = query.docs.first;

        final oldModel = InjectionModel.fromJson(doc.data());

        final updatedModel = InjectionModel(
          id: doc.id,
          product: oldModel.product,
          startDate: oldModel.startDate,
          endDate: dateOnly.toString(),
          state: 'close',
          totalCount: oldModel.totalCount,
          numberInjection: oldModel.numberInjection,
        );

        await firestore
            .collection('Injection')
            .doc(doc.id)
            .update(updatedModel.toJson());
      }
      final lastQuery = await firestore
          .collection('Injection')
          .where('product', isEqualTo: product)
          .orderBy('numberInjection', descending: true)
          .limit(1)
          .get();

      int nextNumber = 1;

      if (lastQuery.docs.isNotEmpty) {
        final lastNumber = int.parse(
          lastQuery.docs.first['numberInjection'].toString(),
        );
        nextNumber = lastNumber + 1;
      }

      final newDoc = firestore.collection('Injection').doc();

      final newModel = InjectionModel(
        id: newDoc.id,
        product: product,
        startDate: dateOnly.toString(),
        state: 'open',
        totalCount: '0',
        numberInjection: nextNumber.toString(),
      );

      await newDoc.set(newModel.toJson());

      return const Right(true);
    } catch (e) {
      log('${e.toString()}');
      return Left(Failure(message: 'Wrong'));
    }
  }

  @override
  Future<Either<Failure, bool>> addNewProduct(ProductModel product) async {
    try {
      var collection = FirebaseFirestore.instance.collection('Products');

      String id = collection.doc().id;

      product = product.copyWith(id: id);

      await collection.doc(id).set(product.toJson());

      return const Right(true);
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
