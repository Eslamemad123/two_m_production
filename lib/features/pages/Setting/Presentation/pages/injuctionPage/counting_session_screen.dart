import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:two_m_production/components/buttons/main_button.dart';
import 'package:two_m_production/core/constatnts/images.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:two_m_production/features/pages/Setting/Presentation/cubit/settingCubit.dart';
import 'package:two_m_production/features/pages/Setting/Presentation/cubit/settingState.dart';
import 'package:two_m_production/features/pages/Setting/Presentation/widget/injuction/count_injection_close.dart';
import 'package:two_m_production/features/pages/Setting/Presentation/widget/injuction/total_count_injection_open.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class CountingSessionScreen extends StatelessWidget {
  CountingSessionScreen({super.key, required this.image, required this.name});
  final String image;
  final String name;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingCubit()..getInjection(name),
      child: BlocBuilder<SettingCubit, SettingState>(
        builder: (context, state) {
          var cubit = context.read<SettingCubit>();
          if (state is SettingLoadingState) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          if (cubit.openRecord == null) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.white,
                elevation: 0,
                scrolledUnderElevation: 0,

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
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(
                    AppAssets.emptyRedJSON,
                    repeat: false,
                    backgroundLoading: true,
                  ),
                  SizedBox(height: 16.h),

                  MainButton(
                    buttonText: LocaleKeys.counting_session_end_session.tr(),
                    onPressed: () {
                      cubit.stopInjection(context, name);
                    },
                  ),
                  SizedBox(height: 32.h),
                ],
              ),
            );
          }
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              backgroundColor: AppColors.white,
              elevation: 0,
              scrolledUnderElevation: 0,

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
              title: Row(
                children: [
                  Container(
                    width: 32.w,
                    height: 32.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.gray200,
                    ),
                    child: Image.asset(image),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      name,
                      style: AppFontStyles.getSize16(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TotalCountInjectionOpen(cubit: cubit),
                  SizedBox(height: 24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocaleKeys.counting_session_recent_history.tr(),
                        style: AppFontStyles.getSize12(
                          fontColor: AppColors.textSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          LocaleKeys.counting_session_view_all.tr(),
                          style: AppFontStyles.getSize12(
                            fontColor: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cubit.closedRecords?.length ?? 0,
                    itemBuilder: (context, index) {
                      final record = cubit.closedRecords![index];

                      return CountInjectionClose(
                        injection: record.numberInjection,
                        totalCount: record.totalCount,
                        fromDate: record.startDate,
                        toDate: record.endDate ?? '',
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 12);
                    },
                  ),
                  SizedBox(height: 16.h),

                  MainButton(
                    buttonText: LocaleKeys.counting_session_end_session.tr(),
                    onPressed: () {
                      cubit.stopInjection(context, name);
                    },
                  ),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
