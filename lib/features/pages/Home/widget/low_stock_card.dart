import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class LowStockCard extends StatelessWidget {
  const LowStockCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: AppColors.primarySoft,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(
          LocaleKeys.home_low_stock.tr(),
          style: AppFontStyles.getSize12(
            fontColor: AppColors.primary,
            fontWeight: FontWeight.w600,
            fontSize: 10.sp,
          ),
        ),
      ),
    );
  }
}
