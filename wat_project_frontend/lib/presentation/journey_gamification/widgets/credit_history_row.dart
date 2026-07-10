import 'package:flutter/material.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

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
    return Container(
      padding: const EdgeInsets.all(AppDimension.space16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppDimension.space8),
            decoration: BoxDecoration(
              color: isPositive
                  ? Colors.green.withOpacity(0.1)
                  : AppColors.error.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isPositive ? Icons.trending_up : Icons.trending_down,
              color: isPositive ? Colors.green : AppColors.error,
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
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${isPositive ? '+' : ''}$delta',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: isPositive ? Colors.green : AppColors.error,
            ),
          ),
        ],
      ),
    );
  }
}
