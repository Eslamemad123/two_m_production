import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class ButtonLogOut extends StatelessWidget {
  const ButtonLogOut({
    super.key,
  });
//TODO
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          elevation: 4,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout, size: 20.sp),
            SizedBox(width: 8.w),
            Text(
              LocaleKeys.settings_log_out.tr(),
              style: AppFontStyles.getSize16(
                fontWeight: FontWeight.bold,
                fontColor: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
