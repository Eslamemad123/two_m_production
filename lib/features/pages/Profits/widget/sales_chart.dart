import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/features/pages/Profits/Presentation/cubit/profitsState.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class SalesChart extends StatelessWidget {
  final List<DailySalesData> dailySales;
  final bool isWeekly;
  final VoidCallback onToggleWeekly;
  final VoidCallback onToggleMonthly;

  const SalesChart({
    super.key,
    required this.dailySales,
    required this.isWeekly,
    required this.onToggleWeekly,
    required this.onToggleMonthly,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        // Header with title and toggle
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                LocaleKeys.profits_sales_overview.tr(),
                style: AppFontStyles.getSize18(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 8.w),
            _buildToggle(isDark),
          ],
        ),
        SizedBox(height: 24.h),

        // Chart
        SizedBox(
          height: 220.h,
          child: dailySales.isEmpty
              ? Center(
                  child: Text(
                    LocaleKeys.profits_no_data.tr(),
                    style: AppFontStyles.getSize14(
                      fontColor: AppColors.textSecondary,
                    ),
                  ),
                )
              : _buildChart(isDark),
        ),
      ],
    );
  }

  Widget _buildToggle(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurfaceAlt : AppColors.gray100,
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: EdgeInsets.all(3.r),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTab(
            LocaleKeys.profits_weekly_abbr.tr(),
            isWeekly,
            onToggleWeekly,
            isDark,
          ),
          _buildTab(
            LocaleKeys.profits_monthly_abbr.tr(),
            !isWeekly,
            onToggleMonthly,
            isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildTab(
    String text,
    bool isSelected,
    VoidCallback onTap,
    bool isDark,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? AppColors.primary : AppColors.white)
              : AppColors.transparent,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.08),
                    blurRadius: 4.r,
                    offset: Offset(0, 2.h),
                  ),
                ]
              : [],
        ),
        child: Text(
          text,
          style: AppFontStyles.getSize12(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            fontColor: isSelected
                ? (isDark ? AppColors.white : AppColors.textPrimary)
                : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildChart(bool isDark) {
    final maxPieces = dailySales
        .map((e) => e.totalPieces)
        .fold<int>(0, (a, b) => a > b ? a : b);
    final maxY = maxPieces == 0 ? 10.0 : (maxPieces * 1.3).ceilToDouble();

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: maxY,
        minY: 0,
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            tooltipRoundedRadius: 12.r,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final data = dailySales[groupIndex];
              return BarTooltipItem(
                '${data.dayLabel}\n${data.totalPieces} ${LocaleKeys.profits_pieces.tr()}',
                AppFontStyles.getSize12(
                  fontColor: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30.h,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= dailySales.length) {
                  return const SizedBox.shrink();
                }

                // For monthly view, show every 5th day label
                if (!isWeekly &&
                    index % 5 != 0 &&
                    index != dailySales.length - 1) {
                  return const SizedBox.shrink();
                }

                return Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Text(
                    dailySales[index].dayLabel,
                    style: TextStyle(
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondary.withOpacity(0.7),
                      fontSize: isWeekly ? 11.sp : 9.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40.w,
              interval: maxY > 0 ? (maxY / 4).ceilToDouble() : 1,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: TextStyle(
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondary.withOpacity(0.5),
                    fontSize: 10.sp,
                  ),
                );
              },
            ),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: maxY > 0 ? (maxY / 4).ceilToDouble() : 1,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: isDark
                  ? AppColors.borderDark.withOpacity(0.3)
                  : AppColors.borderLight,
              strokeWidth: 1,
            );
          },
        ),
        borderData: FlBorderData(show: false),
        barGroups: _buildBarGroups(isDark, maxY),
      ),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
    );
  }

  List<BarChartGroupData> _buildBarGroups(bool isDark, double maxY) {
    return List.generate(dailySales.length, (index) {
      final data = dailySales[index];
      final barWidth = isWeekly ? 24.0.w : 8.0.w;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: data.totalPieces.toDouble(),
            width: barWidth,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(6.r),
              topRight: Radius.circular(6.r),
            ),
            gradient: LinearGradient(
              colors: data.totalPieces > 0
                  ? [AppColors.primary, AppColors.primaryLight]
                  : [
                      (isDark ? AppColors.darkSurfaceAlt : AppColors.gray200),
                      (isDark ? AppColors.darkSurfaceAlt : AppColors.gray200),
                    ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: maxY,
              color: isDark
                  ? AppColors.darkSurfaceAlt.withOpacity(0.5)
                  : AppColors.gray100.withOpacity(0.5),
            ),
          ),
        ],
      );
    });
  }
}
