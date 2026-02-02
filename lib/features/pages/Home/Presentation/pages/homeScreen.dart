import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:two_m_production/core/constatnts/images.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/features/pages/Home/Presentation/cubit/homeCubit.dart';
import 'package:two_m_production/features/pages/Home/Presentation/cubit/homeState.dart';
import 'package:two_m_production/features/pages/Home/Presentation/widget/category_home.dart';
import 'package:two_m_production/features/pages/Home/Presentation/widget/grid_item_home.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocProvider(
          create: (_) => HomeCubit()..getHomeSection(),
          child: Builder(
            builder: (context) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
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
                                ' 2M Covers Fire Production',
                                style: AppFontStyles.getSize14(
                                  fontColor: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Gap(8.w),
                        ],
                      ),
                    ),
                    Gap(35.h),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 10.0),
                      child: CategoryHome(onCategorySelected: (_) {}),
                    ),
                    Gap(10.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
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
                    ),
                    Gap(16.h),
                    BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        final cubit = context.watch<HomeCubit>();

                        if (state is HomeLoadingState) {
                          return Padding(
                            padding: EdgeInsetsDirectional.only(
                              top: 40.h,
                              start: 20,
                              end: 20,
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        if (state is HomeErrorState) {
                          log(state.error);
                          return Center(
                            child: Lottie.asset(AppAssets.emptyRedJSON),
                          );
                        }
                        if (cubit.products.isEmpty) {
                          return Center(
                            child: Lottie.asset(AppAssets.emptyRedJSON),
                          );
                        }
                        return Padding(
                          padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 20.0,
                          ),
                          child: GridItemHome(cubit: cubit),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
