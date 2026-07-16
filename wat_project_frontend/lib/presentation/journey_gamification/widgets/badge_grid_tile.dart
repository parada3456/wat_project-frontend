import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/core/widgets/pixel_border_container.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class BadgeGridTile extends StatelessWidget {
  final String title;
  final String iconAsset;
  final bool isEarned;

  const BadgeGridTile({
    super.key,
    required this.title,
    required this.iconAsset,
    this.isEarned = false,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = AppColors.text(context);
    final subtextColor = AppColors.textSub(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final badgeColor = isEarned
        ? AppColors.primary
        : (isDark ? AppColors.darkBorder : AppColors.lightBorder);

    return PixelBorderContainer(
      borderColor: badgeColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isEarned
                  ? AppColors.primary.withValues(alpha: 0.15)
                  : (isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt),
              border: Border.all(
                color: badgeColor,
                width: AppDimension.pixelBorderWidth,
              ),
            ),
            alignment: Alignment.center,
            child: AppAssets.img(
              iconAsset,
              size: 24,
              color: isEarned ? AppColors.primary : subtextColor,
            ),
          ),
          const SizedBox(height: AppDimension.space12),
          Text(
            title.toUpperCase(),
            textAlign: TextAlign.center,
            style: GoogleFonts.notoSansThai(
              fontSize: 6,
              fontWeight: FontWeight.bold,
              color: isEarned ? textColor : subtextColor,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
