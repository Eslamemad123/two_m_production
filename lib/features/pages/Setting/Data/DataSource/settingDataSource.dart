import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/core/extentions/image_upload.dart';
import 'package:two_m_production/core/services/cache/LocalHelper.dart';
import 'package:two_m_production/features/pages/Home/Data/Model/productModel.dart';
import 'package:two_m_production/features/pages/Setting/Data/Model/InjectionModel.dart'
    show InjectionModel;

abstract class SettingdataSource {
  Future<Either<Failure, bool>> editProfile(
    String name,
    String pathImage,
    BuildContext context,
  );
  Future<Either<Failure, bool>> updateLastConnection();
  Future<Either<Failure, Map<String, String>>> getProfileData();

  Future<Either<Failure, bool>> addNewProduct(ProductModel product);

  Future<Either<Failure, bool>> NewInjectionMolding(String product);
  Future<Either<Failure, Map<String, dynamic>>> getInjectionData(
    String product,
  );
}

class SettingDataSourceImp extends SettingdataSource {
  @override
  Future<Either<Failure, Map<String, String>>> getProfileData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return Left(Failure(message: 'User not logged in'));
      }

      final doc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .get();

      if (doc.exists && doc.data() != null) {
        final data = doc.data()!;
        final name = data['name']?.toString() ?? '';
        final image = data['image']?.toString() ?? '';

        if (name.isNotEmpty) {
          Localhelper.setString(Localhelper.kUserName, name);
        }
        if (image.isNotEmpty) {
          Localhelper.setString(Localhelper.kUserImage, image);
        }

        return Right({'name': name, 'image': image});
      }

      return Right({
        'name': Localhelper.getString(Localhelper.kUserName) ?? '',
        'image': Localhelper.getString(Localhelper.kUserImage) ?? '',
      });
    } catch (e) {
      log('getProfileData error: ${e.toString()}');
      return Right({
        'name': Localhelper.getString(Localhelper.kUserName) ?? '',
        'image': Localhelper.getString(Localhelper.kUserImage) ?? '',
      });
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> getInjectionData(
    String product,
  ) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final closedQuery = await firestore
          .collection('Injection')
          .where('product', isEqualTo: product)
          .where('state', isEqualTo: 'close')
          .orderBy('numberInjection', descending: true)
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
      log('000');
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      log('0');

      final dateOnly =
          "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";
      log('1');

      final query = await firestore
          .collection('Injection')
          .where('product', isEqualTo: product)
          .where('state', isEqualTo: 'open')
          .limit(1)
          .get();
      log('2');

      if (query.docs.isNotEmpty) {
        final doc = query.docs.first;
        log('3');

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
        log('4');

        await firestore
            .collection('Injection')
            .doc(doc.id)
            .update(updatedModel.toJson());
      }
      log('5');

      final lastQuery = await firestore
          .collection('Injection')
          .where('product', isEqualTo: product)
          .orderBy('numberInjection', descending: true)
          .limit(1)
          .get();

      int nextNumber = 1;
      log('6');

      if (lastQuery.docs.isNotEmpty) {
        final lastNumber = int.parse(
          lastQuery.docs.first['numberInjection'].toString(),
        );
        nextNumber = lastNumber + 1;
      }
      log('7');

      final newDoc = firestore.collection('Injection').doc();
      log('8');

      final newModel = InjectionModel(
        id: newDoc.id,
        product: product,
        startDate: dateOnly.toString(),
        state: 'open',
        totalCount: '0',
        numberInjection: nextNumber,
      );
      log('9');

      await newDoc.set(newModel.toJson());
      log('10');

      return const Right(true);
    } catch (e) {
      log('10');

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
    BuildContext context,
  ) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      Map<String, dynamic> updateData = {};

      if (name.isNotEmpty) {
        await user?.updateDisplayName(name);
        Localhelper.setString(Localhelper.kUserName, name);
        updateData['name'] = name;
      }

      if (pathImage.isNotEmpty) {
        // 1. تحويل المسار إلى File

        File imageFile = File(pathImage);

        // 2. رفع الصورة على Cloudinary
        String? imageUrl = await uploadImageToCloudinary(
          imageFile,
          context, // لو مش متاح احذفه من الفنكشن
        );

        // 3. تأكد إن الرفع تم
        if (imageUrl != null && imageUrl.isNotEmpty) {
          // خزّن اللينك بدل الباث
          Localhelper.setString(Localhelper.kUserImage, imageUrl);
          updateData['image'] = imageUrl;
        }
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
