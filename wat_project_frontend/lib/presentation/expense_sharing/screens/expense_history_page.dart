import 'package:flutter/material.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/widgets/expense_history_card.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/widgets/pending_owe_tile.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class ExpenseHistoryPage extends StatelessWidget {
  const ExpenseHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundAlt,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Expenses',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimension.space16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pending Payments',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppDimension.space16),
              const PendingOweTile(
                personName: 'Alex Smith',
                amount: 45.50,
                dueDate: 'June 18',
              ),
              const SizedBox(height: AppDimension.space8),
              const PendingOweTile(
                personName: 'Maria Garcia',
                amount: 120.00,
                dueDate: 'June 10',
                isOverdue: true,
              ),
              const SizedBox(height: AppDimension.space32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'History',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Navigate to Create Expense
                    },
                    child: const Text('Add New'),
                  ),
                ],
              ),
              const SizedBox(height: AppDimension.space16),
              const ExpenseHistoryCard(
                title: 'Grocery Shopping',
                date: 'June 15, 2026',
                amount: 85.20,
                category: 'Food',
                isOwner: true,
              ),
              const SizedBox(height: AppDimension.space8),
              const ExpenseHistoryCard(
                title: 'Utility Bill (Water)',
                date: 'June 12, 2026',
                amount: 30.00,
                category: 'Housing',
              ),
              const SizedBox(height: AppDimension.space8),
              const ExpenseHistoryCard(
                title: 'Uber to Airport',
                date: 'June 05, 2026',
                amount: 45.00,
                category: 'Travel',
                isOwner: true,
              ),
              const SizedBox(height: AppDimension.space50),
            ],
          ),
        ),
      ),
    );
  }
}
