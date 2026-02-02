import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/features/pages/Home/Presentation/cubit/homeCubit.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class CategoryHome extends StatefulWidget {
  final Function(int) onCategorySelected;

  const CategoryHome({super.key, required this.onCategorySelected});

  @override
  State<CategoryHome> createState() => _CategoryHomeState();
}

class _CategoryHomeState extends State<CategoryHome> {
  late List<String> categories;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_initialized) {
      categories = [
        '2M Covers',
        'All products 2M',
        'Acrylic Sheets',
        'Low Stock',
        'Other',
      ];

      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<HomeCubit>();

    return SizedBox(
      height: 50.h,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(categories.length, (index) {
            final isSelected = cubit.selectedIndex == index;

            return Padding(
              padding: EdgeInsets.only(
                right: index < categories.length - 1 ? 10.w : 0,
              ),
              child: ChoiceChip(
                showCheckmark: false,
                label: Text(categories[index]),
                selected: isSelected,
                selectedColor: AppColors.primary,
                backgroundColor: AppColors.white,

                labelStyle: AppFontStyles.getSize14(
                  fontWeight: FontWeight.w600,
                  fontColor: isSelected
                      ? AppColors.white
                      : AppColors.textSecondary,
                ),

                onSelected: (_) {
                  setState(() {
                    final selectedCategory = categories.removeAt(index);
                    categories.insert(0, selectedCategory);
                    cubit.selectedIndex = 0;
                    cubit.categoryHomeKet = categories[0];
                    cubit.getHomeSection();
                  });

                  widget.onCategorySelected(0);
                },

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
