import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/core/widgets/pixel_border_container.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class MissionCard extends StatelessWidget {
  final MissionModel mission;
  final VoidCallback? onJoinTap;

  const MissionCard({super.key, required this.mission, this.onJoinTap});

  @override
  Widget build(BuildContext context) {
    final title = mission.title;
    final bonusPoints = mission.basePoints;
    final location = mission.location;
    final isMandatory = mission.isMandatory;
    final isLocked = mission.isLocked;
    final status = mission.userMission?.status;

    final due = mission.userMission?.calculatedDueDate;
    final String deadline;
    if (due == null) {
      deadline = 'SOON';
    } else {
      final months = [
        'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
        'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'
      ];
      deadline = '${due.day} ${months[due.month - 1]}';
    }

    final resolvedLocation =
        (location ?? (isMandatory ? 'MANDATORY' : 'OPTIONAL')).toUpperCase();

    final totalTasks = mission.tasks.length;
    final completedTasks = mission.tasks
        .where((t) => t.isCompleted == true)
        .length;
    final progress = totalTasks > 0 ? completedTasks / totalTasks : 0.0;

    UserMissionStatus resolvedStatus = status ?? UserMissionStatus.notStarted;
    if (status == null) {
      if (progress >= 1.0) {
        resolvedStatus = UserMissionStatus.completed;
      } else if (progress > 0.0) {
        resolvedStatus = UserMissionStatus.inProgress;
      }
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = AppColors.text(context);
    final subtextColor = AppColors.textSub(context);
    final borderColor = AppColors.border(context);

    Widget statusWidget;

    if (isLocked) {
      statusWidget = Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt,
          border: Border.all(color: borderColor, width: AppDimension.pixelBorderWidth),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppAssets.img(AppAssets.iconClose, size: 10, color: subtextColor),
            const SizedBox(width: 4),
            Text(
              'LOCKED',
              style: GoogleFonts.pressStart2p(
                fontSize: 6,
                fontWeight: FontWeight.bold,
                color: subtextColor,
              ),
            ),
          ],
        ),
      );
    } else if (resolvedStatus == UserMissionStatus.notStarted) {
      statusWidget = WatButton(
        label: 'START',
        width: 80,
        onPressed: onJoinTap,
      );
    } else if (resolvedStatus == UserMissionStatus.completed) {
      statusWidget = Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.success.withValues(alpha: 0.15),
          border: Border.all(color: AppColors.success, width: AppDimension.pixelBorderWidth),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppAssets.img(AppAssets.iconCheck, size: 10, color: AppColors.success),
            const SizedBox(width: 4),
            Text(
              'DONE',
              style: GoogleFonts.pressStart2p(
                fontSize: 6,
                fontWeight: FontWeight.bold,
                color: AppColors.success,
              ),
            ),
          ],
        ),
      );
    } else if (resolvedStatus == UserMissionStatus.inProgress ||
        resolvedStatus == UserMissionStatus.pendingVerification) {
      statusWidget = Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.15),
          border: Border.all(color: AppColors.primary, width: AppDimension.pixelBorderWidth),
        ),
        child: Text(
          '$completedTasks/$totalTasks',
          style: GoogleFonts.pressStart2p(
            fontSize: 6,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      );
    } else {
      statusWidget = Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.error.withValues(alpha: 0.15),
          border: Border.all(color: AppColors.error, width: AppDimension.pixelBorderWidth),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppAssets.img(AppAssets.iconWarning, size: 10, color: AppColors.error),
            const SizedBox(width: 4),
            Text(
              'OVERDUE',
              style: GoogleFonts.pressStart2p(
                fontSize: 6,
                fontWeight: FontWeight.bold,
                color: AppColors.error,
              ),
            ),
          ],
        ),
      );
    }

    return Opacity(
      opacity: isLocked ? 0.6 : 1.0,
      child: PixelBorderContainer(
        padding: const EdgeInsets.all(AppDimension.space12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title.toUpperCase(),
                          style: GoogleFonts.pressStart2p(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                            height: 1.4,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withValues(alpha: 0.15),
                          border: Border.all(color: AppColors.secondary, width: AppDimension.pixelBorderWidth),
                        ),
                        child: Text(
                          '$bonusPoints EXP',
                          style: GoogleFonts.pressStart2p(
                            fontSize: 5,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      AppAssets.img(
                        AppAssets.iconLocation,
                        size: 12,
                        color: subtextColor,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        resolvedLocation,
                        style: GoogleFonts.pressStart2p(
                          fontSize: 6,
                          color: subtextColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        'DUE: ',
                        style: GoogleFonts.pressStart2p(
                          fontSize: 6,
                          fontWeight: FontWeight.bold,
                          color: subtextColor,
                        ),
                      ),
                      Text(
                        deadline,
                        style: GoogleFonts.pressStart2p(
                          fontSize: 6,
                          color: subtextColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            statusWidget,
          ],
        ),
      ),
    );
  }
}
