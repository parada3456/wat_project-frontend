import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:wat_project_frontend/domain/models/expense_models.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/bloc/expense_sharing_bloc.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/bloc/expense_sharing_event.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/bloc/expense_sharing_state.dart';
import 'package:wat_project_frontend/core/widgets/app_popup.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/widgets/expense_header_card.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/widgets/expense_metadata_list.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/widgets/expense_splits_list.dart';

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

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return DateFormat.yMMMMd().format(date.toLocal());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<ExpenseSharingBloc, ExpenseSharingState>(
        listener: (context, state) {
          state.whenOrNull(
            getExpenseDetailSuccess: (detail) {
              setState(() {
                _detail = detail;
                _isLoading = false;
              });
            },
            failure: (message) {
              setState(() => _isLoading = false);
              AppPopup.show<void>(
                context: context,
                type: AppPopupType.error,
                title: 'Error',
                message: message,
                buttons: [
                  AppPopupButton(label: 'OK', onPressed: () => context.pop())
                ],
              );
            },
          );
        },
        child: Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
              onPressed: () => context.pop(),
            ),
            title: const Text(
              'Expense Details',
              style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w700),
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

              final pendingSplit = splits.firstWhere(
                (s) => s.paymentStatus == PaymentStatus.pending || s.paymentStatus == PaymentStatus.overdue,
                orElse: () => splits.first,
              );

              final hasUnsettled = splits.any(
                (s) => s.paymentStatus == PaymentStatus.pending || s.paymentStatus == PaymentStatus.overdue,
              );

              return SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimension.space16, vertical: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ExpenseHeaderCard(
                        title: transaction.title,
                        formattedTransactionDate: _formatDate(transaction.transactionDate),
                        currency: transaction.currency,
                        totalAmount: transaction.totalAmount,
                        splitsCount: splits.length,
                      ),
                      const SizedBox(height: 24.0),
                      const Text(
                        'Details',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                      ),
                      const SizedBox(height: AppDimension.space8),
                      ExpenseMetadataList(
                        transaction: transaction,
                        formatDate: _formatDate,
                      ),
                      const SizedBox(height: 24.0),
                      const Text(
                        'Splits Status',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                      ),
                      const SizedBox(height: AppDimension.space8),
                      ExpenseSplitsList(
                        splits: splits,
                        currency: transaction.currency,
                        formatDate: _formatDate,
                      ),
                      const SizedBox(height: 24.0),
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
