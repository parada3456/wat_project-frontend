import 'package:flutter/material.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/widgets/payment_split_status_tile.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class ExpenseDetailsPage extends StatelessWidget {
  const ExpenseDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Expense Details',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimension.space32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pizza Night',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const Text(
                'June 15, 2026',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppDimension.space32),
              Row(
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Amount',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        '\$85.20',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Split (3)',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimension.space32),
              const Text(
                'Status',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppDimension.space16),
              const PaymentSplitStatusTile(
                name: 'You',
                amount: 28.40,
                status: 'Paid',
              ),
              const Divider(height: 1, indent: 56),
              const PaymentSplitStatusTile(
                name: 'Alex Smith',
                amount: 28.40,
                status: 'Pending',
              ),
              const Divider(height: 1, indent: 56),
              const PaymentSplitStatusTile(
                name: 'Maria Garcia',
                amount: 28.40,
                status: 'Paid',
              ),
              const SizedBox(height: AppDimension.space32),
              WatButton(
                label: 'Settle Up',
                onPressed: () {
                  // TODO: Navigate to Payment Submission
                },
              ),
              const SizedBox(height: AppDimension.space50),
            ],
          ),
        ),
      ),
    );
  }
}
