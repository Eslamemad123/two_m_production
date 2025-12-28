import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0.r, top: 4.0.r),
      child: Text(
        title.toUpperCase(),
        style: AppFontStyles.getSize12(
          fontColor: AppColors.textSecondary,
          fontWeight: FontWeight.bold,
          fontSize: 11.sp,
        ),
      ),
    );
  }
}
