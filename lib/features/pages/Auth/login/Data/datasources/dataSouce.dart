import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:two_m_production/core/services/cache/LocalHelper.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

abstract class AuthDataSourc {
  Future<Either<Failure, bool>> loginDataSource(String email, String password);
}

class AuthDataSourcImp implements AuthDataSourc {
  @override
  Future<Either<Failure, bool>> loginDataSource(
    String email,
    String password,
  ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Force English locale format so Arabic numbers aren't used
        final now = DateFormat(
          'yyyy-MM-dd HH:mm:ss',
          'en',
        ).format(DateTime.now());
        await FirebaseFirestore.instance.collection('Users').doc(user.uid).set({
          'lastConnection': now,
        }, SetOptions(merge: true));
      }

      Localhelper.setString(
        Localhelper.kUserEmail,
        FirebaseAuth.instance.currentUser?.email ?? '',
      );

      Localhelper.setBool(Localhelper.kUserIsLogin, true);

      return Right(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return Left(Failure(message: LocaleKeys.firebase_invalidEmail.tr()));
      } else if (e.code == 'invalid-credential') {
        return Left(Failure(message: LocaleKeys.firebase_emailPassError.tr()));
      } else {
        log("ERROR CODE: ${e.code}");
        log("ERROR MESSAGE: ${e.message}");
      }

      return Left(
        Failure(message: e.message ?? LocaleKeys.firebase_authError.tr()),
      );
    }
  }
}
