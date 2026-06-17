import 'package:flutter/material.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';
class ExpenseHistoryCard extends StatelessWidget {
  final String title;
  final String date;
  final double amount;
  final String category;
  final bool isOwner;

  const ExpenseHistoryCard({
    super.key,
    required this.title,
    required this.date,
    required this.amount,
    required this.category,
    this.isOwner = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimension.space16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppDimension.space12),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppDimension.radiusSmall),
            ),
            child: Icon(
              _getCategoryIcon(category),
              color: AppColors.primary,
              size: 24,
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
                    fontWeight: FontWeight.w700,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${amount.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              if (isOwner)
                const Text(
                  'You paid',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'food':
        return Icons.restaurant_outlined;
      case 'housing':
        return Icons.home_outlined;
      case 'travel':
        return Icons.flight_outlined;
      default:
        return Icons.receipt_long_outlined;
    }
  }
}
