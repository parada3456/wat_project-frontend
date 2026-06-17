// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_expense_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateExpenseRequest _$CreateExpenseRequestFromJson(
  Map<String, dynamic> json,
) => CreateExpenseRequest(
  title: json['title'] as String,
  totalAmount: (json['total_amount'] as num).toDouble(),
  currency: json['currency'] as String,
  memo: json['memo'] as String?,
  dueDate: json['due_date'] as String,
  splits: (json['splits'] as List<dynamic>)
      .map((e) => ExpenseSplitRequest.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CreateExpenseRequestToJson(
  CreateExpenseRequest instance,
) => <String, dynamic>{
  'title': instance.title,
  'total_amount': instance.totalAmount,
  'currency': instance.currency,
  'memo': instance.memo,
  'due_date': instance.dueDate,
  'splits': instance.splits,
};

ExpenseSplitRequest _$ExpenseSplitRequestFromJson(Map<String, dynamic> json) =>
    ExpenseSplitRequest(
      userId: json['user_id'] as String,
      oweAmount: (json['owe_amount'] as num).toDouble(),
    );

Map<String, dynamic> _$ExpenseSplitRequestToJson(
  ExpenseSplitRequest instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'owe_amount': instance.oweAmount,
};
