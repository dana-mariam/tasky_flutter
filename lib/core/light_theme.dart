import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,

  // لون خلفية التطبيق
  scaffoldBackgroundColor: Colors.white,

  // لون الـ AppBar
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    elevation: 0,
  ),

  // ألوان عامة للتطبيق
  colorScheme: const ColorScheme.light(
    primary: Colors.blue,
    onPrimary: Colors.white,

    surface: Colors.white,
    onSurface: Colors.black,

    outline: Colors.grey,
  ),

  // النصوص
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),

    bodyLarge: TextStyle(
      color: Colors.black,
    ),

    bodyMedium: TextStyle(
      color: Colors.grey,
    ),
  ),

  // الكروت
  cardTheme: CardThemeData(
    color: Colors.grey.shade100,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),

  // الخطوط الفاصلة
  dividerTheme: const DividerThemeData(
    color: Colors.grey,
  ),

  // شكل الـ TextField
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  ),
);