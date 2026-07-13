import 'package:flutter/material.dart';
import 'package:wat_project_frontend/domain/models/expense_models.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class ExpenseMetadataList extends StatelessWidget {
  final ExpenseTransactionModel transaction;
  final String Function(DateTime?) formatDate;

  const ExpenseMetadataList({
    super.key,
    required this.transaction,
    required this.formatDate,
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
          children: [
            _buildMetaRow('Transaction ID', transaction.transactionId),
            const Divider(),
            _buildMetaRow('Paid By', transaction.paidByUserId),
            const Divider(),
            _buildMetaRow('Due Date', formatDate(transaction.dueDate)),
            const Divider(),
            _buildMetaRow('Memo / Notes', transaction.memo ?? 'General'),
            const Divider(),
            _buildMetaRow('Created At', formatDate(transaction.createdAt)),
            const Divider(),
            _buildMetaRow('Last Updated', formatDate(transaction.updatedAt)),
          ],
        ),
      ),
    );
  }

  Widget _buildMetaRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
