import 'package:flutter/material.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/core/widgets/pixel_border_container.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

class CreditScoreBadge extends StatelessWidget {
  final int score;

  const CreditScoreBadge({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    Color scoreColor;
    if (score >= 800) {
      scoreColor = AppColors.success;
    } else if (score >= 600) {
      scoreColor = AppColors.warning;
    } else {
      scoreColor = AppColors.error;
    }

    return Column(
      children: [
        PixelBorderContainer(
          width: 100,
          height: 80,
          borderColor: scoreColor,
          padding: const EdgeInsets.symmetric(vertical: AppDimension.space12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$score',
                style: GoogleFonts.notoSansThai(
                  fontSize: 14,
                  color: scoreColor,
                ),
              ),
              const SizedBox(height: AppDimension.space8),
              Text(
                score >= 800 ? 'GOOD' : score >= 600 ? 'FAIR' : 'POOR',
                style: GoogleFonts.notoSansThai(
                  fontSize: 7,
                  color: scoreColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppDimension.space8),
        Text(
          'CREDIT SCORE',
          style: GoogleFonts.notoSansThai(
            fontSize: 7,
            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
          ),
        ),
      ],
    );
  }
}
