import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:wat_project_frontend/domain/models/expense_models.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/bloc/expense_sharing_bloc.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/bloc/expense_sharing_event.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/bloc/expense_sharing_state.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/widgets/expense_history_card.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/widgets/pending_owe_tile.dart';
import 'package:wat_project_frontend/core/widgets/app_popup.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class ExpenseHistoryPage extends StatefulWidget {
  const ExpenseHistoryPage({super.key});

  @override
  State<ExpenseHistoryPage> createState() => _ExpenseHistoryPageState();
}

class _ExpenseHistoryPageState extends State<ExpenseHistoryPage> {
  late final ExpenseSharingBloc _bloc;
  List<ExpenseTransactionModel> _expenses = [];
  List<ExpenseSplitModel> _pendingSplits = [];
  bool _isLoadingExpenses = true;
  bool _isLoadingSplits = true;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.instance<ExpenseSharingBloc>();
    _bloc.add(const ListExpensesRequested());
    _bloc.add(const ListPendingSplitsRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<ExpenseSharingBloc, ExpenseSharingState>(
        listener: (context, state) {
          if (state is ListExpensesSuccess) {
            setState(() {
              _expenses = state.expenses;
              _isLoadingExpenses = false;
            });
          } else if (state is ListPendingSplitsSuccess) {
            setState(() {
              _pendingSplits = state.pendingSplits;
              _isLoadingSplits = false;
            });
          } else if (state is ExpenseSharingFailure) {
            setState(() {
              _isLoadingExpenses = false;
              _isLoadingSplits = false;
            });
            AppPopup.show<void>(
              context: context,
              type: AppPopupType.error,
              title: 'Error',
              message: state.message,
              buttons: [
                AppPopupButton(label: 'OK', onPressed: () => context.pop()),
              ],
            );
          }
        },
        child: Scaffold(
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
          floatingActionButton: FloatingActionButton(
            onPressed: () => context.push('/expenses/new'),
            backgroundColor: AppColors.primary,
            child: const Icon(Icons.add, color: Colors.white),
          ),
          body: BlocBuilder<ExpenseSharingBloc, ExpenseSharingState>(
            builder: (context, state) {
              if (_isLoadingExpenses && _isLoadingSplits) {
                return const Center(child: CircularProgressIndicator());
              }
              return SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppDimension.space16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_pendingSplits.isNotEmpty) ...[
                        const Text(
                          'Pending Payments',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: AppDimension.space16),
                        ..._pendingSplits.map(
                          (split) => GestureDetector(
                            onTap: () => context.push('/expenses/${split.transactionId}'),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: AppDimension.space8),
                              child: PendingOweTile(
                                personName: 'User #${split.userId.substring(0, split.userId.length > 5 ? 5 : split.userId.length)}',
                                amount: split.oweAmount,
                                dueDate: split.settledAt != null
                                    ? split.settledAt!.toLocal().toString().split(' ').first
                                    : 'Pending',
                                isOverdue: split.paymentStatus == PaymentStatus.overdue,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: AppDimension.space32),
                      ],
                      const Text(
                        'History',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: AppDimension.space16),
                      if (_expenses.isEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 32.0),
                          child: Center(
                            child: Text(
                              'No expenses yet.',
                              style: TextStyle(color: AppColors.textSecondary),
                            ),
                          ),
                        )
                      else
                        ..._expenses.map(
                          (expense) => GestureDetector(
                            onTap: () => context.push('/expenses/${expense.transactionId}'),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: AppDimension.space8),
                              child: ExpenseHistoryCard(
                                title: expense.title,
                                date: expense.transactionDate.toLocal().toString().split(' ').first,
                                amount: expense.totalAmount,
                                category: expense.memo ?? 'General',
                                isOwner: true,
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(height: AppDimension.space50),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
