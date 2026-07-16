import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

/// LoginHeader — Pixel RPG title screen logo block.
/// Renders the WAT logo with a pixel border frame and Press Start 2P title.
class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor =
        isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final textColor =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final subtextColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Column(
      children: [
        // ─── Pixel logo frame ───
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.primary,
            border: Border.all(
              color: borderColor,
              width: AppDimension.pixelBorderWidth,
            ),
          ),
          alignment: Alignment.center,
          child: AppAssets.img(
            AppAssets.logo,
            size: 48,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: AppDimension.space4),
        // pixel "shadow" box below logo
        Container(
          width: 80,
          height: 4,
          color: borderColor,
        ),
        const SizedBox(height: AppDimension.space16),
        // ─── Game title ───
        Text(
          'WAT PROJECT',
          style: GoogleFonts.pressStart2p(
            fontSize: 14,
            color: AppColors.primary,
            height: 1.8,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: AppDimension.space8),
        Text(
          'WORK & TRAVEL',
          style: GoogleFonts.pressStart2p(
            fontSize: 8,
            color: textColor,
            height: 1.8,
            letterSpacing: 4,
          ),
        ),
        const SizedBox(height: AppDimension.space8),
        Text(
          'sign in to continue your journey',
          textAlign: TextAlign.center,
          style: GoogleFonts.pressStart2p(
            fontSize: 7,
            color: subtextColor,
            height: 2.0,
          ),
        ),
      ],
    );
  }
}
