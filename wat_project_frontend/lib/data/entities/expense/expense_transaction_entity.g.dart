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
  transactionDate: json['transaction_date'] as String,
  dueDate: json['due_date'] as String?,
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
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
  'transaction_date': instance.transactionDate,
  'due_date': instance.dueDate,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
};
