import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/domain/models/expense_models.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/bloc/expense_sharing_bloc.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/widgets/expense_history_card.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/widgets/pending_owe_tile.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

class ExpenseHistoryPage extends StatelessWidget {
  const ExpenseHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExpenseSharingBloc>(
      create: (context) => getIt<ExpenseSharingBloc>()
        ..add(const ListExpensesRequested())
        ..add(const ListPendingSplitsRequested()),
      child: Scaffold(
        backgroundColor: AppColors.backgroundAlt,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          title: const Text(
            'Expenses History',
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
                _buildPendingSplitsSection(context),
                const Text(
                  'History',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppDimension.space16),
                _buildExpensesHistorySection(context),
                const SizedBox(height: AppDimension.space50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPendingSplitsSection(BuildContext context) {
    return BlocBuilder<ExpenseSharingBloc, ExpenseSharingState>(
      buildWhen: (previous, current) => current is ListPendingSplitsSuccess,
      builder: (context, state) {
        List<ExpenseSplitModel> pendingSplits = [];
        if (state is ListPendingSplitsSuccess) {
          pendingSplits = state.pendingSplits;
        }

        if (pendingSplits.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
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
            ...pendingSplits.map(
              (split) => GestureDetector(
                onTap: () => context.push('/expenses/${split.transactionId}'),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: AppDimension.space8),
                  child: PendingOweTile(
                    personName:
                        'User #${split.userId.substring(0, split.userId.length > 5 ? 5 : split.userId.length)}',
                    amount: split.oweAmount,
                    dueDate: split.settledAt != null
                        ? split.settledAt!
                              .toLocal()
                              .toString()
                              .split(' ')
                              .first
                        : 'Pending',
                    isOverdue: split.paymentStatus == PaymentStatus.overdue,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppDimension.space32),
          ],
        );
      },
    );
  }

  Widget _buildExpensesHistorySection(BuildContext context) {
    return BlocBuilder<ExpenseSharingBloc, ExpenseSharingState>(
      builder: (context, state) {
        if (state is ExpenseSharingLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        List<ExpenseTransactionModel> expenses = [];
        if (state is ListExpensesSuccess) {
          expenses = state.expenses;
        }

        if (expenses.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 32.0),
            child: Center(
              child: Text(
                'No expenses yet.',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
          );
        }

        return Column(
          children: expenses.map(
            (expense) => GestureDetector(
              onTap: () => context.push('/expenses/${expense.transactionId}'),
              child: Padding(
                padding: const EdgeInsets.only(bottom: AppDimension.space8),
                child: ExpenseHistoryCard(
                  title: expense.title,
                  date: expense.transactionDate
                      .toLocal()
                      .toString()
                      .split(' ')
                      .first,
                  amount: expense.totalAmount,
                  category: expense.memo ?? 'General',
                  isOwner: true,
                ),
              ),
            ),
          ).toList(),
        );
      },
    );
  }
}

