import 'package:flutter/material.dart';

class AppColors {
  // Main app background
  static const background = Color(0xFFF6F8FC);

  // Main brand colors
  static const primary = Color(0xFF315CFF);
  static const secondary = Color(0xFF5B4BDB);

  // Supporting colors
  static const coral = Color(0xFFFF7657);
  static const teal = Color(0xFF20B486);

  // Emergency
  static const emergency = Color(0xFFFF4D5E);

  // Text
  static const text = Color(0xFF172033);
  static const mutedText = Color(0xFF697386);

  // Surfaces
  static const white = Colors.white;
  static const card = Colors.white;
  static const border = Color(0xFFE7EAF0);
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    scaffoldBackgroundColor: AppColors.background,

    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    ),

    fontFamily: 'Roboto',

    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: AppColors.text,
        fontWeight: FontWeight.w800,
      ),
      headlineMedium: TextStyle(
        color: AppColors.text,
        fontWeight: FontWeight.w700,
      ),
      titleLarge: TextStyle(color: AppColors.text, fontWeight: FontWeight.w700),
      titleMedium: TextStyle(
        color: AppColors.text,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(color: AppColors.text),
      bodyMedium: TextStyle(color: AppColors.mutedText),
    ),

    cardTheme: CardThemeData(
      color: AppColors.card,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: const BorderSide(color: AppColors.border),
      ),
    ),
  );
}
