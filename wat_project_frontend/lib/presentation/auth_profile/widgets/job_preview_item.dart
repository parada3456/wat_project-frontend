import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/core/widgets/pixel_border_container.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class JobPreviewItem extends StatelessWidget {
  final String title;

  const JobPreviewItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final textColor = AppColors.text(context);
    final subtextColor = AppColors.textSub(context);

    return PixelBorderContainer(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimension.space16,
        vertical: AppDimension.space12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title.toUpperCase(),
              style: GoogleFonts.pressStart2p(
                fontSize: 8,
                fontWeight: FontWeight.bold,
                color: textColor,
                height: 1.5,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: AppDimension.space8),
          // Renders a fallback right chevron/arrow using AppAssets.iconBack mirrored/colored
          AppAssets.img(
            AppAssets.iconBack, // using back flipped/colored as indicator
            size: 16,
            color: subtextColor,
          ),
        ],
      ),
    );
  }
}
