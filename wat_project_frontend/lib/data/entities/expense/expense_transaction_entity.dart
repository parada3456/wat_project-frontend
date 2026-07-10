import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/domain/models/expense_models.dart';

part 'expense_transaction_entity.g.dart';

@JsonSerializable()
class ExpenseTransactionEntity {
  @JsonKey(name: 'transaction_id')
  final String transactionId;
  @JsonKey(name: 'paid_by_user_id')
  final String paidByUserId;
  final String title;
  @JsonKey(name: 'total_amount')
  final double totalAmount;
  final String currency;
  final String? memo;
  @JsonKey(name: 'transaction_date')
  final DateTime transactionDate;
  @JsonKey(name: 'due_date')
  final DateTime? dueDate;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  ExpenseTransactionEntity({
    required this.transactionId,
    required this.paidByUserId,
    required this.title,
    required this.totalAmount,
    required this.currency,
    this.memo,
    required this.transactionDate,
    this.dueDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ExpenseTransactionEntity.fromJson(Map<String, dynamic> json) =>_$ExpenseTransactionEntityFromJson(json);
  Map<String, dynamic> toJson() => _$ExpenseTransactionEntityToJson(this);

  ExpenseTransactionModel toModel() => ExpenseTransactionModel(
    transactionId: transactionId,
    paidByUserId: paidByUserId,
    title: title,
    totalAmount: totalAmount,
    currency: currency,
    memo: memo,
    transactionDate: transactionDate,
    dueDate: dueDate,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
