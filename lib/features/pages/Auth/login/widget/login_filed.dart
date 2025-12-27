import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:two_m_production/components/inputs/main_text_form_field.dart';
import 'package:two_m_production/core/constatnts/images.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class LoginFiled extends StatelessWidget {
  const LoginFiled({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(10.h),
          Padding(
            padding: EdgeInsetsDirectional.only(start: 25.0.r, bottom: 5.r),
            child: Text(
              LocaleKeys.auth_email.tr(),
              style: AppFontStyles.getSize12(
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                fontColor: AppColors.gray500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: MainTextFormField(
              ispassword: false,
              prefixIcon: AppAssets.emailSVG,
              hint: LocaleKeys.auth_enter_email.tr(),
              textInputNext: TextInputAction.next,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(
              start: 25.0.r,
              bottom: 5.r,
              top: 20.r,
            ),
            child: Text(
              LocaleKeys.auth_password.tr(),
              style: AppFontStyles.getSize12(
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                fontColor: AppColors.gray500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: MainTextFormField(
              ispassword: true,
              prefixIcon: AppAssets.lock2SVG,
              hint: LocaleKeys.auth_enter_password.tr(),
              textInputNext: TextInputAction.done,
              onFieldSubmitted: (value) {
                FocusScope.of(context).unfocus();
              },
            ),
          ),
          Row(
            children: [
              Spacer(),
              Padding(
                padding: EdgeInsetsDirectional.only(top: 5.r, end: 20.r),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    LocaleKeys.auth_forget_password.tr(),
                    textAlign: TextAlign.end,
                    style: AppFontStyles.getSize12(
                      fontColor: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
