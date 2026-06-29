import 'dart:io';
import 'package:wat_project_frontend/data/sources/api/api_model/expense/create_expense_request.dart';

abstract class ExpenseSharingEvent {
  const ExpenseSharingEvent();
}

class ListExpensesRequested extends ExpenseSharingEvent {
  const ListExpensesRequested();
}

class CreateExpenseSubmitted extends ExpenseSharingEvent {
  final CreateExpenseRequest request;
  const CreateExpenseSubmitted(this.request);
}

class GetExpenseDetailRequested extends ExpenseSharingEvent {
  final String id;
  const GetExpenseDetailRequested(this.id);
}

class DeleteExpenseSubmitted extends ExpenseSharingEvent {
  final String id;
  const DeleteExpenseSubmitted(this.id);
}

class ListPendingSplitsRequested extends ExpenseSharingEvent {
  const ListPendingSplitsRequested();
}

class PayExpenseSplitSubmitted extends ExpenseSharingEvent {
  final String expenseId;
  final String splitId;
  final File file;

  const PayExpenseSplitSubmitted({
    required this.expenseId,
    required this.splitId,
    required this.file,
  });
}

class ApproveExpenseSplitPaymentSubmitted extends ExpenseSharingEvent {
  final String expenseId;
  final String splitId;

  const ApproveExpenseSplitPaymentSubmitted({
    required this.expenseId,
    required this.splitId,
  });
}
