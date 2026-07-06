import 'package:json_annotation/json_annotation.dart';

part 'expense_transaction_model.g.dart';

@JsonSerializable()
class ExpenseTransactionModel {
  final String transactionId;
  final String paidByUserId;
  final String title;
  final double totalAmount;
  final String currency;
  final String? memo;
  final DateTime transactionDate;
  final DateTime? dueDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ExpenseTransactionModel({
    required this.transactionId,
    required this.paidByUserId,
    required this.title,
    required this.totalAmount,
    this.currency = 'USD',
    this.memo,
    required this.transactionDate,
    this.dueDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ExpenseTransactionModel.fromJson(Map<String, dynamic> json) =>
      _$ExpenseTransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseTransactionModelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseTransactionModel &&
          runtimeType == other.runtimeType &&
          transactionId == other.transactionId &&
          paidByUserId == other.paidByUserId &&
          title == other.title &&
          totalAmount == other.totalAmount &&
          currency == other.currency &&
          memo == other.memo &&
          transactionDate == other.transactionDate &&
          dueDate == other.dueDate &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode => Object.hash(
        transactionId,
        paidByUserId,
        title,
        totalAmount,
        currency,
        memo,
        transactionDate,
        dueDate,
        createdAt,
        updatedAt,
      );
}
