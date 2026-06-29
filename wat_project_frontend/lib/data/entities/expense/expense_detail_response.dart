import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/data/entities/expense/expense_split_entity.dart';
import 'package:wat_project_frontend/data/entities/expense/expense_transaction_entity.dart';

part 'expense_detail_response.g.dart';

@JsonSerializable()
class ExpenseDetailResponse {
  final ExpenseTransactionEntity transaction;
  final List<String> splits;

  ExpenseDetailResponse({
    required this.transaction,
    required this.splits,
  });

  factory ExpenseDetailResponse.fromJson(Map<String, dynamic> json) {
    return ExpenseDetailResponse(
      transaction: ExpenseTransactionEntity.fromJson(json['transaction'] as Map<String, dynamic>),
      splits: (json['splits'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
    );
  }
}
