import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/features/pages/Home/widget/category_home.dart';
import 'package:two_m_production/features/pages/Home/widget/grid_item_home.dart';

import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.home_welcome_back.tr(),
                          style: AppFontStyles.getSize24(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gap(4.h),
                        Text(
                          //date now ==taskati
                          LocaleKeys.home_store_name.tr(),
                          style: AppFontStyles.getSize14(
                            fontColor: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Gap(8.w),
                    //  NotificationButton(),
                  ],
                ),
                Gap(24.h),
                //  SearchBar(),
                Gap(10.h),

                CategoryHome(onCategorySelected: (index) {}),
                Gap(10.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LocaleKeys.home_inventory_overview.tr(),
                      style: AppFontStyles.getSize18(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      LocaleKeys.common_see_all.tr(),
                      style: AppFontStyles.getSize14(
                        fontColor: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Gap(16.h),

                GridItemHome(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
