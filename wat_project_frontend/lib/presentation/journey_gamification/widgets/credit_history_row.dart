import 'package:flutter/material.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/core/widgets/pixel_border_container.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

class CreditHistoryRow extends StatelessWidget {
  final String title;
  final String date;
  final int delta;

  const CreditHistoryRow({
    super.key,
    required this.title,
    required this.date,
    required this.delta,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = delta > 0;
    final textColor = AppColors.text(context);
    final subtextColor = AppColors.textSub(context);
    final deltaColor = isPositive ? AppColors.success : AppColors.error;

    return PixelBorderContainer(
      padding: const EdgeInsets.all(AppDimension.space12),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: deltaColor.withValues(alpha: 0.15),
              border: Border.all(
                color: deltaColor,
                width: AppDimension.pixelBorderWidth,
              ),
            ),
            alignment: Alignment.center,
            child: AppAssets.img(
              isPositive ? AppAssets.iconAdd : AppAssets.iconClose,
              size: 16,
              color: deltaColor,
            ),
          ),
          const SizedBox(width: AppDimension.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toUpperCase(),
                  style: GoogleFonts.notoSansThai(
                    fontSize: 7,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: GoogleFonts.notoSansThai(
                    fontSize: 6,
                    color: subtextColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${isPositive ? '+' : ''}$delta',
            style: GoogleFonts.notoSansThai(
              fontSize: 8,
              fontWeight: FontWeight.bold,
              color: deltaColor,
            ),
          ),
        ],
      ),
    );
  }
}
