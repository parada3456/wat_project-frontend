import 'package:wat_project_frontend/domain/models/expense_transaction_model.dart';
import 'package:wat_project_frontend/domain/models/expense_split_model.dart';

class ExpenseDetailModel {
  final ExpenseTransactionModel transaction;
  final List<ExpenseSplitModel> splits;

  const ExpenseDetailModel({
    required this.transaction,
    required this.splits,
  });
}
