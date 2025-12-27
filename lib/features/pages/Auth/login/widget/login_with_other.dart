import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:two_m_production/core/constatnts/images.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/features/pages/Auth/login/widget/logo_login.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class LoginWithOther extends StatelessWidget {
  const LoginWithOther({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Divider(
                thickness: 1,
                color: AppColors.gray300,
                indent: 20.w,
                endIndent: 20.w,
              ),
            ),
            Center(
              child: Text(
                LocaleKeys.auth_or_login_with.tr(),
                style: AppFontStyles.getSize12(fontColor: AppColors.gray400),
              ),
            ),
            Expanded(
              child: Divider(
                thickness: 1,
                color: AppColors.gray300,
                indent: 20.w,
                endIndent: 20.w,
              ),
            ),
          ],
        ),
        Gap(15),
        Row(
          children: [
            Spacer(),
            Expanded(
              child: LogoLogin(
                logo: SvgPicture.asset(AppAssets.facebookLogoSVG),
              ),
            ),
            Expanded(
              child: LogoLogin(logo: SvgPicture.asset(AppAssets.googleLogoSVG)),
            ),
            Expanded(
              child: LogoLogin(logo: SvgPicture.asset(AppAssets.appleLogoSVG)),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
