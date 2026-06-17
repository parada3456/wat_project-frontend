// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity(
  id: json['user_id'] as String,
  email: json['email'] as String,
  firstName: json['first_name'] as String?,
  lastName: json['last_name'] as String?,
  currentPhaseId: json['current_phase_id'] as String?,
  totalLifetimePoints: (json['total_lifetime_points'] as num).toInt(),
  currentPhasePoints: (json['current_phase_points'] as num).toInt(),
  missionStreak: (json['mission_streak'] as num).toInt(),
  arrivalDate: json['arrival_date'] as String?,
  jobStartDate: json['job_start_date'] as String?,
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
);

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'user_id': instance.id,
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'current_phase_id': instance.currentPhaseId,
      'total_lifetime_points': instance.totalLifetimePoints,
      'current_phase_points': instance.currentPhasePoints,
      'mission_streak': instance.missionStreak,
      'arrival_date': instance.arrivalDate,
      'job_start_date': instance.jobStartDate,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
