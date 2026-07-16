import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class AppTheme {
  AppTheme._();

  // ─── Press Start 2P text theme ───
  static TextTheme _pixelTextTheme(Color color) {
    final base = GoogleFonts.notoSansThaiTextTheme();
    return base.copyWith(
      displayLarge: GoogleFonts.notoSansThai(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.4,
      ),
      displayMedium: GoogleFonts.notoSansThai(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.4,
      ),
      displaySmall: GoogleFonts.notoSansThai(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.4,
      ),
      headlineLarge: GoogleFonts.notoSansThai(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.4,
      ),
      headlineMedium: GoogleFonts.notoSansThai(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.4,
      ),
      headlineSmall: GoogleFonts.notoSansThai(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.4,
      ),
      titleLarge: GoogleFonts.notoSansThai(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.4,
      ),
      titleMedium: GoogleFonts.notoSansThai(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.4,
      ),
      titleSmall: GoogleFonts.notoSansThai(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.4,
      ),
      bodyLarge: GoogleFonts.notoSansThai(
        fontSize: 12,
        color: color,
        height: 1.4,
      ),
      bodyMedium: GoogleFonts.notoSansThai(
        fontSize: 11,
        color: color,
        height: 1.4,
      ),
      bodySmall: GoogleFonts.notoSansThai(
        fontSize: 9,
        color: color,
        height: 1.4,
      ),
      labelLarge: GoogleFonts.notoSansThai(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.4,
      ),
      labelMedium: GoogleFonts.notoSansThai(
        fontSize: 8,
        color: color,
        height: 1.4,
      ),
      labelSmall: GoogleFonts.notoSansThai(
        fontSize: 8,
        color: color,
        height: 1.4,
      ),
    );
  }

  // ─── Shared button style ───
  static ButtonStyle _pixelButtonStyle({
    required Color bg,
    required Color fg,
    required Color shadow,
  }) =>
      ElevatedButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: fg,
        elevation: 0,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        side: BorderSide(color: fg, width: AppDimension.pixelBorderWidth),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimension.space16,
          vertical: AppDimension.space12,
        ),
        shadowColor: Colors.transparent,
      );

  // ─── LIGHT THEME (day / RPG town) ───
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBackground,
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.lightSurface,
      error: AppColors.error,
      onPrimary: AppColors.white,
      onSecondary: AppColors.black,
      onSurface: AppColors.lightTextPrimary,
      onError: AppColors.white,
      outline: AppColors.lightBorder,
    ),
    textTheme: _pixelTextTheme(AppColors.lightTextPrimary),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: _pixelButtonStyle(
        bg: AppColors.primary,
        fg: AppColors.white,
        shadow: AppColors.lightBorder,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.lightNavBar,
      foregroundColor: AppColors.white,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: GoogleFonts.pressStart2p(
        fontSize: 12,
        color: AppColors.white,
        height: 1.8,
      ),
      shape: const Border(
        bottom: BorderSide(
          color: AppColors.lightBorder,
          width: AppDimension.pixelBorderWidth,
        ),
      ),
    ),
    cardTheme: const CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      color: AppColors.lightSurface,
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.lightBorder,
      thickness: AppDimension.pixelBorderWidth,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightSurfaceAlt,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(
          color: AppColors.lightBorder,
          width: AppDimension.pixelBorderWidth,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(
          color: AppColors.lightBorder,
          width: AppDimension.pixelBorderWidth,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(
          color: AppColors.primary,
          width: AppDimension.pixelBorderWidth,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(
          color: AppColors.error,
          width: AppDimension.pixelBorderWidth,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(
          color: AppColors.error,
          width: AppDimension.pixelBorderWidth,
        ),
      ),
      labelStyle: GoogleFonts.pressStart2p(
        fontSize: 9,
        color: AppColors.lightTextSecondary,
      ),
      hintStyle: GoogleFonts.pressStart2p(
        fontSize: 9,
        color: AppColors.lightTextSecondary,
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      side: BorderSide(
        color: AppColors.lightBorder,
        width: AppDimension.pixelBorderWidth,
      ),
      fillColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? AppColors.primary
            : Colors.transparent,
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? AppColors.primary
            : AppColors.lightBorder,
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? AppColors.primary.withValues(alpha: 0.3)
            : AppColors.lightBackgroundAlt,
      ),
    ),
    dialogTheme: const DialogThemeData(
      backgroundColor: AppColors.lightSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.lightNavBar,
      contentTextStyle: GoogleFonts.pressStart2p(
        fontSize: 9,
        color: AppColors.white,
      ),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    ),
  );

  // ─── DARK THEME (night / dungeon) ───
  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.darkSurface,
      error: AppColors.error,
      onPrimary: AppColors.black,
      onSecondary: AppColors.black,
      onSurface: AppColors.darkTextPrimary,
      onError: AppColors.white,
      outline: AppColors.darkBorder,
    ),
    textTheme: _pixelTextTheme(AppColors.darkTextPrimary),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: _pixelButtonStyle(
        bg: AppColors.primary,
        fg: AppColors.black,
        shadow: AppColors.darkBorder,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      foregroundColor: AppColors.darkTextPrimary,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: GoogleFonts.pressStart2p(
        fontSize: 12,
        color: AppColors.darkTextPrimary,
        height: 1.8,
      ),
      shape: const Border(
        bottom: BorderSide(
          color: AppColors.darkBorder,
          width: AppDimension.pixelBorderWidth,
        ),
      ),
    ),
    cardTheme: const CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      color: AppColors.darkSurface,
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.darkBorder,
      thickness: AppDimension.pixelBorderWidth,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkSurfaceAlt,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(
          color: AppColors.darkBorder,
          width: AppDimension.pixelBorderWidth,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(
          color: AppColors.darkBorder,
          width: AppDimension.pixelBorderWidth,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(
          color: AppColors.primary,
          width: AppDimension.pixelBorderWidth,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(
          color: AppColors.error,
          width: AppDimension.pixelBorderWidth,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(
          color: AppColors.error,
          width: AppDimension.pixelBorderWidth,
        ),
      ),
      labelStyle: GoogleFonts.pressStart2p(
        fontSize: 9,
        color: AppColors.darkTextSecondary,
      ),
      hintStyle: GoogleFonts.pressStart2p(
        fontSize: 9,
        color: AppColors.darkTextSecondary,
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      side: BorderSide(
        color: AppColors.darkBorder,
        width: AppDimension.pixelBorderWidth,
      ),
      fillColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? AppColors.primary
            : Colors.transparent,
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? AppColors.primary
            : AppColors.darkTextSecondary,
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? AppColors.primary.withValues(alpha: 0.3)
            : AppColors.darkSurfaceAlt,
      ),
    ),
    dialogTheme: const DialogThemeData(
      backgroundColor: AppColors.darkSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.darkSurface,
      contentTextStyle: GoogleFonts.pressStart2p(
        fontSize: 9,
        color: AppColors.darkTextPrimary,
      ),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    ),
  );
}
