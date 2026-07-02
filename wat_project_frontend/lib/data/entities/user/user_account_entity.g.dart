// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_account_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAccountEntity _$UserAccountEntityFromJson(Map<String, dynamic> json) =>
    UserAccountEntity(
      userId: json['user_id'] as String,
      email: json['email'] as String,
      currentPhaseId: json['current_phase_id'] as String?,
      totalLifetimePoints: (json['total_lifetime_points'] as num?)?.toInt(),
      currentPhasePoints: (json['current_phase_points'] as num?)?.toInt(),
      missionStreak: (json['mission_streak'] as num?)?.toInt(),
      arrivalDate: json['arrival_date'] == null
          ? null
          : DateTime.parse(json['arrival_date'] as String),
      jobStartDate: json['job_start_date'] == null
          ? null
          : DateTime.parse(json['job_start_date'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      profileId: json['profile_id'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      phoneNumber: json['phone_number'] as String?,
      bio: json['bio'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      radarVisibility: $enumDecodeNullable(
        _$RadarVisibilityEnumMap,
        json['radar_visibility'],
      ),
      currentCoordinates: json['current_coordinates'] as String?,
      locationUpdatedAt: json['location_updated_at'] == null
          ? null
          : DateTime.parse(json['location_updated_at'] as String),
    );

Map<String, dynamic> _$UserAccountEntityToJson(UserAccountEntity instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'email': instance.email,
      'profile_id': instance.profileId,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'phone_number': instance.phoneNumber,
      'bio': instance.bio,
      'avatar_url': instance.avatarUrl,
      'radar_visibility': _$RadarVisibilityEnumMap[instance.radarVisibility],
      'current_coordinates': instance.currentCoordinates,
      'location_updated_at': instance.locationUpdatedAt?.toIso8601String(),
      'current_phase_id': instance.currentPhaseId,
      'total_lifetime_points': instance.totalLifetimePoints,
      'current_phase_points': instance.currentPhasePoints,
      'mission_streak': instance.missionStreak,
      'arrival_date': instance.arrivalDate?.toIso8601String(),
      'job_start_date': instance.jobStartDate?.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

const _$RadarVisibilityEnumMap = {
  RadarVisibility.showAnonymous: 'show_anonymous',
  RadarVisibility.showFriends: 'show_friends',
  RadarVisibility.hidden: 'hidden',
};
