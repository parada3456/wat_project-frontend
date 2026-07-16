import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// PIXEL COLOR PALETTE — Gather.town / 2D top-down RPG aesthetic
// Light = day-mode RPG town  |  Dark = night-mode dungeon
// ─────────────────────────────────────────────────────────────────────────────

// abstract class AppColors {
//   // ─── Shared accents (same in both modes) ───
//   static const Color primary = Color(0xFF4CAF50);        // Pixel green (active/primary)
//   static const Color primaryVariant = Color(0xFF2E7D32);
//   static const Color secondary = Color(0xFFFFC107);      // Pixel amber (secondary accent)
//   static const Color error = Color(0xFFE53935);
//   static const Color success = Color(0xFF43A047);
//   static const Color warning = Color(0xFFFB8C00);
//   static const Color info = Color(0xFF1565C0);

//   // ─── Light mode (day / outdoor RPG town) ───
//   static const Color lightBackground = Color(0xFFE8F5E9);    // Soft grass green
//   static const Color lightBackgroundAlt = Color(0xFFDCEDC8);
//   static const Color lightSurface = Color(0xFFF9FBE7);       // Parchment panel
//   static const Color lightSurfaceAlt = Color(0xFFF0F4C3);
//   static const Color lightBorder = Color(0xFF558B2F);        // Dark green border
//   static const Color lightTextPrimary = Color(0xFF1B5E20);   // Deep green text
//   static const Color lightTextSecondary = Color(0xFF33691E);
//   static const Color lightNavBar = Color(0xFF33691E);

//   // ─── Dark mode (night / dungeon RPG) ───
//   static const Color darkBackground = Color(0xFF1A1C2C);     // Deep navy dungeon
//   static const Color darkBackgroundAlt = Color(0xFF16213E);
//   static const Color darkSurface = Color(0xFF2D2B55);        // Dark panel purple
//   static const Color darkSurfaceAlt = Color(0xFF252344);
//   static const Color darkBorder = Color(0xFF4CAF50);         // Bright green border
//   static const Color darkTextPrimary = Color(0xFFE8F5E9);    // Soft white
//   static const Color darkTextSecondary = Color(0xFFA5D6A7);  // Muted green
//   static const Color darkNavBar = Color(0xFF1A1C2C);

//   // ─── Semantic aliases (use these in widgets) ───
//   // These will be resolved at runtime from context brightness.
//   static const Color white = Color(0xFFFFFFFF);
//   static const Color black = Color(0xFF000000);

//   // Legacy aliases kept for backward compatibility during migration
//   static const Color background = darkBackground;
//   static const Color backgroundAlt = darkBackgroundAlt;
//   static const Color surface = darkSurface;
//   static const Color surfaceAlt = darkSurfaceAlt;
//   static const Color textPrimary = darkTextPrimary;
//   static const Color textSecondary = darkTextSecondary;
//   static const Color blackText = Color(0xFF1B5E20);
//   static const Color onPrimary = white;
//   static const Color onSecondary = black;
//   static const Color onBackground = darkTextPrimary;
//   static const Color onSurface = darkTextPrimary;
//   static const Color onError = white;
//   static const Color divider = Color(0xFF4CAF50);
abstract class AppColors {
  // ─── Shared Accents (Vibrant, 2D Top-Down Game Style) ───
  static const Color primary = Color(0xFF4EA8DE);        // Radiant Sky Blue (Main Accent)
  static const Color primaryVariant = Color(0xFF3A86C8); // Deep Cyber Blue
  static const Color secondary = Color(0xFF70E000);      // Slime/Grass Green (Lively Contrast)
  static const Color error = Color(0xFFFF4D6D);          // Ruby Heart Red (Health bar / Danger)
  static const Color success = Color(0xFF38B000);        // Vivid Potion Green
  static const Color warning = Color(0xFFFF9F1C);        // Bright Amber Orange (Coins / Alerts)
  static const Color info = Color(0xFF9E0059);           // Mythic Magenta / Purple

  // ─── Light Mode (Cozy Cream & Pop Blue) ───
  static const Color lightBackground = Color(0xFFFFFDF6);    // Rich Sweet Cream
  static const Color lightBackgroundAlt = Color(0xFFF3EED8); // Warm Pastry Cream
  static const Color lightSurface = Color(0xFFE7F5FF);       // Soft Tinted Ice Blue
  static const Color lightSurfaceAlt = Color(0xFFD0EBFF);    // Clear Sky Surface
  static const Color lightBorder = Color(0xFFB5D8F7);        // Defined Comic-style Blue Border
  static const Color lightTextPrimary = Color(0xFF1A2238);   // High-contrast Deep Navy Blue
  static const Color lightTextSecondary = Color(0xFF4A5E80); // Muted Steel Blue text
  static const Color lightNavBar = Color(0xFFE7F5FF);

  // ─── Dark Mode (Deep Midnight Blue & Neon Accents) ───
  static const Color darkBackground = Color(0xFF0F1423);     // Deep Space Blue-Black
  static const Color darkBackgroundAlt = Color(0xFF161D33);  // Shadow Navy
  static const Color darkSurface = Color(0xFF1D2744);        // Luminous Dark Blue Panel
  static const Color darkSurfaceAlt = Color(0xFF28355E);     // Highlighted Blue Panel
  static const Color darkBorder = Color(0xFF3B4D87);         // Neon-adjacent Blue Border
  static const Color darkTextPrimary = Color(0xFFE2E8F0);    // Crisp Clear White-Blue
  static const Color darkTextSecondary = Color(0xFF94A3B8);  // Slate Blue text
  static const Color darkNavBar = Color(0xFF0F1423);

  // ─── Semantic Aliases ───
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // Legacy aliases kept for backward compatibility during migration
  static const Color background = darkBackground;
  static const Color backgroundAlt = darkBackgroundAlt;
  static const Color surface = darkSurface;
  static const Color surfaceAlt = darkSurfaceAlt;
  static const Color textPrimary = darkTextPrimary;
  static const Color textSecondary = darkTextSecondary;
  static const Color blackText = Color(0xFF1A2238);
  static const Color onPrimary = white;
  static const Color onSecondary = black;                     // Swapped to black for better pop against bright green
  static const Color onBackground = darkTextPrimary;
  static const Color onSurface = darkTextPrimary;
  static const Color onError = white;
  static const Color divider = Color(0xFFB5D8F7);

  // ─── Helper: resolve by context ───
  static Color bg(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? darkBackground
          : lightBackground;

  static Color bgAlt(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? darkBackgroundAlt
          : lightBackgroundAlt;

  static Color panel(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? darkSurface
          : lightSurface;

  static Color border(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? darkBorder
          : lightBorder;

  static Color text(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? darkTextPrimary
          : lightTextPrimary;

  static Color textSub(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? darkTextSecondary
          : lightTextSecondary;

  static Color navBg(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? darkNavBar
          : lightNavBar;
}

// ─────────────────────────────────────────────────────────────────────────────
// PIXEL DIMENSIONS — 8px grid system
// ─────────────────────────────────────────────────────────────────────────────

abstract class AppDimension {
  // Grid-aligned spacing
  static const double tileSize = 8.0;          // Base pixel grid unit
  static const double pixelBorderWidth = 2.0;  // Outer pixel border
  static const double pixelBorderInner = 1.0;  // Inner accent line

  // Spacing scale (multiples of 8)
  static const double space3 = 3.0;
  static const double space4 = 4.0;
  static const double space5 = 5.0;
  static const double space8 = 8.0;
  static const double space9 = 9.0;
  static const double space10 = 10.0;
  static const double space12 = 12.0;
  static const double space16 = 16.0;
  static const double space20 = 20.0;
  static const double space24 = 24.0;
  static const double space32 = 32.0;
  static const double space39 = 39.0;
  static const double space40 = 40.0;
  static const double space48 = 48.0;
  static const double space50 = 50.0;
  static const double space64 = 64.0;
  static const double space70 = 70.0;
  static const double space73 = 73.0;
  static const double space392 = 392.0;

  // Padding aliases
  static const double paddingXS = space4;
  static const double paddingSmall = space8;
  static const double paddingMedium = space16;
  static const double paddingLarge = space32;

  // Pixel theme uses 0 radius (hard corners)
  static const double radiusNone = 0.0;
  // Keep legacy values for any remaining usage during migration:
  static const double radiusSmall = 0.0;
  static const double radiusMedium = 0.0;
  static const double radiusLarge = 0.0;
  static const double radiusExtraLarge = 0.0;
}

// ─────────────────────────────────────────────────────────────────────────────
// APP ASSETS — Single source of truth for all icon/image file paths.
// Real PNG/SVG files to be added by the user under assets/icons/ and
// assets/images/. All widgets must use Image.asset(AppAssets.xxx) instead
// of Icon(Icons.xxx).
//
// PLACEHOLDER BEHAVIOR: if the file doesn't exist, wrap Image.asset in an
// AppAssets.placeholder() colored box so the app doesn't crash.
// ─────────────────────────────────────────────────────────────────────────────

abstract class AppAssets {
  // ─── Images ───
  static const String logo = 'assets/images/logo.png';

  // ─── Navigation icons ───
  static const String iconHome = 'assets/icons/house.png';
  // static const String iconHomeActive = 'assets/icons/home_active.png';
  static const String iconHomeActive = 'assets/icons/house.png';
  static const String iconMap = 'assets/icons/map.png';
  static const String iconMapActive = 'assets/icons/map.png';
  static const String iconExpenses = 'assets/icons/expenses.png';
  static const String iconExpensesActive = 'assets/icons/expenses.png';
  static const String iconJobs = 'assets/icons/job.png';
  static const String iconJobsActive = 'assets/icons/job.png';
  static const String iconProfile = 'assets/icons/boy.png';
  static const String iconProfileActive = 'assets/icons/boy.png';

  // ─── Action icons ───
  static const String iconBack = 'assets/icons/back.png';
  static const String iconAdd = 'assets/icons/add.png';
  static const String iconEdit = 'assets/icons/edit.png';
  static const String iconDelete = 'assets/icons/delete.png';
  static const String iconSearch = 'assets/icons/search.png';
  static const String iconClose = 'assets/icons/close.png';
  static const String iconCheck = 'assets/icons/check.png';
  static const String iconSend = 'assets/icons/send.png';
  static const String iconShare = 'assets/icons/share.png';
  static const String iconFilter = 'assets/icons/filter.png';
  static const String iconSettings = 'assets/icons/settings.png';
  static const String iconCompare = 'assets/icons/compare.png';
  static const String iconCart = 'assets/icons/cart.png';
  static const String iconCalendar = 'assets/icons/calendar.png';
  static const String iconNotification = 'assets/icons/notification.png';
  static const String iconAdmin = 'assets/icons/admin.png';
  static const String iconMenu = 'assets/icons/menu.png';

  // ─── Status/type icons ───
  static const String iconSuccess = 'assets/icons/success.png';
  static const String iconError = 'assets/icons/error.png';
  static const String iconWarning = 'assets/icons/warning.png';
  static const String iconInfo = 'assets/icons/info.png';

  // ─── Feature icons ───
  static const String iconStar = 'assets/icons/star.png';
  static const String iconStarEmpty = 'assets/icons/star_empty.png';
  static const String iconBadge = 'assets/icons/badge.png';
  static const String iconMedal = 'assets/icons/medal.png';
  static const String iconCredits = 'assets/icons/credits.png';
  static const String iconMission = 'assets/icons/mission.png';
  static const String iconTask = 'assets/icons/task.png';
  static const String iconFriend = 'assets/icons/friend.png';
  static const String iconRadar = 'assets/icons/radar.png';
  static const String iconLocation = 'assets/icons/location.png';
  static const String iconReview = 'assets/icons/review.png';
  static const String iconSponsor = 'assets/icons/sponsor.png';
  static const String iconSalary = 'assets/icons/salary.png';
  static const String iconSlots = 'assets/icons/slots.png';
  static const String iconLink = 'assets/icons/link.png';
  static const String iconPayment = 'assets/icons/payment.png';
  static const String iconSplit = 'assets/icons/split.png';
  static const String iconTimeline = 'assets/icons/timeline.png';
  static const String iconLeaderboard = 'assets/icons/leaderboard.png';
  static const String iconPassword = 'assets/icons/password.png';
  static const String iconLogout = 'assets/icons/logout.png';
  static const String iconHousing = 'assets/icons/housing.png';
  static const String iconCharacter = 'assets/icons/character.png';
  static const String iconSocial = 'assets/icons/social.png';
  static const String iconCartAdd = 'assets/icons/cartAdd.png';
  static const String iconCartDelete = 'assets/icons/cartDelete.png';

  /// Returns a safe fallback widget when the real asset file is not yet present.
  /// Use this to wrap Image.asset() calls:
  ///   AppAssets.img(AppAssets.iconHome, size: 24, color: AppColors.primary)
  static Widget img(
    String path, {
    double size = 24,
    Color? color,
    BoxFit fit = BoxFit.contain,
  }) {
    return Image.asset(
      path,
      width: size,
      height: size,
      fit: fit,
      color: color,
      errorBuilder: (context, error, stackTrace) => PixelIconFallback(size: size, color: color),
    );
  }
}

/// Fallback when an icon asset file doesn't exist yet.
/// Renders as a small colored pixel box so the app never crashes.
class PixelIconFallback extends StatelessWidget {
  final double size;
  final Color? color;

  const PixelIconFallback({super.key, required this.size, this.color});

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.primary;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.2),
        border: Border.all(color: c, width: AppDimension.pixelBorderWidth),
      ),
    );
  }
}
