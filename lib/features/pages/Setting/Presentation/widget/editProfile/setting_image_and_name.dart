import 'dart:io';
import 'package:flutter/material.dart';
import 'package:two_m_production/core/services/cache/LocalHelper.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';

class SettingImageAndName extends StatelessWidget {
  SettingImageAndName({super.key, required this.radius, this.imagePath, this.userName});

  final double radius;
  final String? imagePath;
  final String? userName;

  @override
  Widget build(BuildContext context) {
    final String name = userName ?? Localhelper.getString(Localhelper.kUserName) ?? 'ES';
    final String path = imagePath ?? Localhelper.getString(Localhelper.kUserImage) ?? '';

    ImageProvider? imageProvider;
    if (path.isNotEmpty) {
      if (path.startsWith('http')) {
        imageProvider = NetworkImage(path);
      } else {
        imageProvider = FileImage(File(path));
      }
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.primarySoft,
      child: imageProvider != null
          ? CircleAvatar(
              backgroundColor: AppColors.primary,
              radius: 80,
              backgroundImage: imageProvider,
            )
          : Text(
              name.length >= 2 ? name.substring(0, 2).toUpperCase() : name.toUpperCase(),
              style: AppFontStyles.getSize24(
                fontWeight: FontWeight.bold,
                fontColor: AppColors.primary,
              ),
            ),
    );
  }
}
