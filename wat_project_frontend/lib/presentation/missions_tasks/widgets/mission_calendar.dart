import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/core/widgets/pixel_border_container.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class MissionCalendar extends StatelessWidget {
  final List<MissionModel> missions;

  const MissionCalendar({super.key, required this.missions});

  @override
  Widget build(BuildContext context) {
    final textColor = AppColors.text(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = AppColors.border(context);

    return PixelBorderContainer(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'JUNE 2026',
                style: GoogleFonts.pressStart2p(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: AppAssets.img(AppAssets.iconBack, size: 14, color: textColor),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: RotatedBox(
                      quarterTurns: 2,
                      child: AppAssets.img(AppAssets.iconBack, size: 14, color: textColor),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppDimension.space16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
            ),
            itemCount: 30,
            itemBuilder: (context, index) {
              final day = index + 1;
              final isDeadline = missions.any(
                (m) =>
                    m.userMission?.calculatedDueDate != null &&
                    m.userMission!.calculatedDueDate!.day == day &&
                    m.userMission!.calculatedDueDate!.month == 6 &&
                    m.userMission!.calculatedDueDate!.year == 2026,
              );

              final dayBg = isDeadline
                  ? AppColors.primary.withValues(alpha: 0.15)
                  : (isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt);

              return Container(
                decoration: BoxDecoration(
                  color: dayBg,
                  border: Border.all(
                    color: isDeadline ? AppColors.primary : borderColor,
                    width: AppDimension.pixelBorderWidth,
                  ),
                ),
                child: Center(
                  child: Text(
                    '$day',
                    style: GoogleFonts.pressStart2p(
                      fontSize: 6,
                      fontWeight: isDeadline ? FontWeight.bold : FontWeight.normal,
                      color: isDeadline ? AppColors.primary : textColor,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
