import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:two_m_production/core/constatnts/images.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.buttonText,
    this.width,
    this.height,
    required this.onPressed,
    this.buttomColor = AppColors.primary,
    this.textColor = AppColors.textOnPrimary,
    this.borderColor,
    this.borderRadius,
    this.alph = 0.4,
    this.isLoading=false,
  });
  final Color buttomColor;
  final double? borderRadius;
  final Color textColor;
  final Color? borderColor;
  final String buttonText;
  final double? width;
  final double? height;
  final double? alph;
  final bool isLoading;

  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.r), // مساحة للشادو
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 55.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 15.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: alph),
              blurRadius: 6.r,
              offset: const Offset(0, 4), // لتحت فقط
            ),
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0, // مهم جدًا
            shadowColor: Colors.transparent, // مهم جدًا
            backgroundColor: buttomColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 15.r),
              side: BorderSide(color: borderColor ?? Colors.transparent),
            ),
          ),
          onPressed: onPressed,
          child: isLoading ? Lottie.asset(AppAssets.loadingSplashJSON)
          :Text(
            buttonText,
            style: AppFontStyles.getSize18(
              fontColor: textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
