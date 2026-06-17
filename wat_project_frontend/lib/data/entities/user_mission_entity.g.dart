// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_mission_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserMissionEntity _$UserMissionEntityFromJson(Map<String, dynamic> json) =>
    UserMissionEntity(
      userMissionId: json['user_mission_id'] as String,
      userId: json['user_id'] as String,
      missionId: json['mission_id'] as String,
      status: $enumDecode(_$UserMissionStatusEnumMap, json['status']),
      calculatedDueDate: json['calculated_due_date'] as String?,
      proofUrl: json['proof_url'] as String?,
      proofSubmittedAt: json['proof_submitted_at'] as String?,
      verifiedAt: json['verified_at'] as String?,
      verifiedBy: json['verified_by'] as String?,
      basePointsEarned: (json['base_points_earned'] as num).toInt(),
      speedBonusPoints: (json['speed_bonus_points'] as num).toInt(),
      streakBonusPoints: (json['streak_bonus_points'] as num).toInt(),
      firstCompleterBonusPoints: (json['first_completer_bonus_points'] as num)
          .toInt(),
      totalPointsEarned: (json['total_points_earned'] as num).toInt(),
      rewardedAt: json['rewarded_at'] as String?,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$UserMissionEntityToJson(UserMissionEntity instance) =>
    <String, dynamic>{
      'user_mission_id': instance.userMissionId,
      'user_id': instance.userId,
      'mission_id': instance.missionId,
      'status': _$UserMissionStatusEnumMap[instance.status]!,
      'calculated_due_date': instance.calculatedDueDate,
      'proof_url': instance.proofUrl,
      'proof_submitted_at': instance.proofSubmittedAt,
      'verified_at': instance.verifiedAt,
      'verified_by': instance.verifiedBy,
      'base_points_earned': instance.basePointsEarned,
      'speed_bonus_points': instance.speedBonusPoints,
      'streak_bonus_points': instance.streakBonusPoints,
      'first_completer_bonus_points': instance.firstCompleterBonusPoints,
      'total_points_earned': instance.totalPointsEarned,
      'rewarded_at': instance.rewardedAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

const _$UserMissionStatusEnumMap = {
  UserMissionStatus.notStarted: 'notStarted',
  UserMissionStatus.inProgress: 'inProgress',
  UserMissionStatus.pendingVerification: 'pendingVerification',
  UserMissionStatus.completed: 'completed',
  UserMissionStatus.overdue: 'overdue',
};
