import 'dart:io';
import 'package:wat_project_frontend/domain/models/expense_transaction_model.dart';
import 'package:wat_project_frontend/domain/models/expense_split_model.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/expense/create_expense_request.dart';
import 'package:wat_project_frontend/data/entities/expense/expense_detail_response.dart';

import 'package:wat_project_frontend/data/entities/expense/expense_split_entity.dart';

abstract class ExpenseRepository {
  Future<List<ExpenseTransactionModel>> listExpenses();
  Future<void> createExpense(CreateExpenseRequest request);
  Future<ExpenseDetailResponse> getExpenseDetail(String id);
  Future<void> deleteExpense(String id);
  Future<List<ExpenseSplitModel>> listPendingExpenses();
  Future<List<ExpenseSplitEntity>> getExpenseSplitsByIds(List<String> ids);
  Future<void> paySplit(String expenseId, String splitId, File file);
  Future<void> approveSplit(String expenseId, String splitId);
}
