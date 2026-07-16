import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class AppTheme {
  AppTheme._();

  // ─── Press Start 2P text theme ───
  static TextTheme _pixelTextTheme(Color color) {
    // final base = GoogleFonts.notoSansThaiTextTheme();
    final base = GoogleFonts.interTextTheme();
    return base.copyWith(
      displayLarge: GoogleFonts.notoSansThai(
        fontSize: 34,             // ปรับเพิ่มจาก 16 -> ชัดเจนสะใจสไตล์เกม
        fontWeight: FontWeight.bold, // เปลี่ยนเป็น Bold ให้เห็นชัดขึ้น
        color: color,
        height: 1.2,
      ),
      displayMedium: GoogleFonts.notoSansThai(
        fontSize: 28,             // ปรับเพิ่มจาก 14
        fontWeight: FontWeight.bold,
        color: color,
        height: 1.2,
      ),
      displaySmall: GoogleFonts.notoSansThai(
        fontSize: 24,             // ปรับเพิ่มจาก 12
        fontWeight: FontWeight.w600,
        color: color,
        height: 1.2,
      ),

      // ─── Headline: หัวข้อย่อยประจำหน้า หรือชื่อเมนูหลัก ───
      headlineLarge: GoogleFonts.notoSansThai(
        fontSize: 22,             // ปรับเพิ่มจาก 14
        fontWeight: FontWeight.w600,
        color: color,
        height: 1.3,
      ),
      headlineMedium: GoogleFonts.notoSansThai(
        fontSize: 20,             // ปรับเพิ่มจาก 12
        fontWeight: FontWeight.w600,
        color: color,
        height: 1.3,
      ),
      headlineSmall: GoogleFonts.notoSansThai(
        fontSize: 18,             // ปรับเพิ่มจาก 12
        fontWeight: FontWeight.w600,
        color: color,
        height: 1.3,
      ),

      // ─── Title: ชื่อไอเทม ชื่อการ์ด หรือหัวข้อในกล่อง UI ───
      titleLarge: GoogleFonts.notoSansThai(
        fontSize: 16,             // ปรับเพิ่มจาก 14 -> เป็นขนาดกำลังดีสำหรับหัวข้อย่อย
        fontWeight: FontWeight.w500,
        color: color,
        height: 1.4,
      ),
      titleMedium: GoogleFonts.notoSansThai(
        fontSize: 14,             // ปรับเพิ่มจาก 12
        fontWeight: FontWeight.w500,
        color: color,
        height: 1.4,
      ),
      titleSmall: GoogleFonts.notoSansThai(
        fontSize: 13,             // ปรับเพิ่มจาก 10
        fontWeight: FontWeight.w500,
        color: color,
        height: 1.4,
      ),

      // ─── Body: เนื้อหา รายละเอียดไอเทม คำอธิบายทั่วไป (อ่านง่าย ไม่ปวดตา) ───
      bodyLarge: GoogleFonts.notoSansThai(
        fontSize: 16,             // ปรับเพิ่มจาก 12 -> ขนาดมาตรฐานตัวหนังสือทั่วไป
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.4,
      ),
      bodyMedium: GoogleFonts.notoSansThai(
        fontSize: 14,             // ปรับเพิ่มจาก 11 -> ขนาดอ่านง่ายบนมือถือ
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.4,
      ),
      bodySmall: GoogleFonts.notoSansThai(
        fontSize: 12,             // ปรับเพิ่มจาก 9 -> ห้ามต่ำกว่า 12 สำหรับฟอนต์ไทย ไม่งั้นสระลอย/หัวฟอนต์จะกลืนอ่านไม่ออก
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.4,
      ),

      // ─── Label: ตัวหนังสือบนปุ่ม คำอธิบายสั้นๆ หรือเลข Status ───
      labelLarge: GoogleFonts.notoSansThai(
        fontSize: 14,             // ปรับเพิ่มจาก 10 -> ขนาดตัวหนังสือบนปุ่มกดมาตรฐาน
        fontWeight: FontWeight.w600, // หนาขึ้นเพื่อให้เห็นบนปุ่มชัดเจน
        color: color,
        height: 1.2,
      ),
      labelMedium: GoogleFonts.notoSansThai(
        fontSize: 12,             // ปรับเพิ่มจาก 8
        fontWeight: FontWeight.w500,
        color: color,
        height: 1.2,
      ),
      labelSmall: GoogleFonts.notoSansThai(
        fontSize: 11,             // ปรับเพิ่มจาก 8
        fontWeight: FontWeight.w500,
        color: color,
        height: 1.2,
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
      titleTextStyle: GoogleFonts.notoSansThai(
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
      labelStyle: GoogleFonts.notoSansThai(
        fontSize: 12,
        color: AppColors.lightTextSecondary,
      ),
      hintStyle: GoogleFonts.notoSansThai(
        fontSize: 12,
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
      contentTextStyle: GoogleFonts.notoSansThai(
        fontSize: 12,
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
      titleTextStyle: GoogleFonts.notoSansThai(
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
      labelStyle: GoogleFonts.notoSansThai(
        fontSize: 12,
        color: AppColors.darkTextSecondary,
      ),
      hintStyle: GoogleFonts.notoSansThai(
        fontSize: 12,
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
      contentTextStyle: GoogleFonts.notoSansThai(
        fontSize: 12,
        color: AppColors.darkTextPrimary,
      ),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    ),
  );
}
