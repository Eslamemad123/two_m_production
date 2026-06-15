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
    fontFamily: 'Manrope',

    scaffoldBackgroundColor: AppColors.darkBackground,

    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      surface: AppColors.darkSurface,
      background: AppColors.darkBackground,
      onSurface: AppColors.textOnDark,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.textOnDark),
    ),

    cardColor: AppColors.darkSurface,

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.textOnDark),
      bodyMedium: TextStyle(color: AppColors.textOnDark),
      bodySmall: TextStyle(color: AppColors.textSecondaryDark),
      titleLarge: TextStyle(color: AppColors.textOnDark),
      titleMedium: TextStyle(color: AppColors.textOnDark),
      titleSmall: TextStyle(color: AppColors.textSecondaryDark),
    ),

    iconTheme: const IconThemeData(color: AppColors.iconDark),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkSurfaceAlt,

      hintStyle: const TextStyle(color: AppColors.textSecondaryDark),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.borderDark),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkSurface,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondaryDark,
      elevation: 0,
    ),

    listTileTheme: const ListTileThemeData(
      iconColor: AppColors.iconDark,
      textColor: AppColors.textOnDark,
    ),

    dividerColor: AppColors.borderDark,
  );
}
