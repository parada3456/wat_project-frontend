// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_ledger_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointLedgerEntity _$PointLedgerEntityFromJson(Map<String, dynamic> json) =>
    PointLedgerEntity(
      ledgerId: json['ledger_id'] as String,
      userId: json['user_id'] as String,
      sourceType: $enumDecode(_$PointSourceTypeEnumMap, json['source_type']),
      sourceId: json['source_id'] as String,
      delta: (json['delta'] as num).toInt(),
      lifetimeBalanceAfter: (json['lifetime_balance_after'] as num).toInt(),
      phaseBalanceAfter: (json['phase_balance_after'] as num).toInt(),
      note: json['note'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$PointLedgerEntityToJson(PointLedgerEntity instance) =>
    <String, dynamic>{
      'ledger_id': instance.ledgerId,
      'user_id': instance.userId,
      'source_type': _$PointSourceTypeEnumMap[instance.sourceType]!,
      'source_id': instance.sourceId,
      'delta': instance.delta,
      'lifetime_balance_after': instance.lifetimeBalanceAfter,
      'phase_balance_after': instance.phaseBalanceAfter,
      'note': instance.note,
      'created_at': instance.createdAt.toIso8601String(),
    };

const _$PointSourceTypeEnumMap = {
  PointSourceType.missionBase: 'Mission_Base',
  PointSourceType.speedBonus: 'Speed_Bonus',
  PointSourceType.streakBonus: 'Streak_Bonus',
  PointSourceType.firstCompleter: 'First_Completer',
  PointSourceType.expensePenalty: 'Expense_Penalty',
  PointSourceType.adminAdjust: 'Admin_Adjust',
};
