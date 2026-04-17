import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/components/App_Bar/app__bar.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/features/pages/Profits/Presentation/cubit/profitsCubit.dart';
import 'package:two_m_production/features/pages/Profits/Presentation/cubit/profitsState.dart';
import 'package:two_m_production/features/pages/Profits/widget/product_filter_dropdown.dart';
import 'package:two_m_production/features/pages/Profits/widget/profit_summary_card.dart';
import 'package:two_m_production/features/pages/Profits/widget/sales_chart.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class ProfitsScreen extends StatelessWidget {
  const ProfitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfitsCubit()..loadData(),
      child: const _ProfitsScreenBody(),
    );
  }
}

class _ProfitsScreenBody extends StatelessWidget {
  const _ProfitsScreenBody();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: NewAppBar(title: LocaleKeys.profits_sales_overview.tr()),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocBuilder<ProfitsCubit, ProfitsState>(
        builder: (context, state) {
          if (state is ProfitsLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (state is ProfitsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    size: 48.sp,
                    color: AppColors.error,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    state.message,
                    style: AppFontStyles.getSize16(
                      fontColor: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<ProfitsCubit>().loadData();
                    },
                    icon: const Icon(Icons.refresh_rounded),
                    label: Text(LocaleKeys.common_back.tr()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is ProfitsLoaded) {
            return SafeArea(
              child: RefreshIndicator(
                onRefresh: () => context.read<ProfitsCubit>().loadData(),
                color: AppColors.primary,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.all(20.0.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Summary Card
                        ProfitSummaryCard(
                          totalPieces: state.totalPieces,
                          totalRevenue: state.totalRevenue,
                          totalOrders: state.totalOrders,
                        ),
                        SizedBox(height: 20.h),

                        // Product Filter
                        ProductFilterDropdown(
                          productNames: state.productNames,
                          selectedProduct: state.selectedProduct,
                          onChanged: (product) {
                            context.read<ProfitsCubit>().filterByProduct(
                              product,
                            );
                          },
                        ),
                        SizedBox(height: 20.h),

                        // Sales Chart
                        Container(
                          padding: EdgeInsets.all(20.r),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(24.r),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black.withOpacity(
                                  isDark ? 0.2 : 0.05,
                                ),
                                blurRadius: 15.r,
                                offset: Offset(0, 5.h),
                              ),
                            ],
                          ),
                          child: SalesChart(
                            dailySales: state.dailySales,
                            isWeekly: state.isWeekly,
                            onToggleWeekly: () {
                              if (!state.isWeekly) {
                                context.read<ProfitsCubit>().togglePeriod(true);
                              }
                            },
                            onToggleMonthly: () {
                              if (state.isWeekly) {
                                context.read<ProfitsCubit>().togglePeriod(
                                  false,
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
