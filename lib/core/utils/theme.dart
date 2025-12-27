import 'package:flutter/material.dart';
import 'package:two_m_production/core/utils/colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    fontFamily: 'Manrope',
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondaryNavy,
      surface: AppColors.white,
      background: AppColors.background,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    cardColor: AppColors.white,
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    fontFamily: 'Manrope',
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondaryNavyLight,
      surface: AppColors.darkSurface,
      background: AppColors.darkBackground,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.white),
      titleTextStyle: TextStyle(
        color: AppColors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    cardColor: AppColors.darkSurface,
    dialogBackgroundColor: AppColors.darkSurface,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.darkSurface,
      modalBackgroundColor: AppColors.darkSurface,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColors.textOnDark),
      titleMedium: TextStyle(color: AppColors.textOnDark),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkSurface,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.gray500,
    ),
  );
}
