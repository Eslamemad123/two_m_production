import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:two_m_production/core/routes/routes.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class SettingProfileCart extends StatelessWidget {
  const SettingProfileCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28.r,
            backgroundColor: AppColors.primarySoft,
            child: Text(
              'JD',
              style: AppFontStyles.getSize18(
                fontWeight: FontWeight.bold,
                fontColor: AppColors.primary,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'John Doe',
                  style: AppFontStyles.getSize16(fontWeight: FontWeight.bold),
                ),
                Text(
                  LocaleKeys.profile_store_manager.tr(),
                  style: AppFontStyles.getSize12(
                    fontColor: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              GoRouter.of(context).push(Routes.editProfile);
            },
            icon: Icon(Icons.edit, color: AppColors.primary, size: 20.sp),
          ),
        ],
      ),
    );
  }
}
