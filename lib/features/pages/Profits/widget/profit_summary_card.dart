import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class ProfitSummaryCard extends StatelessWidget {
  final int totalPieces;
  final double totalRevenue;
  final int totalOrders;

  const ProfitSummaryCard({
    super.key,
    required this.totalPieces,
    required this.totalRevenue,
    required this.totalOrders,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E1E2C), Color(0xFF2B2040)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E1E2C).withOpacity(0.4),
            blurRadius: 20.r,
            offset: Offset(0, 8.h),
          ),
        ],
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
                    LocaleKeys.profits_total_pieces.tr(),
                    style: AppFontStyles.getSize14(
                      fontColor: AppColors.white.withOpacity(0.7),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _formatNumber(totalPieces),
                        style: AppFontStyles.getSize32(
                          fontWeight: FontWeight.bold,
                          fontColor: AppColors.white,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Padding(
                        padding: EdgeInsets.only(bottom: 4.h),
                        child: Text(
                          LocaleKeys.profits_pieces.tr(),
                          style: AppFontStyles.getSize14(
                            fontColor: AppColors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Icon(
                  Icons.trending_up_rounded,
                  color: AppColors.primaryLight,
                  size: 24.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Row(
            children: [
              Expanded(
                child: _buildSubStat(
                  LocaleKeys.profits_total_revenue.tr(),
                  '${_formatNumber(totalRevenue.toInt())} EGP',
                  Icons.attach_money_rounded,
                  const Color(0xFF4CAF50),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildSubStat(
                  LocaleKeys.profits_total_orders.tr(),
                  _formatNumber(totalOrders),
                  Icons.shopping_bag_outlined,
                  const Color(0xFF42A5F5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubStat(
    String label,
    String value,
    IconData icon,
    Color accentColor,
  ) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.07),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.white.withOpacity(0.05),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: accentColor, size: 16.sp),
              SizedBox(width: 6.w),
              Flexible(
                child: Text(
                  label,
                  style: AppFontStyles.getSize12(
                    fontColor: AppColors.white.withOpacity(0.5),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: AppFontStyles.getSize16(
              fontWeight: FontWeight.bold,
              fontColor: AppColors.white,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}k';
    }
    return number.toString();
  }
}
