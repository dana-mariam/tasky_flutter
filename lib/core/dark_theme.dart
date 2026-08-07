import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,

  // خلفية التطبيق
  scaffoldBackgroundColor: const Color(0xFF121212),

  // الـ AppBar
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF121212),
    foregroundColor: Colors.white,
    elevation: 0,
  ),

  // الألوان
  colorScheme: const ColorScheme.dark(
    primary: Colors.blue,
    onPrimary: Colors.white,

    surface: Color(0xFF1E1E1E),
    onSurface: Colors.white,

    outline: Colors.grey,
  ),

  // النصوص
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),

    bodyLarge: TextStyle(
      color: Colors.white,
    ),

    bodyMedium: TextStyle(
      color: Colors.grey,
    ),
  ),

  // الكروت
  cardTheme: CardThemeData(
    color: Color(0xFF1E1E1E),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),

  // Divider
  dividerTheme: const DividerThemeData(
    color: Colors.grey,
  ),

  // TextField
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFF1E1E1E),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  ),
);