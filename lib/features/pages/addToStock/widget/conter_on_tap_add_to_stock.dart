import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/utils/colors.dart';

class conterOnTapAddToStock extends StatelessWidget {
  const conterOnTapAddToStock({
    super.key,
    required this.context,
    required this.icon,
    required this.onTap,
    required this.isOutlined,
  });

  final BuildContext context;
  final IconData icon;
  final VoidCallback onTap;
  final bool isOutlined;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48.w,
        height: 48.w,
        decoration: BoxDecoration(
          color: isOutlined ? Colors.transparent : const Color(0xFFE53935),
          border: isOutlined ? Border.all(color: AppColors.borderLight) : null,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(icon, color: isOutlined ? Colors.black : Colors.white),
      ),
    );
  }
}
