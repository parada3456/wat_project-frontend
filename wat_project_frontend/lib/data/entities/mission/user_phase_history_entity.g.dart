// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_phase_history_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPhaseHistoryEntity _$UserPhaseHistoryEntityFromJson(
  Map<String, dynamic> json,
) => UserPhaseHistoryEntity(
  historyId: json['history_id'] as String,
  userId: json['user_id'] as String,
  phaseId: json['phase_id'] as String,
  phasePointsEarned: (json['phase_points_earned'] as num).toInt(),
  enteredAt: json['entered_at'] as String,
  completedAt: json['completed_at'] as String?,
);

Map<String, dynamic> _$UserPhaseHistoryEntityToJson(
  UserPhaseHistoryEntity instance,
) => <String, dynamic>{
  'history_id': instance.historyId,
  'user_id': instance.userId,
  'phase_id': instance.phaseId,
  'phase_points_earned': instance.phasePointsEarned,
  'entered_at': instance.enteredAt,
  'completed_at': instance.completedAt,
};
