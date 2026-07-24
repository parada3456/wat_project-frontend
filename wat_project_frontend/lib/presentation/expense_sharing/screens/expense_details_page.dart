import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wat_project_frontend/core/utils/date_formatter.dart';
import 'package:wat_project_frontend/core/widgets/app_popup.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/domain/models/expense_models.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/bloc/expense_sharing_bloc.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/widgets/expense_header_card.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/widgets/expense_metadata_list.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/widgets/expense_splits_list.dart';

class ExpenseDetailsPage extends StatelessWidget {
  final String expenseId;
  const ExpenseDetailsPage({super.key, required this.expenseId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExpenseSharingBloc>(
      create: (context) => getIt<ExpenseSharingBloc>()
        ..add(GetExpenseDetailRequested(expenseId)),
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
        body: BlocConsumer<ExpenseSharingBloc, ExpenseSharingState>(
          listener: (context, state) {
            state.whenOrNull(
              failure: (message) {
                AppPopup.show<void>(
                  context: context,
                  type: AppPopupType.error,
                  title: 'Error',
                  message: message,
                  buttons: [
                    AppPopupButton(
                      label: 'OK',
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                );
              },
            );
          },
          builder: (context, state) {
            if (state is ExpenseSharingLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            ExpenseDetailModel? detail;
            if (state is GetExpenseDetailSuccess) {
              detail = state.expenseDetail;
            }

            if (detail == null) {
              return const Center(child: Text('Expense details not found.'));
            }

            final transaction = detail.transaction;
            final splits = detail.splits;

            final pendingSplit = splits.firstWhere(
              (s) =>
                  s.paymentStatus == PaymentStatus.pending ||
                  s.paymentStatus == PaymentStatus.overdue,
              orElse: () => splits.first,
            );

            final hasUnsettled = splits.any(
              (s) =>
                  s.paymentStatus == PaymentStatus.pending ||
                  s.paymentStatus == PaymentStatus.overdue,
            );

            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimension.space16,
                  vertical: 24.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ExpenseHeaderCard(
                      title: transaction.title,
                      formattedTransactionDate: DateFormatter.formatFullDate(
                        transaction.transactionDate,
                      ),
                      currency: transaction.currency,
                      totalAmount: transaction.totalAmount,
                      splitsCount: splits.length,
                    ),
                    const SizedBox(height: 24.0),
                    const Text(
                      'Details',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppDimension.space8),
                    ExpenseMetadataList(
                      transaction: transaction,
                      formatDate: DateFormatter.formatFullDate,
                    ),
                    const SizedBox(height: 24.0),
                    const Text(
                      'Splits Status',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppDimension.space8),
                    ExpenseSplitsList(
                      splits: splits,
                      currency: transaction.currency,
                      formatDate: DateFormatter.formatFullDate,
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
    );
  }
}

