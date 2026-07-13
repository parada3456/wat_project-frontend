import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:wat_project_frontend/domain/models/expense_models.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/bloc/expense_sharing_bloc.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/bloc/expense_sharing_event.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/bloc/expense_sharing_state.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/widgets/payment_split_status_tile.dart';
import 'package:wat_project_frontend/core/widgets/app_popup.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class ExpenseDetailsPage extends StatefulWidget {
  final String expenseId;
  const ExpenseDetailsPage({super.key, required this.expenseId});

  @override
  State<ExpenseDetailsPage> createState() => _ExpenseDetailsPageState();
}

class _ExpenseDetailsPageState extends State<ExpenseDetailsPage> {
  late final ExpenseSharingBloc _bloc;
  ExpenseDetailModel? _detail;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.instance<ExpenseSharingBloc>();
    _bloc.add(GetExpenseDetailRequested(widget.expenseId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<ExpenseSharingBloc, ExpenseSharingState>(
        listener: (context, state) {
          if (state is GetExpenseDetailSuccess) {
            setState(() {
              _detail = state.expenseDetail;
              _isLoading = false;
            });
          } else if (state is ExpenseSharingFailure) {
            setState(() => _isLoading = false);
            AppPopup.show(
              context: context,
              type: AppPopupType.error,
              title: 'Error',
              message: state.message,
              buttons: [AppPopupButton(label: 'OK', onPressed: () => Navigator.pop(context))],
            );
          }
        },
        child: Scaffold(
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
          body: BlocBuilder<ExpenseSharingBloc, ExpenseSharingState>(
            builder: (context, state) {
              if (_isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (_detail == null) {
                return const Center(child: Text('Expense details not found.'));
              }

              final transaction = _detail!.transaction;
              final splits = _detail!.splits;

              // Find if there is any pending split for which the user can pay.
              // For demonstration and test cases, we check if any split is pending or overdue.
              final pendingSplit = splits.firstWhere(
                (s) => s.paymentStatus == PaymentStatus.pending || s.paymentStatus == PaymentStatus.overdue,
                orElse: () => splits.first,
              );

              final hasUnsettled = splits.any(
                (s) => s.paymentStatus == PaymentStatus.pending || s.paymentStatus == PaymentStatus.overdue,
              );

              return SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppDimension.space32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction.title,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        transaction.transactionDate.toLocal().toString().split(' ').first,
                        style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: AppDimension.space32),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Total Amount',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              Text(
                                '\$${transaction.totalAmount.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
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
                              'Split (${splits.length})',
                              style: const TextStyle(
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
                      ...splits.map((split) {
                        final isPaid = split.paymentStatus == PaymentStatus.approved;
                        final statusText = split.paymentStatus.name[0].toUpperCase() + split.paymentStatus.name.substring(1);
                        return Column(
                          children: [
                            PaymentSplitStatusTile(
                              name: 'User #${split.userId.substring(0, split.userId.length > 5 ? 5 : split.userId.length)}',
                              amount: split.oweAmount,
                              status: isPaid ? 'Paid' : statusText,
                            ),
                            const Divider(height: 1, indent: 56),
                          ],
                        );
                      }),
                      const SizedBox(height: AppDimension.space32),
                      if (hasUnsettled)
                        WatButton(
                          label: 'Submit Payment Proof',
                          onPressed: () {
                            context.push(
                              '/expenses/${transaction.transactionId}/pay?splitId=${pendingSplit.splitId}',
                            );
                          },
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
