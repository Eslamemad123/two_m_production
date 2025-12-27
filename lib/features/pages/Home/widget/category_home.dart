import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class CategoryHome extends StatefulWidget {
  final Function(int) onCategorySelected;
  const CategoryHome({super.key, required this.onCategorySelected});

  @override
  State<CategoryHome> createState() => _CategoryHomeState();
}

class _CategoryHomeState extends State<CategoryHome> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      LocaleKeys.home_categories_all_items.tr(),
      LocaleKeys.home_categories_new_arrivals.tr(),
      LocaleKeys.home_categories_low_stock.tr(),
      "ffff",
    ];

    return SizedBox(
      height: 50.h,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 0.w),
        child: Row(
          children: List<Widget>.generate(categories.length, (index) {
            final isSelected = _selectedIndex == index;
            return Padding(
              padding: EdgeInsets.only(
                right: index < categories.length - 1 ? 10.w : 0,
              ),
              child: ChoiceChip(
                showCheckmark: false,
                selectedShadowColor: AppColors.primary,
                label: Text(categories[index]),

                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    _selectedIndex = index;
                  });
                  widget.onCategorySelected(index);
                },
                labelStyle: AppFontStyles.getSize14(
                  fontWeight: FontWeight.w600,
                  fontColor: isSelected
                      ? AppColors.white
                      : AppColors.textSecondary,
                ),
                backgroundColor: AppColors.white,
                selectedColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                  side: BorderSide(
                    color: isSelected ? Colors.transparent : AppColors.border,
                  ),
                ),
                elevation: isSelected ? 4.r : 0,
                shadowColor: AppColors.primary.withOpacity(0.3),
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 7.h),
              ),
            );
          }),
        ),
      ),
    );
  }
}
