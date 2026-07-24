import 'package:flutter/material.dart';
import 'package:wat_project_frontend/domain/models/expense_models.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

class ExpenseSplitsList extends StatelessWidget {
  final List<ExpenseSplitModel> splits;
  final String currency;
  final String Function(DateTime?) formatDate;

  const ExpenseSplitsList({
    super.key,
    required this.splits,
    required this.currency,
    required this.formatDate,
  });

  Color _getStatusColor(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.approved:
        return Colors.green;
      case PaymentStatus.submitted:
        return Colors.blue;
      case PaymentStatus.pending:
        return Colors.orange;
      case PaymentStatus.overdue:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: splits.length,
      itemBuilder: (context, index) {
        final split = splits[index];
        final statusText =
            split.paymentStatus.name[0].toUpperCase() +
            split.paymentStatus.name.substring(1);
        final approvalText =
            split.approvalStatus.name[0].toUpperCase() +
            split.approvalStatus.name.substring(1);

        return Card(
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimension.radiusSmall),
            side: BorderSide(color: Colors.grey[200]!),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppDimension.space12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                      child: Text(
                        split.userId
                            .substring(
                              split.userId.length > 5
                                  ? split.userId.length - 2
                                  : 0,
                            )
                            .toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'User ID: ${split.userId}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Owe: $currency ${split.oweAmount.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(
                          split.paymentStatus,
                        ).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        statusText,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: _getStatusColor(split.paymentStatus),
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Approval: $approvalText',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    if (split.settledAt != null)
                      Text(
                        'Settled: ${formatDate(split.settledAt)}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
