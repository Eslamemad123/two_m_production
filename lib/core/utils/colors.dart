import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ==================================================
  // PRIMARY (Brand)
  // ==================================================

  /// Primary brand color (Red)
  static const Color primary = Color(0xFFE53935);
  static const Color primaryLight = Color(0xFFFF4D4D);
  static const Color primaryDark = Color(0xFFB3121D);
  static const Color primarySoft = Color(0xFFFFE5E7);
  static const Color primaryOpacity = Color(0x33E51C2A);
  static const Color black = Color.fromARGB(255, 0, 0, 0);

  // ==================================================
  // SECONDARY / ACCENT
  // ==================================================

  /// Indigo / Navy used in headers & cards
  static const Color secondaryNavy = Color(0xFF260B80);
  static const Color secondaryNavyLight = Color(0xFF3B3F6B);
  static const Color secondaryNavyDark = Color(0xFF1B075C);
  static const Color secondaryNavyOpacity = Color(0x33260B80);

  /// Gray-blue for inactive UI
  static const Color secondaryGrayBlue = Color(0xFF9AA4B2);

  // ==================================================
  // BACKGROUND & SURFACE
  // ==================================================

  static const Color background = Color(0xFFF7F8FA);
  static const Color backgroundSoft = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceAlt = Color(0xFFF1F3F5);

  /// Dark mode backgrounds
  /// Dark mode backgrounds
  static const Color darkBackground = Color(0xFF151B25); // Rich Dark Blue
  static const Color darkSurface = Color(
    0xFF1E2532,
  ); // Slightly lighter for cards
  static const Color darkSurfaceAlt = Color(
    0xFF2C3444,
  ); // For input fields/secondary

  // ==================================================
  // TEXT COLORS
  // ==================================================

  static const Color textPrimary = Color(0xFF1C1C1E);
  static const Color textSecondary = Color(0xFF6E6E73);
  static const Color textHint = Color(0xFF9E9E9E);
  static const Color textDisabled = Color(0xFFBDBDBD);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnDark = Color(0xFFEDEDED);

  // ==================================================
  // STATUS COLORS
  // ==================================================

  static const Color success = Color(0xFF34d058);
  static const Color successSoft = Color(0xFFE8F8F0);

  static const Color warning = Color.fromARGB(255, 231, 173, 0);
  static const Color warningSoft = Color(0xFFFFF4D6);

  static const Color error = Color(0xFFD32F2F);
  static const Color errorSoft = Color(0xFFFFEBEE);

  static const Color info = Color(0xFF2196F3);
  static const Color infoSoft = Color(0xFFE3F2FD);

  // ==================================================
  // GRAY SCALE (VERY IMPORTANT)
  // ==================================================

  static const Color gray50 = Color(0xFFF9FAFB);
  static const Color gray100 = Color(0xFFF1F3F5);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray300 = Color(0xFFD1D5DB);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray800 = Color(0xFF1F2937);
  static const Color gray900 = Color(0xFF111827);

  // ==================================================
  // BORDERS / DIVIDERS / SHADOWS
  // ==================================================

  static const Color border = Color(0xFFE0E0E0);
  static const Color borderLight = Color(0xFFF0F0F0);
  static const Color divider = Color(0xFFEAEAEA);
  static const Color shadow = Color(0x33000000);
  static const Color transparent = Color(0x00000000);

  // ==================================================
  // ICON COLORS
  // ==================================================

  static const Color iconPrimary = Color(0xFF1C1C1E);
  static const Color iconSecondary = Color(0xFF6E6E73);
  static const Color iconDisabled = Color(0xFFBDBDBD);
  static const Color white = Color(0xFFFFFFFF);

  // ==================================================
  // OVERLAYS & STATES
  // ==================================================

  static const Color overlay = Color(0x66000000);
  static const Color ripple = Color(0x1FE51C2A);
  static const Color hover = Color(0x14E51C2A);
  static const Color focus = Color(0x29E51C2A);
}
