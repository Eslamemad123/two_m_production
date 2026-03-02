import 'dart:io';
import 'package:flutter/material.dart';
import 'package:two_m_production/core/services/cache/LocalHelper.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';

class SettingImageAndName extends StatelessWidget {
  SettingImageAndName({super.key, required this.radius});

  final double radius;
  String name = Localhelper.getString(Localhelper.kUserName) ?? 'ES';
  String path = Localhelper.getString(Localhelper.kUserImage) ?? '';

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.primarySoft,
      child: (path.isNotEmpty && path != '')
          ? CircleAvatar(
              backgroundColor: AppColors.primary,
              radius: 80,
              backgroundImage: NetworkImage(path),
            )
          : Text(
              name.substring(0, 2).toUpperCase(),
              style: AppFontStyles.getSize24(
                fontWeight: FontWeight.bold,
                fontColor: AppColors.primary,
              ),
            ),
    );
  }
}
