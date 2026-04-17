import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class ProductFilterDropdown extends StatelessWidget {
  final List<String> productNames;
  final String? selectedProduct;
  final ValueChanged<String?> onChanged;

  const ProductFilterDropdown({
    super.key,
    required this.productNames,
    required this.selectedProduct,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.surface,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.border,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.04),
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String?>(
          value: selectedProduct,
          isExpanded: true,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: isDark ? AppColors.iconDark : AppColors.iconSecondary,
            size: 22.sp,
          ),
          dropdownColor: isDark ? AppColors.darkSurface : AppColors.surface,
          borderRadius: BorderRadius.circular(14.r),
          style: AppFontStyles.getSize14(
            fontColor: isDark ? AppColors.textOnDark : AppColors.textPrimary,
          ),
          hint: Row(
            children: [
              Icon(
                Icons.filter_list_rounded,
                size: 18.sp,
                color: AppColors.primary,
              ),
              SizedBox(width: 8.w),
              Text(
                LocaleKeys.profits_all_products.tr(),
                style: AppFontStyles.getSize14(
                  fontColor:
                      isDark ? AppColors.textOnDark : AppColors.textPrimary,
                ),
              ),
            ],
          ),
          items: [
            DropdownMenuItem<String?>(
              value: null,
              child: Row(
                children: [
                  Icon(
                    Icons.all_inclusive_rounded,
                    size: 18.sp,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: 8.w),
                  Text(LocaleKeys.profits_all_products.tr()),
                ],
              ),
            ),
            ...productNames.map((name) => DropdownMenuItem<String?>(
                  value: name,
                  child: Row(
                    children: [
                      Icon(
                        Icons.category_outlined,
                        size: 18.sp,
                        color: AppColors.secondaryNavy,
                      ),
                      SizedBox(width: 8.w),
                      Flexible(
                        child: Text(
                          name,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                )),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }
}
