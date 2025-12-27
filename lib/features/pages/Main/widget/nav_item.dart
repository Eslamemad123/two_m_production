import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:two_m_production/core/utils/colors.dart';

class NavItem extends StatelessWidget {
  final String selectedIcon;
  final String unselectedIcon;
  final String label;
  final bool isSelected;

  const NavItem({
    required this.selectedIcon,
    required this.unselectedIcon,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          isSelected ? selectedIcon : unselectedIcon,
          width: isSelected ? 24.w : 18.w,
          height: isSelected ? 24.w : 18.w,
          colorFilter: ColorFilter.mode(
            isSelected ? AppColors.primary : AppColors.gray500,
            BlendMode.srcIn,
          ),
        ),
         SizedBox(height: 4.h),

        if (!isSelected)
          Text(label, style: TextStyle(fontSize: 12.sp, color: AppColors.gray500)),

        if (isSelected) ...[
          const SizedBox(height: 5),
          Container(
            width: 5.w,
            height: 5.w,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ],
    );
  }
}
