// lib/app/theme.dart
import 'package:flutter/material.dart';

ThemeData buildTheme() {
  const primary = Color(0xFF4F6D7A);
  const secondary = Color(0xFF56B5A6);
  const surface = Color(0xFFF7FAFC);
  const error = Color(0xFFB00020);

  final base = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: primary).copyWith(
      primary: primary,
      secondary: secondary,
      surface: surface,
      error: error,
    ),
    useMaterial3: true,
    scaffoldBackgroundColor: surface,
  );

  return base.copyWith(
    appBarTheme: const AppBarTheme(centerTitle: false, elevation: 0),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: secondary,
      unselectedItemColor: Colors.grey,
    ),
  );
}
