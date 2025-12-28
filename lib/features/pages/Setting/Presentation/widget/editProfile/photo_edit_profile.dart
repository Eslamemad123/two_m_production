import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:two_m_production/core/extentions/imagePicker.dart';
import 'package:two_m_production/core/services/cache/LocalHelper.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/features/pages/Setting/Presentation/cubit/settingCubit.dart';
import 'package:two_m_production/features/pages/Setting/Presentation/widget/editProfile/setting_image_and_name.dart';

class photoEditProfile extends StatefulWidget {
  photoEditProfile({super.key, required this.cubit});
  SettingCubit cubit;

  @override
  State<photoEditProfile> createState() => _photoEditProfileState();
}

class _photoEditProfileState extends State<photoEditProfile> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          GestureDetector(
            onTap: () async {
              String? image = await UploadImage(false);
              setState(() {
                widget.cubit.patImage = image ?? '';
              });
            },
            child: SettingImageAndName(radius: 60,),
          ),
          Positioned(
            bottom: 2,
            right: 5,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
