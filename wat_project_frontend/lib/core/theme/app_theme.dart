import 'package:flutter/material.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class AppTheme {
  AppTheme._(); // private constructor

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.surfaceAlt,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surface,
      error: AppColors.error,
      onPrimary: AppColors.onPrimary,
      onSecondary: AppColors.onSecondary,
      onSurface: AppColors.onSurface,
      onError: AppColors.onError,
    ),
    textTheme: _buildTextTheme(AppColors.blackText),
    elevatedButtonTheme: _buildButtonTheme(AppColors.primary, AppColors.white),
    bottomNavigationBarTheme: _buildNavBarTheme(AppColors.secondary),
    appBarTheme: _buildAppBarTheme(),
    cardTheme: _buildCardTheme(),
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212),
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: Color(0xFF1E1E1E),
    ),
    textTheme: _buildTextTheme(AppColors.white),
    elevatedButtonTheme: _buildButtonTheme(
      AppColors.primary,
      AppColors.blackText,
    ),
    bottomNavigationBarTheme: _buildNavBarTheme(AppColors.secondary),
    appBarTheme: _buildAppBarTheme(),
    cardTheme: _buildCardTheme(),
  );

  static TextTheme _buildTextTheme(Color bodyColor) => TextTheme(
    displayLarge: TextStyle(
      color: bodyColor,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: TextStyle(color: bodyColor, fontSize: 16),
    bodyMedium: TextStyle(color: bodyColor, fontSize: 14),
  );

  static ElevatedButtonThemeData _buildButtonTheme(Color bg, Color fg) =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
          ),
        ),
      );

  static BottomNavigationBarThemeData _buildNavBarTheme(Color selectedColor) =>
      BottomNavigationBarThemeData(
        selectedItemColor: selectedColor,
        unselectedItemColor: Colors.grey,
      );

  static AppBarTheme _buildAppBarTheme() =>
      const AppBarTheme(centerTitle: true, elevation: 0);

  static CardThemeData _buildCardTheme() => CardThemeData(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
    ),
  );
}
