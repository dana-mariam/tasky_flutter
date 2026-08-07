import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:projj/core/light_theme.dart';
import 'package:projj/core/dark_theme.dart';
import 'package:projj/core/theme_notifier.dart';

import 'package:projj/screens/welcom_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  bool isDark = prefs.getBool("darkMode") ?? false;

  themeNotifier.value =
  isDark ? ThemeMode.dark : ThemeMode.light;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentTheme, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          theme: lightTheme,

          darkTheme: darkTheme,

          themeMode: currentTheme,

          home: const WelcomeScreen(),
        );
      },
    );
  }
}