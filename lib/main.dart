import 'package:flutter/material.dart';

import 'package:projj/core/light_theme.dart';
import 'package:projj/core/dark_theme.dart';
import 'package:projj/core/theme_controller.dart';

import 'package:projj/screens/welcom_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ThemeController.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeNotifier,
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