import 'package:flutter/material.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/core/widgets/pixel_border_container.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

class SocialLinkItem extends StatelessWidget {
  final String iconAsset;
  final String username;

  const SocialLinkItem({
    super.key,
    required this.iconAsset,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = AppColors.text(context);

    return PixelBorderContainer(
      padding: const EdgeInsets.all(AppDimension.space12),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt,
              border: Border.all(
                color: AppColors.border(context),
                width: AppDimension.pixelBorderWidth,
              ),
            ),
            alignment: Alignment.center,
            child: AppAssets.img(
              iconAsset,
              size: 16,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: AppDimension.space16),
          Text(
            username,
            style: GoogleFonts.notoSansThai(
              fontSize: 8,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
