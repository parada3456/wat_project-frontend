// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_transaction_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseTransactionEntity _$ExpenseTransactionEntityFromJson(
  Map<String, dynamic> json,
) => ExpenseTransactionEntity(
  transactionId: json['transaction_id'] as String,
  paidByUserId: json['paid_by_user_id'] as String,
  title: json['title'] as String,
  totalAmount: (json['total_amount'] as num).toDouble(),
  currency: json['currency'] as String,
  memo: json['memo'] as String?,
  transactionDate: DateTime.parse(json['transaction_date'] as String),
  dueDate: json['due_date'] == null
      ? null
      : DateTime.parse(json['due_date'] as String),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$ExpenseTransactionEntityToJson(
  ExpenseTransactionEntity instance,
) => <String, dynamic>{
  'transaction_id': instance.transactionId,
  'paid_by_user_id': instance.paidByUserId,
  'title': instance.title,
  'total_amount': instance.totalAmount,
  'currency': instance.currency,
  'memo': instance.memo,
  'transaction_date': instance.transactionDate.toIso8601String(),
  'due_date': instance.dueDate?.toIso8601String(),
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};
