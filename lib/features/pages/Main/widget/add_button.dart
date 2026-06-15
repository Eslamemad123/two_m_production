import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:two_m_production/core/utils/colors.dart';

class CenterAddButton extends StatelessWidget {
  final String icon;
  final bool isSelected;
  final VoidCallback onTap;

  const CenterAddButton({
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 45.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : AppColors.primary,
                shape: BoxShape.circle,
                border: isSelected
                    ? Border.all(color: AppColors.primary, width: 1.w)
                    : null,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha:0.28),
                    blurRadius: 15.r,
                    spreadRadius: 2.r,
                  ),
                ],
              ),
              child: Center(
                child: SvgPicture.asset(
                  icon,
                  width: 24.w,
                  height: 24.w,
                  colorFilter: ColorFilter.mode(
                    isSelected ? AppColors.primary : Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
