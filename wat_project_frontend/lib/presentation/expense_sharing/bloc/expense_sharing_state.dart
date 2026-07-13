import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wat_project_frontend/domain/models/expense_models.dart';

part 'expense_sharing_state.freezed.dart';

@freezed
class ExpenseSharingState with _$ExpenseSharingState {
  const factory ExpenseSharingState.initial() = ExpenseSharingInitial;
  const factory ExpenseSharingState.loading() = ExpenseSharingLoading;
  const factory ExpenseSharingState.listExpensesSuccess({
    required List<ExpenseTransactionModel> expenses,
  }) = ListExpensesSuccess;
  const factory ExpenseSharingState.createExpenseSuccess() = CreateExpenseSuccess;
  const factory ExpenseSharingState.getExpenseDetailSuccess({
    required ExpenseDetailModel expenseDetail,
  }) = GetExpenseDetailSuccess;
  const factory ExpenseSharingState.deleteExpenseSuccess() = DeleteExpenseSuccess;
  const factory ExpenseSharingState.listPendingSplitsSuccess({
    required List<ExpenseSplitModel> pendingSplits,
  }) = ListPendingSplitsSuccess;
  const factory ExpenseSharingState.payExpenseSplitSuccess() = PayExpenseSplitSuccess;
  const factory ExpenseSharingState.approveExpenseSplitPaymentSuccess() = ApproveExpenseSplitPaymentSuccess;
  const factory ExpenseSharingState.failure({
    required String message,
  }) = ExpenseSharingFailure;
}
