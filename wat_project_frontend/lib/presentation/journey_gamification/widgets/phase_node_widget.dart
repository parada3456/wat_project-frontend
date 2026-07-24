import 'package:flutter/material.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

class PhaseNodeWidget extends StatelessWidget {
  final int phaseNumber;
  final String title;
  final bool isCompleted;
  final bool isActive;
  final bool isLast;

  const PhaseNodeWidget({
    super.key,
    required this.phaseNumber,
    required this.title,
    this.isCompleted = false,
    this.isActive = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = AppColors.text(context);
    final subtextColor = AppColors.textSub(context);
    final borderColor = AppColors.border(context);

    final nodeColor = isCompleted
        ? AppColors.primary
        : (isActive ? textColor : subtextColor);
    final nodeBg = isCompleted
        ? AppColors.primary
        : (isActive ? (isDark ? AppColors.darkSurface : AppColors.lightSurface) : (isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt));

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: nodeBg,
                    border: Border.all(
                      color: nodeColor,
                      width: AppDimension.pixelBorderWidth,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: isCompleted
                      ? AppAssets.img(
                          AppAssets.iconCheck,
                          color: AppColors.black,
                          size: 16,
                        )
                      : Text(
                          '$phaseNumber',
                          style: GoogleFonts.notoSansThai(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: nodeColor,
                          ),
                        ),
                ),
                if (!isLast)
                  Container(
                    width: 4,
                    height: 52,
                    color: isCompleted ? AppColors.primary : borderColor,
                  ),
              ],
            ),
            const SizedBox(width: AppDimension.space16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PHASE $phaseNumber'.toUpperCase(),
                    style: GoogleFonts.notoSansThai(
                      fontSize: 7,
                      fontWeight: FontWeight.bold,
                      color: isActive ? AppColors.primary : subtextColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title.toUpperCase(),
                    style: GoogleFonts.notoSansThai(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: isActive ? textColor : subtextColor,
                      height: 1.4,
                    ),
                  ),
                  if (isActive) ...[
                    const SizedBox(height: AppDimension.space8),
                    Text(
                      'current location. complete active quests to unlock the next region.',
                      style: GoogleFonts.notoSansThai(
                        fontSize: 6,
                        color: subtextColor,
                        height: 1.8,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
