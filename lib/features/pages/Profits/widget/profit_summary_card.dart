import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class ProfitSummaryCard extends StatelessWidget {
  const ProfitSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2C), // Dark navy background matching design
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.profits_total_profit.tr(),
                    style: AppFontStyles.getSize14(fontColor: AppColors.white),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '\$21,350.54',
                    style: AppFontStyles.getSize32(
                      fontWeight: FontWeight.bold,
                      fontColor: AppColors.white,
                    ),
                  ),
                ],
              ),
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: const Icon(Icons.more_horiz, color: AppColors.white),
              ),
            ],
          ),

          SizedBox(height: 24.h),
          Row(
            children: [
              Expanded(
                child: _buildSubStat(
                  LocaleKeys.profits_revenue.tr(),
                  '\$45,231',
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: _buildSubStat(
                  LocaleKeys.profits_expenses.tr(),
                  '\$23,880',
                  isExpense: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubStat(String label, String value, {bool isExpense = false}) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFF2B2B3D),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppFontStyles.getSize12(
              fontColor: AppColors.textSecondary.withOpacity(0.7),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: AppFontStyles.getSize18(
              fontWeight: FontWeight.bold,
              fontColor: isExpense ? const Color(0xFFFF8A80) : AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
