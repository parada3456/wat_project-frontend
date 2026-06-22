import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/domain/models/expense_transaction_model.dart';
import 'package:wat_project_frontend/domain/models/expense_split_model.dart';
import 'package:wat_project_frontend/domain/repositories/expense_repository.dart';
import 'package:wat_project_frontend/data/sources/api/expense_api_client.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/create_expense_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/expense_detail_response.dart';


@injectable
class ExpenseRepoImpl implements ExpenseRepository {
  final ExpenseApiService _api;

  ExpenseRepoImpl(this._api);

  @override
  Future<List<ExpenseTransactionModel>> listExpenses() async {
    final response = await _api.listExpenses();
    return response.data.map((e) => e.toModel()).toList();
  }

  @override
  Future<void> createExpense(CreateExpenseRequest request) async {
    return _api.createExpense(request);
  }

  @override
  Future<ExpenseDetailResponse> getExpenseDetail(String id) async {
    return _api.getExpenseDetail(id);
  }

  @override
  Future<void> deleteExpense(String id) async {
    return _api.deleteExpense(id);
  }

  @override
  Future<List<ExpenseSplitModel>> listPendingExpenses() async {
    final response = await _api.listPendingExpenses();
    return response.data.map((e) => e.toModel()).toList();
  }

  @override
  Future<void> paySplit(String expenseId, String splitId, File file) async {
    return _api.paySplit(expenseId, splitId, file);
  }

  @override
  Future<void> approveSplit(String expenseId, String splitId) async {
    return _api.approveSplit(expenseId, splitId);
  }
}
