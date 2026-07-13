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
                  AppPopupButton(
                    label: 'OK', 
                    onPressed: () => Navigator.pop(context),
                  )
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

              final pendingSplit = splits.firstWhere(
                (s) => s.paymentStatus == PaymentStatus.pending || s.paymentStatus == PaymentStatus.overdue,
                orElse: () => splits.first,
              );

              final hasUnsettled = splits.any(
                (s) => s.paymentStatus == PaymentStatus.pending || s.paymentStatus == PaymentStatus.overdue,
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
                      // Header Card
                      Card(
                        elevation: 0,
                        color: AppColors.backgroundAlt,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(AppDimension.space16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                transaction.title,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Transaction Date: ${_formatDate(transaction.transactionDate)}',
                                style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                              ),
                              const Divider(height: 32),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Total Amount',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${transaction.currency} ${transaction.totalAmount.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w800,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      '${splits.length} splits',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24.0),

                      // Metadata & Specs
                      const Text(
                        'Details',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: AppDimension.space8),
                      Card(
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
                              _buildMetaRow('Due Date', _formatDate(transaction.dueDate)),
                              const Divider(),
                              _buildMetaRow('Memo / Notes', transaction.memo ?? 'General'),
                              const Divider(),
                              _buildMetaRow('Created At', _formatDate(transaction.createdAt)),
                              const Divider(),
                              _buildMetaRow('Last Updated', _formatDate(transaction.updatedAt)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24.0),

                      // Splits Details
                      const Text(
                        'Splits Status',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: AppDimension.space8),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: splits.length,
                        itemBuilder: (context, index) {
                          final split = splits[index];
                          final statusText = split.paymentStatus.name[0].toUpperCase() + split.paymentStatus.name.substring(1);
                          final approvalText = split.approvalStatus.name[0].toUpperCase() + split.approvalStatus.name.substring(1);
                          
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
                                          split.userId.substring(split.userId.length > 5 ? split.userId.length - 2 : 0).toUpperCase(),
                                          style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'User ID: ${split.userId}',
                                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                            ),
                                            Text(
                                              'Owe: ${transaction.currency} ${split.oweAmount.toStringAsFixed(2)}',
                                              style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: _getStatusColor(split.paymentStatus).withValues(alpha: 0.1),
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
                                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                                      ),
                                      if (split.settledAt != null)
                                        Text(
                                          'Settled: ${_formatDate(split.settledAt)}',
                                          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
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
