import 'package:flutter/material.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';
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

    // Resolve deadline string
    final due = mission.userMission?.calculatedDueDate;
    final String deadline;
    if (due == null) {
      deadline = 'Soon';
    } else {
      final months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      deadline = '${due.day} ${months[due.month - 1]}';
    }

    // Resolve location
    final resolvedLocation =
        location ?? (isMandatory ? 'Mandatory' : 'Optional');

    // Resolve status and task counts
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

    final resolvedTotalTasks = totalTasks;
    final resolvedCompletedTasks = completedTasks;

    // Determine status widget matching the wireframe design
    Widget statusWidget;

    if (isLocked) {
      statusWidget = Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.lock_outline, size: 14, color: Colors.grey[600]),
            const SizedBox(width: 4),
            Text(
              'Locked',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    } else if (resolvedStatus == UserMissionStatus.notStarted) {
      statusWidget = ElevatedButton.icon(
        onPressed: onJoinTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
          shadowColor: Colors.black.withOpacity(0.1),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.grey[300]!),
          ),
        ),
        icon: const Icon(Icons.play_circle_outline, size: 14),
        label: const Text(
          'Start',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      );
    } else if (resolvedStatus == UserMissionStatus.completed) {
      statusWidget = Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.green[50],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.green[200]!),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 14,
              color: Colors.green[700],
            ),
            const SizedBox(width: 4),
            Text(
              'Complete',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.green[700],
              ),
            ),
          ],
        ),
      );
    } else if (resolvedStatus == UserMissionStatus.inProgress ||
        resolvedStatus == UserMissionStatus.pendingVerification) {
      statusWidget = Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.blue[200]!),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 10,
              height: 10,
              child: CircularProgressIndicator(
                value: resolvedTotalTasks > 0
                    ? resolvedCompletedTasks / resolvedTotalTasks
                    : 0.0,
                strokeWidth: 2,
                color: Colors.blue[700],
                backgroundColor: Colors.blue[100],
              ),
            ),
            const SizedBox(width: 6),
            Text(
              'In progress $resolvedCompletedTasks/$resolvedTotalTasks',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.blue[700],
              ),
            ),
          ],
        ),
      );
    } else {
      // Overdue
      statusWidget = Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.red[50],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.red[200]!),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 14, color: Colors.red[700]),
            const SizedBox(width: 4),
            Text(
              'Overdue',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.red[700],
              ),
            ),
          ],
        ),
      );
    }

    return Opacity(
      opacity: isLocked ? 0.6 : 1.0,
      child: Container(
        padding: const EdgeInsets.all(AppDimension.space16),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.amber[200]!),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '$bonusPoints',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber[800],
                              ),
                            ),
                            const SizedBox(width: 2),
                            Text(
                              '✦',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.amber[800],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        resolvedLocation,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Text(
                        'Due: ',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        deadline,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            statusWidget,
          ],
        ),
      ),
    );
  }
}
