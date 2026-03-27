import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/features/pages/Setting/Domain/Repo/settingRepo.dart';

class Editprofileusecase {
  final SettingRepo settingRepo;
  Editprofileusecase({required this.settingRepo});

  Future<Either<Failure, bool>> call(String name, String pathImage,BuildContext context) {
    return settingRepo.editProfile(name, pathImage,context);
  }
}
