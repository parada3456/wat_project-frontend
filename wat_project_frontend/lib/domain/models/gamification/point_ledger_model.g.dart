// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_ledger_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointLedgerModel _$PointLedgerModelFromJson(Map<String, dynamic> json) =>
    PointLedgerModel(
      ledgerId: json['ledgerId'] as String,
      userId: json['userId'] as String,
      sourceType: $enumDecode(_$PointSourceTypeEnumMap, json['sourceType']),
      sourceId: json['sourceId'] as String,
      delta: (json['delta'] as num).toInt(),
      lifetimeBalanceAfter: (json['lifetimeBalanceAfter'] as num).toInt(),
      phaseBalanceAfter: (json['phaseBalanceAfter'] as num).toInt(),
      note: json['note'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$PointLedgerModelToJson(PointLedgerModel instance) =>
    <String, dynamic>{
      'ledgerId': instance.ledgerId,
      'userId': instance.userId,
      'sourceType': _$PointSourceTypeEnumMap[instance.sourceType]!,
      'sourceId': instance.sourceId,
      'delta': instance.delta,
      'lifetimeBalanceAfter': instance.lifetimeBalanceAfter,
      'phaseBalanceAfter': instance.phaseBalanceAfter,
      'note': instance.note,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$PointSourceTypeEnumMap = {
  PointSourceType.missionBase: 'Mission_Base',
  PointSourceType.speedBonus: 'Speed_Bonus',
  PointSourceType.streakBonus: 'Streak_Bonus',
  PointSourceType.firstCompleter: 'First_Completer',
  PointSourceType.expensePenalty: 'Expense_Penalty',
  PointSourceType.adminAdjust: 'Admin_Adjust',
};
