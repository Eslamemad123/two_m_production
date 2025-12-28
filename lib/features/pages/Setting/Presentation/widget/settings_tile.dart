import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';

class SettingsTile extends StatelessWidget {
  final IconData? icon;
  final Widget? customIcon;
  final String title;
  final Widget? trailing;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final VoidCallback onTap;

  const SettingsTile({
    super.key,
    this.icon,
    this.customIcon,
    required this.title,
    this.trailing,
    this.iconColor,
    this.iconBackgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: 12.0.r),
        child: Row(
          children: [
            // Icon Container
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconBackgroundColor ?? AppColors.gray50,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                child:
                    customIcon ??
                    Icon(icon, color: iconColor ?? AppColors.primary, size: 22.r),
              ),
            ),
             SizedBox(width: 16.w),

            // Title
            Expanded(
              child: Text(
                title,
                style: AppFontStyles.getSize14(fontWeight: FontWeight.w600),
              ),
            ),

            // Trailing
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
