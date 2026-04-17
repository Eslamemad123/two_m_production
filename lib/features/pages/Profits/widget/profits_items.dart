import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/features/pages/Profits/widget/stat_card.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class ProfitsItems extends StatelessWidget {
  final int totalOrders;
  final double dailyAverage;
  final int totalPieces;

  const ProfitsItems({
    super.key,
    required this.totalOrders,
    required this.dailyAverage,
    required this.totalPieces,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: StatCard(
            icon: Icons.shopping_bag_outlined,
            iconColor: AppColors.secondaryNavy,
            iconBgColor: AppColors.backgroundSoft,
            value: totalOrders.toString(),
            label: LocaleKeys.profits_total_orders.tr(),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: StatCard(
            icon: Icons.show_chart_rounded,
            iconColor: AppColors.primary,
            iconBgColor: AppColors.primarySoft,
            value: dailyAverage.toStringAsFixed(1),
            label: LocaleKeys.profits_daily_average.tr(),
          ),
        ),
      ],
    );
  }
}
