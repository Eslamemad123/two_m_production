import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/utils/colors.dart';

class AppFontStyles {
  static TextStyle getSize12({
    double? fontSize,
    Color? fontColor = AppColors.textPrimary,
    FontWeight fontWeight = FontWeight.w400,
  }) => TextStyle(
    fontSize: fontSize ??= 12.sp,
    fontWeight: fontWeight,
    color: fontColor,
  );

  static TextStyle getSize14({
    double? fontSize,
    Color? fontColor = AppColors.textPrimary,
    FontWeight fontWeight = FontWeight.w500,
  }) => TextStyle(
    fontSize: fontSize ??= 14.sp,
    fontWeight: fontWeight,
    color: fontColor,
  );

  static TextStyle getSize16({
    double? fontSize,
    Color? fontColor = AppColors.textPrimary,
    FontWeight fontWeight = FontWeight.w400,
  }) => TextStyle(
    fontSize: fontSize ??= 16.sp,
    fontWeight: fontWeight,
    color: fontColor,
  );

  static TextStyle getSize18({
    double? fontSize,
    Color fontColor = AppColors.textPrimary,
    FontWeight fontWeight = FontWeight.w400,
  }) => TextStyle(
    fontSize: fontSize ??= 18.sp,
    fontWeight: fontWeight,
    color: fontColor,
  );

  static TextStyle getSize24({
    double? fontSize,
    Color fontColor = AppColors.textPrimary,
    FontWeight fontWeight = FontWeight.w500,
  }) => TextStyle(
    fontSize: fontSize ??= 24.sp,
    fontWeight: fontWeight,
    color: fontColor,
  );

  static TextStyle getSize32({
    double? fontSize,
    Color fontColor = AppColors.textPrimary,
    FontWeight fontWeight = FontWeight.w600,
  }) => TextStyle(
    fontWeight: fontWeight,
    fontSize: fontSize ??= 32.sp,
    color: fontColor,
  );
}
