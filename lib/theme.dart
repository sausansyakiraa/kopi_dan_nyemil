import 'package:flutter/material.dart';

class AppColors {
  static const ink = Color(0xFF1B1B1B);
  static const cream = Color(0xFFFFF6EC);
  static const card = Color(0xFFFFF1E2);
  static const peach = Color(0xFFF7D9B8);
  static const brown = Color(0xFF8A4B14);
  static const border = Color(0xFFE6D5C3);
  static const muted = Color(0xFF6B6259);
  static const mint = Color(0xFFB4F0CC);
  static const mintDark = Color(0xFF0B6B3A);
}

ThemeData buildTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: AppColors.brown,
    brightness: Brightness.light,
  ).copyWith(primary: AppColors.ink, surface: AppColors.cream);

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: AppColors.cream,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.cream,
      foregroundColor: AppColors.ink,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.ink, width: 1.5),
      ),
    ),
    navigationBarTheme: const NavigationBarThemeData(
      backgroundColor: Colors.white,
      indicatorColor: AppColors.ink,
    ),
  );
}