import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class ProductDetailsSize extends StatelessWidget {
  final int selectedSizeIndex;
  final int stockCount;

  const ProductDetailsSize({
    super.key,
    required this.selectedSizeIndex,
    required this.stockCount,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> sizes = ['S', 'M', 'L', 'XL'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LocaleKeys.product_details_available_sizes.tr(),
              style: AppFontStyles.getSize16(fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${LocaleKeys.product_details_in_stock.tr()}: ${stockCount}',
                style: AppFontStyles.getSize16(
                  fontColor: AppColors.success,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: List.generate(sizes.length, (index) {
            final isSelected = selectedSizeIndex == index;
            return Container(
              margin: EdgeInsets.only(right: 12.w),
              width: 50.w,
              height: 50.h,
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.transparent
                    : Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: isSelected ? Colors.red : AppColors.gray300,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    sizes[index],
                    style: AppFontStyles.getSize14(
                      fontWeight: FontWeight.w600,
                      fontColor: isSelected
                          ? AppColors.primaryDark
                          : AppColors.gray400,
                    ),
                  ),
                  if (isSelected)
                    Text(
                      '24 ${LocaleKeys.product_details_qty.tr()}',
                      style: TextStyle(
                        fontSize: 8.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
