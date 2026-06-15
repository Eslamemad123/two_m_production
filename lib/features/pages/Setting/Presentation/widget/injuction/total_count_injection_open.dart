import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/features/pages/Setting/Presentation/cubit/settingCubit.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class TotalCountInjectionOpen extends StatelessWidget {
  const TotalCountInjectionOpen({super.key, required this.cubit});

  final SettingCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.05),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Number Ingection : ${cubit.openRecord!.numberInjection}',
            style: AppFontStyles.getSize14(
              fontColor: AppColors.iconPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            cubit.openRecord!.totalCount,
            style: AppFontStyles.getSize32(
              fontWeight: FontWeight.w900,
              fontColor: AppColors.primary,
            ).copyWith(fontSize: 64.sp),
          ),
          Text(
            LocaleKeys.counting_session_total_pieces.tr(),
            style: AppFontStyles.getSize14(
              fontColor: AppColors.iconPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 24.h),
          const Divider(color: AppColors.borderLight),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 16.sp,
                color: AppColors.iconPrimary,
              ),
              SizedBox(width: 8.w),
              Text(
                cubit.openRecord!.startDate,
                style: AppFontStyles.getSize14(
                  fontColor: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
