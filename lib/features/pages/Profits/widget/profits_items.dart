import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/features/pages/Profits/widget/stat_card.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class ProfitsItems extends StatelessWidget {
  const ProfitsItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: StatCard(
                icon: Icons.shopping_bag_outlined,
                iconColor: AppColors.secondaryNavy,
                iconBgColor: AppColors.backgroundSoft,
                value: '1,245',
                label: LocaleKeys.profits_total_orders.tr(),
                percentage: '\u2191 8%',
                isPositive: true,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: StatCard(
                icon: Icons.person_add_outlined,
                iconColor: AppColors.primary,
                iconBgColor: AppColors.backgroundSoft,
                value: '342', // Typo fix in color below
                label: LocaleKeys.profits_new_customers.tr(),
                percentage: '\u2193 2%',
                isPositive: false,
              ),
            ),
          ],
        ),
        // Bottom spacing for navigation bar safety
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: StatCard(
                icon: Icons.production_quantity_limits,
                iconColor: AppColors.secondaryNavy,
                iconBgColor: AppColors.backgroundSoft,
                value: '1,245',
                label: LocaleKeys.profits_total_orders.tr(),
                percentage: '\u2191 8%',
                isPositive: true,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: StatCard(
                icon: Icons.category_outlined,
                iconColor: AppColors.primary,
                iconBgColor: AppColors.backgroundSoft,
                value: '342', // Typo fix in color below
                label: LocaleKeys.profits_new_customers.tr(),
                percentage: '\u2193 2%',
                isPositive: false,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
