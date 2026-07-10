import 'package:flutter/material.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class JobCartItemTile extends StatelessWidget {
  final String title;
  final String company;
  final String status; // 'Saved', 'Applied'
  final VoidCallback onDelete;

  const JobCartItemTile({
    super.key,
    required this.title,
    required this.company,
    required this.status,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isApplied = status.toLowerCase() == 'applied';
    return Container(
      padding: const EdgeInsets.all(AppDimension.space16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.surfaceAlt,
              borderRadius: BorderRadius.circular(AppDimension.radiusSmall),
            ),
            child: const Icon(
              Icons.business,
              color: AppColors.primary,
              size: 20,
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
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  company,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isApplied
                  ? Colors.green.withOpacity(0.1)
                  : AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: isApplied ? Colors.green : AppColors.primary,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.delete_outline,
              color: AppColors.error,
              size: 20,
            ),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
