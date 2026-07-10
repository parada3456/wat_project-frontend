import 'package:flutter/material.dart';
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
    return Container(
      padding: const EdgeInsets.all(AppDimension.space16),
      decoration: BoxDecoration(
        color: isOverdue
            ? AppColors.error.withOpacity(0.05)
            : AppColors.background,
        borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
        border: Border.all(
          color: isOverdue ? AppColors.error : AppColors.surfaceAlt,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.surface,
            child: const Icon(Icons.person, color: AppColors.white),
          ),
          const SizedBox(width: AppDimension.space16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Owe $personName',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  'Due $dueDate',
                  style: TextStyle(
                    fontSize: 12,
                    color: isOverdue
                        ? AppColors.error
                        : AppColors.textSecondary,
                    fontWeight: isOverdue ? FontWeight.w700 : FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: isOverdue ? AppColors.error : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
