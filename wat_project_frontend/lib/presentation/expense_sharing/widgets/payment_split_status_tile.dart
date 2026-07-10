import 'package:flutter/material.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class PaymentSplitStatusTile extends StatelessWidget {
  final String name;
  final double amount;
  final String status; // 'Paid', 'Pending'

  const PaymentSplitStatusTile({
    super.key,
    required this.name,
    required this.amount,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final isPaid = status.toLowerCase() == 'paid';
    return Container(
      padding: const EdgeInsets.all(AppDimension.space16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.surface,
            child: const Icon(Icons.person, size: 20, color: AppColors.white),
          ),
          const SizedBox(width: AppDimension.space16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  isPaid ? 'Paid' : 'Awaiting payment',
                  style: TextStyle(
                    fontSize: 12,
                    color: isPaid ? Colors.green : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
