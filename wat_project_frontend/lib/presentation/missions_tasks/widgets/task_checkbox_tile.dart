import 'package:flutter/material.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';
class TaskCheckboxTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool isChecked;
  final ValueChanged<bool?> onChanged;

  const TaskCheckboxTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimension.space8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 24,
            width: 24,
            child: Checkbox(
              value: isChecked,
              onChanged: onChanged,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimension.space4),
              ),
              side: const BorderSide(color: AppColors.secondary, width: 1.5),
              activeColor: AppColors.primary,
            ),
          ),
          const SizedBox(width: AppDimension.space16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: AppDimension.space4),
                  Text(
                    subtitle!,
                    style: const TextStyle(
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
    );
  }
}
