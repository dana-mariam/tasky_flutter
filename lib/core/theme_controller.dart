import 'package:flutter/material.dart';
import 'package:projj/screens/shared_pref_service.dart';

class ThemeController {
  static final ValueNotifier<ThemeMode> themeNotifier =
  ValueNotifier(ThemeMode.light);

  static Future<void> init() async {
    bool isDark =
        await SharedPrefService.getBool("darkMode") ?? false;

    themeNotifier.value =
    isDark ? ThemeMode.dark : ThemeMode.light;
  }

  static Future<void> changeTheme(bool isDark) async {
    await SharedPrefService.setBool("darkMode", isDark);

    themeNotifier.value =
    isDark ? ThemeMode.dark : ThemeMode.light;
  }
}