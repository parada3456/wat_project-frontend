import 'package:wat_project_frontend/domain/models/expense_transaction_model.dart';
import 'package:wat_project_frontend/domain/models/expense_split_model.dart';
import 'package:wat_project_frontend/domain/models/expense_detail_model.dart';

abstract class ExpenseSharingState {
  const ExpenseSharingState();
}

class ExpenseSharingInitial extends ExpenseSharingState {
  const ExpenseSharingInitial();
}

class ExpenseSharingLoading extends ExpenseSharingState {
  const ExpenseSharingLoading();
}

class ListExpensesSuccess extends ExpenseSharingState {
  final List<ExpenseTransactionModel> expenses;
  const ListExpensesSuccess(this.expenses);
}

class CreateExpenseSuccess extends ExpenseSharingState {
  const CreateExpenseSuccess();
}

class GetExpenseDetailSuccess extends ExpenseSharingState {
  final ExpenseDetailModel expenseDetail;
  const GetExpenseDetailSuccess(this.expenseDetail);
}

class DeleteExpenseSuccess extends ExpenseSharingState {
  const DeleteExpenseSuccess();
}

class ListPendingSplitsSuccess extends ExpenseSharingState {
  final List<ExpenseSplitModel> pendingSplits;
  const ListPendingSplitsSuccess(this.pendingSplits);
}

class PayExpenseSplitSuccess extends ExpenseSharingState {
  const PayExpenseSplitSuccess();
}

class ApproveExpenseSplitPaymentSuccess extends ExpenseSharingState {
  const ApproveExpenseSplitPaymentSuccess();
}

class ExpenseSharingFailure extends ExpenseSharingState {
  final String message;
  const ExpenseSharingFailure(this.message);
}
