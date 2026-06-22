import 'dart:io';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wat_project_frontend/data/entities/expense_transaction_entity.dart';import 'package:wat_project_frontend/data/entities/expense_split_entity.dart';import 'package:wat_project_frontend/data/sources/api/api_model/create_expense_request.dart';import 'package:wat_project_frontend/data/sources/api/api_model/expense_detail_response.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/list_response.dart';

part 'expense_api_client.g.dart';

@RestApi()
abstract class ExpenseApiService {
  factory ExpenseApiService(Dio dio, {String baseUrl}) = _ExpenseApiService;

  @GET('expenses')
  Future<ListResponse<ExpenseTransactionEntity>> listExpenses();

  @POST('expenses')
  Future<void> createExpense(@Body() CreateExpenseRequest request);

  @GET('expenses/{id}')
  Future<ExpenseDetailResponse> getExpenseDetail(@Path('id') String id);

  @DELETE('expenses/{id}')
  Future<void> deleteExpense(@Path('id') String id);

  @GET('expense-splits')
  Future<ListResponse<ExpenseSplitEntity>> listPendingExpenses();

  @PATCH('expenses/{id}/splits/{splitId}')
  @MultiPart()
  Future<void> paySplit(
    @Path('id') String expenseId,
    @Path('splitId') String splitId,
    @Part(name: 'slip') File file,
  );

  @PATCH('expenses/{id}/splits/{splitId}')
  Future<void> approveSplit(
    @Path('id') String expenseId,
    @Path('splitId') String splitId,
  );
}
