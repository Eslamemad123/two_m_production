import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  bool? isOffline;
  @override
  void initState() {
    super.initState();
    listenInternet();
  }

  void listenInternet() {
    _subscription = Connectivity().onConnectivityChanged.listen((results) {
      bool offline = results.contains(ConnectivityResult.none);

      setState(() {
        isOffline = offline;
      });
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool offline = isOffline ?? false;
    
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        // Set transparent to let the banner or background show through.
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: Stack(
        children: [
          BlocProvider(
            create: (_) => HomeCubit()..getHomeSection('2M Covers'),

            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
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
                          ],
                        ),
                      ],
                    ),
                  ),

                  Gap(15.h),

                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: 10,
                      end: 10,
                    ),
                    child: CategoryHome(onCategorySelected: (_) {}),
                  ),

                  Gap(10.h),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
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

                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      final cubit = context.watch<HomeCubit>();

                      if (state is HomeLoadingState) {
                        return Padding(
                          padding: EdgeInsets.only(top: 40.h),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      if (state is HomeErrorState) {
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
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: GridItemHome(cubit: cubit),
                      );
                    },
                  ),

                  Gap(12),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedSlide(
              offset: (isOffline ?? false)
                  ? const Offset(0, 0)
                  : const Offset(0, -1),
              duration: const Duration(milliseconds: 700),
              child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top,
                ),
                height: 70.h + MediaQuery.of(context).padding.top,
                width: double.infinity,
                color: Color(0xFFffc03d),
                alignment: Alignment.center,
                child: (isOffline ?? false)
                    ? Text(
                        textAlign: TextAlign.center,
                        "Offline mode \n Check the internet; these are not the final results.",
                        style: AppFontStyles.getSize14(),
                      )
                    : const SizedBox(),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}
