import 'package:flutter/material.dart';
import 'package:two_m_production/core/services/cache/LocalHelper.dart';

class ThemeManager {
  static final ValueNotifier<ThemeMode> themeMode = ValueNotifier(
    (Localhelper.getBool(Localhelper.kDarkMood) ?? false)
        ? ThemeMode.dark
        : ThemeMode.light,
  );

  static void toggleTheme(bool val) {
    themeMode.value = val ? ThemeMode.dark : ThemeMode.light;
    Localhelper.setBool(Localhelper.kDarkMood, val);
  }
}