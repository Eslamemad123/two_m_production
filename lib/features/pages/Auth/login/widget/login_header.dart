import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:two_m_production/core/constatnts/images.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(20.h),
        Text(
          LocaleKeys.auth_welcome_back.tr(),
          style: AppFontStyles.getSize24(fontWeight: FontWeight.w600),
        ),
        Gap(10.h),
        Text(
          LocaleKeys.auth_welcome_back_subtitle.tr(),
          style: AppFontStyles.getSize14(fontColor: AppColors.gray400),
        ),
        SizedBox(
          height: 200.h,
          width: 250.w,
          child: Image.asset(AppAssets.logo),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '2M',
                style: AppFontStyles.getSize18(
                  fontColor: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              TextSpan(
                text: ' Covers',
                style: AppFontStyles.getSize18(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        Gap(20.h),
      ],
    );
  }
}
