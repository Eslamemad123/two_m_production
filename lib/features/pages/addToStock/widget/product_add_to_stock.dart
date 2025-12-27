import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/constatnts/images.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/features/pages/addToStock/page/add_stock_sheet.dart';

class productAddToStock extends StatelessWidget {
  const productAddToStock({
    super.key,
    required this.isDark,
    required this.widget,
  });

  final bool isDark;
  final AddStockSheet widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurfaceAlt : AppColors.gray100,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Image.asset(AppAssets.smallRed),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.initialProductName ?? 'Nike Air Zoom ...',
                  style: AppFontStyles.getSize14(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Size: 10.5 \u2022 Red/Black',
                  style: AppFontStyles.getSize12(
                    fontColor: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: const Color(0xFFFFEBEE),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  size: 14.sp,
                  color: const Color(0xFFE53935),
                ),
                SizedBox(width: 4.w),
                Text(
                  '250  Stock',
                  style: TextStyle(
                    color: const Color(0xFFE53935),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
