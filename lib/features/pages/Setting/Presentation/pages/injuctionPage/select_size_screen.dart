import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:two_m_production/core/constatnts/images.dart';
import 'package:two_m_production/core/routes/navigation.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/routes/routes.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:two_m_production/features/pages/Setting/Presentation/widget/injuction/select_size_injection_page.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class SelectSizeScreen extends StatelessWidget {
  const SelectSizeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.textPrimary,
            size: 20.sp,
          ),
          onPressed: () {
            context.pop();
          },
        ),
        title: Text(
          LocaleKeys.sizes_select_size_title.tr(),
          style: AppFontStyles.getSize18(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          children: [
            selectSizeInjectionPage(
              onPress: () {
                pushTo(context, Routes.countingSession, {
                  "image": AppAssets.smallRed,
                  "name": "Small",
                });
              },

              title: LocaleKeys.sizes_small.tr(),
              subtitle: LocaleKeys.sizes_two_m_cover.tr(),
              imageWidget: Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(
                    0xFFFAFAFA,
                  ), // Approximate average color from the small image
                ),
                child: Center(
                  child: Image.asset(AppAssets.smallRed, fit: BoxFit.cover),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            selectSizeInjectionPage(
              onPress: () {
                pushTo(context, Routes.countingSession, {
                  "image": AppAssets.middle2,
                  "name": "Middle",
                });
              },

              title: LocaleKeys.sizes_middle.tr(),
              subtitle: LocaleKeys.sizes_two_m_cover.tr(),
              imageWidget: Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFFAFAFA), // Approximate average color
                ),
                child: Center(
                  child: Image.asset(AppAssets.middle2, fit: BoxFit.cover),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            selectSizeInjectionPage(
              onPress: () {
                pushTo(context, Routes.countingSession, {
                  "image": AppAssets.large2,
                  "name": "Large",
                });
              },
              title: LocaleKeys.sizes_large.tr(),
              subtitle: LocaleKeys.sizes_two_m_cover.tr(),
              imageWidget: Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFFAFAFA), // Approximate average color
                ),
                child: Center(
                  child: Image.asset(AppAssets.large1, fit: BoxFit.cover),
                ),
              ),
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}
