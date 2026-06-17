import 'package:flutter/material.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';
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
    return Column(
      children: [
        Row(
          children: [
            Column(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? AppColors.primary
                        : (isActive ? AppColors.white : AppColors.surface),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isActive ? AppColors.primary : AppColors.surface,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: isCompleted
                        ? const Icon(Icons.check, color: AppColors.white, size: 20)
                        : Text(
                            '$phaseNumber',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: isActive ? AppColors.primary : AppColors.textSecondary,
                            ),
                          ),
                  ),
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 60,
                    color: isCompleted ? AppColors.primary : AppColors.surface,
                  ),
              ],
            ),
            const SizedBox(width: AppDimension.space16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Phase $phaseNumber',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isActive ? AppColors.primary : AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: isActive ? AppColors.textPrimary : AppColors.textSecondary,
                    ),
                  ),
                  if (isActive) ...[
                    const SizedBox(height: AppDimension.space8),
                    const Text(
                      'You are currently here. Complete missions to unlock the next phase.',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
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
