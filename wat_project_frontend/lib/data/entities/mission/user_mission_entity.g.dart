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
      calculatedDueDate: json['calculated_due_date'] == null
          ? null
          : DateTime.parse(json['calculated_due_date'] as String),
      proofUrl: json['proof_url'] as String?,
      proofSubmittedAt: json['proof_submitted_at'] == null
          ? null
          : DateTime.parse(json['proof_submitted_at'] as String),
      verifiedAt: json['verified_at'] == null
          ? null
          : DateTime.parse(json['verified_at'] as String),
      verifiedBy: json['verified_by'] as String?,
      basePointsEarned: (json['base_points_earned'] as num).toInt(),
      speedBonusPoints: (json['speed_bonus_points'] as num).toInt(),
      streakBonusPoints: (json['streak_bonus_points'] as num).toInt(),
      firstCompleterBonusPoints: (json['first_completer_bonus_points'] as num)
          .toInt(),
      totalPointsEarned: (json['total_points_earned'] as num).toInt(),
      rewardedAt: json['rewarded_at'] == null
          ? null
          : DateTime.parse(json['rewarded_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$UserMissionEntityToJson(UserMissionEntity instance) =>
    <String, dynamic>{
      'user_mission_id': instance.userMissionId,
      'user_id': instance.userId,
      'mission_id': instance.missionId,
      'status': _$UserMissionStatusEnumMap[instance.status]!,
      'calculated_due_date': instance.calculatedDueDate?.toIso8601String(),
      'proof_url': instance.proofUrl,
      'proof_submitted_at': instance.proofSubmittedAt?.toIso8601String(),
      'verified_at': instance.verifiedAt?.toIso8601String(),
      'verified_by': instance.verifiedBy,
      'base_points_earned': instance.basePointsEarned,
      'speed_bonus_points': instance.speedBonusPoints,
      'streak_bonus_points': instance.streakBonusPoints,
      'first_completer_bonus_points': instance.firstCompleterBonusPoints,
      'total_points_earned': instance.totalPointsEarned,
      'rewarded_at': instance.rewardedAt?.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

const _$UserMissionStatusEnumMap = {
  UserMissionStatus.notStarted: 'not_started',
  UserMissionStatus.inProgress: 'in_progress',
  UserMissionStatus.pendingVerification: 'pending_verification',
  UserMissionStatus.completed: 'completed',
  UserMissionStatus.overdue: 'overdue',
};
