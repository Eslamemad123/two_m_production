import 'package:flutter/material.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';

class photoEditProfile extends StatelessWidget {
  const photoEditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: AppColors.primarySoft,
            child: Text(
              'JD',
              style: AppFontStyles.getSize24(
                fontWeight: FontWeight.bold,
                fontColor: AppColors.primary,
              ),
            ),
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
