import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/domain/models/expense_models.dart';
import 'package:wat_project_frontend/presentation/auth_profile/profile/bloc/profile_bloc.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/bloc/expense_sharing_bloc.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/widgets/expense_history_card.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/widgets/pending_owe_tile.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

class ExpenseDashboardPage extends StatelessWidget {
  const ExpenseDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ExpenseSharingBloc>(
          create: (context) => getIt<ExpenseSharingBloc>()
            ..add(const ListExpensesRequested())
            ..add(const ListPendingSplitsRequested()),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) =>
              getIt<ProfileBloc>()..add(const GetProfileEvent()),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.backgroundAlt,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          title: const Text(
            'Expenses Dashboard',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.push('/expenses/new'),
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add, color: Colors.white),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppDimension.space16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCreditScoreCard(context),
                const SizedBox(height: AppDimension.space32),
                _buildPendingPaymentsSection(context),
                const SizedBox(height: 24.0),
                _buildBillHistorySection(context),
                const SizedBox(height: AppDimension.space50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCreditScoreCard(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        final score = state.profile?.creditScore?.currentScore ?? 0;

        return Card(
          elevation: 0,
          color: AppColors.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
            side: BorderSide(
              color: AppColors.primary.withValues(alpha: 0.2),
            ),
          ),
          child: InkWell(
            onTap: () => context.push('/credit-history'),
            borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
            child: Padding(
              padding: const EdgeInsets.all(AppDimension.space16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppDimension.space12),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.credit_score,
                      color: AppColors.primary,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: AppDimension.space16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Credit Score',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '$score pts',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'History',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPendingPaymentsSection(BuildContext context) {
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
          ],
        );
      },
    );
  }

  Widget _buildBillHistorySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Bill History Preview',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            TextButton(
              onPressed: () => context.push('/expenses/history'),
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: AppDimension.space12),
        BlocBuilder<ExpenseSharingBloc, ExpenseSharingState>(
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
                padding: EdgeInsets.symmetric(vertical: 24.0),
                child: Center(
                  child: Text(
                    'No expenses recorded yet.',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ),
              );
            }

            return Column(
              children: expenses.take(5).map(
                (expense) => GestureDetector(
                  onTap: () =>
                      context.push('/expenses/${expense.transactionId}'),
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
        ),
      ],
    );
  }
}

