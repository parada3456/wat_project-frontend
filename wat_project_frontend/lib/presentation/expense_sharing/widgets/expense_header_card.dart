import 'package:flutter/material.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

class ExpenseHeaderCard extends StatelessWidget {
  final String title;
  final String formattedTransactionDate;
  final String currency;
  final double totalAmount;
  final int splitsCount;

  const ExpenseHeaderCard({
    super.key,
    required this.title,
    required this.formattedTransactionDate,
    required this.currency,
    required this.totalAmount,
    required this.splitsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.backgroundAlt,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimension.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Transaction Date: $formattedTransactionDate',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
            const Divider(height: 32),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Amount',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$currency ${totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '$splitsCount splits',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
