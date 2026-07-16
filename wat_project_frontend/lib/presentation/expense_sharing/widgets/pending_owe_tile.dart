import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/core/widgets/pixel_border_container.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class PendingOweTile extends StatelessWidget {
  final String personName;
  final double amount;
  final String dueDate;
  final bool isOverdue;

  const PendingOweTile({
    super.key,
    required this.personName,
    required this.amount,
    required this.dueDate,
    this.isOverdue = false,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = AppColors.text(context);
    final subtextColor = AppColors.textSub(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = AppColors.border(context);

    final tileBorderColor = isOverdue ? AppColors.error : borderColor;
    final tileBgColor = isOverdue
        ? AppColors.error.withValues(alpha: 0.15)
        : (isDark ? AppColors.darkSurface : AppColors.lightSurface);

    return PixelBorderContainer(
      borderColor: tileBorderColor,
      backgroundColor: tileBgColor,
      padding: const EdgeInsets.all(AppDimension.space12),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt,
              border: Border.all(
                color: tileBorderColor,
                width: AppDimension.pixelBorderWidth,
              ),
            ),
            alignment: Alignment.center,
            child: AppAssets.img(
              AppAssets.iconCharacter,
              size: 16,
              color: isOverdue ? AppColors.error : textColor,
            ),
          ),
          const SizedBox(width: AppDimension.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'OWE $personName'.toUpperCase(),
                  style: GoogleFonts.pressStart2p(
                    fontSize: 7,
                    fontWeight: FontWeight.bold,
                    color: isOverdue ? AppColors.error : textColor,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'DUE $dueDate'.toUpperCase(),
                  style: GoogleFonts.pressStart2p(
                    fontSize: 6,
                    color: isOverdue ? AppColors.error : subtextColor,
                    fontWeight: isOverdue ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: GoogleFonts.pressStart2p(
              fontSize: 7,
              fontWeight: FontWeight.bold,
              color: isOverdue ? AppColors.error : textColor,
            ),
          ),
        ],
      ),
    );
  }
}
