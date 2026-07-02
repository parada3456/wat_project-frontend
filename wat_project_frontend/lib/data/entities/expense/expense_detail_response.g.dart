// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseDetailResponse _$ExpenseDetailResponseFromJson(
  Map<String, dynamic> json,
) => ExpenseDetailResponse(
  transaction: ExpenseTransactionEntity.fromJson(
    json['transaction'] as Map<String, dynamic>,
  ),
  splits: (json['splits'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$ExpenseDetailResponseToJson(
  ExpenseDetailResponse instance,
) => <String, dynamic>{
  'transaction': instance.transaction,
  'splits': instance.splits,
};
