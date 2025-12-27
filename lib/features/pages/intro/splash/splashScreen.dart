import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:two_m_production/core/constatnts/images.dart';
import 'package:two_m_production/core/routes/navigation.dart';
import 'package:two_m_production/core/routes/routes.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:gap/gap.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      pushTo(context, Routes.login);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Lottie.asset(
            AppAssets.logoLottieJSON,
            repeat: false,
            backgroundLoading: true,
          ),
          Gap(10),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '2M',
                  style: AppFontStyles.getSize24(
                    fontColor: AppColors.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextSpan(
                  text: ' Production',
                  style: AppFontStyles.getSize24(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Gap(25),
          Text(
            LocaleKeys.splash_text.tr(),
            style: AppFontStyles.getSize14(fontColor: AppColors.textHint),
            textAlign: TextAlign.center,
          ),
          Spacer(),
          SizedBox(
            height: 80.h,
            width: 150.w,
            child: Lottie.asset(AppAssets.loadingSplashJSON),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          ' By Eslam Emad ',
          style: AppFontStyles.getSize14(
            fontWeight: FontWeight.w400,
            fontColor: AppColors.gray500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
