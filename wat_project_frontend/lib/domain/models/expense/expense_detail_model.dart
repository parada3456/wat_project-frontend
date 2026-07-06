import 'package:wat_project_frontend/domain/models/expense_models.dart';
import 'package:wat_project_frontend/domain/models/expense_models.dart';

class ExpenseDetailModel {
  final ExpenseTransactionModel transaction;
  final List<ExpenseSplitModel> splits;

  const ExpenseDetailModel({
    required this.transaction,
    required this.splits,
  });
}
