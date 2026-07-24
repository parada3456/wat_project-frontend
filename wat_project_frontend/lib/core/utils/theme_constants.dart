import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primary = Color(0xFF9747FF); // accent from DESIGN.md
  static const Color primaryVariant = Color(0xFF7B2CBF); // Derived
  static const Color secondary = Color(0xFFD9D9D9); // surface from DESIGN.md
  static const Color background = Color(0xFFFFFFFF);
  static const Color backgroundAlt = Color(0xFFF6F4F4);
  static const Color surface = Color(0xFFD9D9D9);
  static const Color surfaceAlt = Color(0xFFEFEFEF);
  static const Color error = Color(0xFFB00020);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFF000000);
  static const Color onBackground = Color(0xFF000000);
  static const Color onSurface = Color(0xFF000000);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color divider = Color.fromARGB(255, 124, 124, 124);

  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF494551);

  static const Color blackText = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
}

abstract class AppDimension {
  static const double space3 = 3.0;
  static const double space4 = 4.0;
  static const double space5 = 5.0;
  static const double space8 = 8.0;
  static const double space9 = 9.0;
  static const double space10 = 10.0;
  static const double space12 = 12.0;
  static const double space16 = 16.0;
  static const double space32 = 32.0;
  static const double space39 = 39.0;
  static const double space50 = 50.0;
  static const double space70 = 70.0;
  static const double space73 = 73.0;
  static const double space392 = 392.0;

  static const double paddingXS = space4;
  static const double paddingSmall = space8;
  static const double paddingMedium = space16;
  static const double paddingLarge = space32;

  static const double radiusSmall = 10.0;
  static const double radiusMedium = 15.0;
  static const double radiusLarge = 20.0;
  static const double radiusExtraLarge = 50.0;
}

abstract class AppAssets {
  static const String logo = 'assets/images/logo.png';
  // Add other assets here
}
