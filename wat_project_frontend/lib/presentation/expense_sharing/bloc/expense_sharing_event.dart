import 'dart:io';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/expense/create_expense_request.dart';

part 'expense_sharing_event.freezed.dart';

@freezed
class ExpenseSharingEvent with _$ExpenseSharingEvent {
  const factory ExpenseSharingEvent.listExpensesRequested() = ListExpensesRequested;
  const factory ExpenseSharingEvent.createExpenseSubmitted(CreateExpenseRequest request) = CreateExpenseSubmitted;
  const factory ExpenseSharingEvent.getExpenseDetailRequested(String id) = GetExpenseDetailRequested;
  const factory ExpenseSharingEvent.deleteExpenseSubmitted(String id) = DeleteExpenseSubmitted;
  const factory ExpenseSharingEvent.listPendingSplitsRequested() = ListPendingSplitsRequested;
  const factory ExpenseSharingEvent.payExpenseSplitSubmitted({
    required String expenseId,
    required String splitId,
    required File file,
  }) = PayExpenseSplitSubmitted;
  const factory ExpenseSharingEvent.approveExpenseSplitPaymentSubmitted({
    required String expenseId,
    required String splitId,
  }) = ApproveExpenseSplitPaymentSubmitted;
}
