import 'dart:async';
import 'dart:developer';

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
  final Connectivity _connectivity = Connectivity();
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
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: (isOffline ?? false) ? Colors.amber : Colors.white,
        statusBarIconBrightness: (isOffline ?? false)
            ? Brightness.dark
            : Brightness.dark,
        statusBarBrightness: (isOffline ?? false)
            ? Brightness.light
            : Brightness.dark,
      ),
    );
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Stack(
          children: [
            BlocProvider(
              create: (_) => HomeCubit()..getHomeSection('2M Covers'),

              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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

                              Text(
                                '2M Covers Fire Production',
                                style: AppFontStyles.getSize14(
                                  fontColor: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Gap(35.h),

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

                    Gap(16.h),

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
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: GridItemHome(cubit: cubit),
                        );
                      },
                    ),

                    Gap(15),
                  ],
                ),
              ),
            ),

            AnimatedSlide(
              offset: (isOffline ?? false)
                  ? const Offset(0, 0)
                  : const Offset(0, -1),
              duration: const Duration(milliseconds: 350),
              child: (isOffline ?? false)
                  ? Container(
                      height: 100,
                      width: double.infinity,
                      color: Colors.amber,
                      alignment: Alignment.center,
                      child: const Text("Offline mode — cached data"),
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
