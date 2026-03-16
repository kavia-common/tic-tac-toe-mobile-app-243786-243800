import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color _primary = Color(0xFF3B82F6); // #3b82f6
  static const Color _secondary = Color(0xFF64748B); // #64748b
  static const Color _accent = Color(0xFF06B6D4); // #06b6d4
  static const Color _error = Color(0xFFEF4444); // #EF4444
  static const Color _background = Color(0xFFF9FAFB); // #f9fafb
  static const Color _surface = Color(0xFFFFFFFF); // #ffffff
  static const Color _text = Color(0xFF111827); // #111827

  static ThemeData get lightTheme {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primary,
        brightness: Brightness.light,
        primary: _primary,
        secondary: _accent,
        surface: _surface,
        error: _error,
      ),
      scaffoldBackgroundColor: _background,
    );

    return base.copyWith(
      textTheme: base.textTheme.apply(
        bodyColor: _text,
        displayColor: _text,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: _background,
        foregroundColor: _text,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardTheme(
        color: _surface,
        surfaceTintColor: _surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: _secondary.withAlpha(38)),
        ),
      ),
      dividerColor: _secondary.withAlpha(38),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: _primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
