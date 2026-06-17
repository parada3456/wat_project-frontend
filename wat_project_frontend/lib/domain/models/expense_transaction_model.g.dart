// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseTransactionModel _$ExpenseTransactionModelFromJson(
  Map<String, dynamic> json,
) => ExpenseTransactionModel(
  transactionId: json['transactionId'] as String,
  paidByUserId: json['paidByUserId'] as String,
  title: json['title'] as String,
  totalAmount: (json['totalAmount'] as num).toDouble(),
  currency: json['currency'] as String? ?? 'USD',
  memo: json['memo'] as String?,
  transactionDate: DateTime.parse(json['transactionDate'] as String),
  dueDate: json['dueDate'] == null
      ? null
      : DateTime.parse(json['dueDate'] as String),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$ExpenseTransactionModelToJson(
  ExpenseTransactionModel instance,
) => <String, dynamic>{
  'transactionId': instance.transactionId,
  'paidByUserId': instance.paidByUserId,
  'title': instance.title,
  'totalAmount': instance.totalAmount,
  'currency': instance.currency,
  'memo': instance.memo,
  'transactionDate': instance.transactionDate.toIso8601String(),
  'dueDate': instance.dueDate?.toIso8601String(),
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};
