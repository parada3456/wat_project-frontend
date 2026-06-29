// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileEntity _$ProfileEntityFromJson(Map<String, dynamic> json) =>
    ProfileEntity(
      profileId: json['profile_id'] as String,
      userId: json['user_id'] as String,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      phoneNumber: json['phone_number'] as String?,
      bio: json['bio'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      radarVisibility: $enumDecode(
        _$RadarVisibilityEnumMap,
        json['radar_visibility'],
      ),
      currentCoordinates: json['current_coordinates'] as String?,
      locationUpdatedAt: DateTime.parse(json['location_updated_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$ProfileEntityToJson(ProfileEntity instance) =>
    <String, dynamic>{
      'profile_id': instance.profileId,
      'user_id': instance.userId,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'phone_number': instance.phoneNumber,
      'bio': instance.bio,
      'avatar_url': instance.avatarUrl,
      'radar_visibility': _$RadarVisibilityEnumMap[instance.radarVisibility]!,
      'current_coordinates': instance.currentCoordinates,
      'location_updated_at': instance.locationUpdatedAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

const _$RadarVisibilityEnumMap = {
  RadarVisibility.showAnonymous: 'show_anonymous',
  RadarVisibility.showFriends: 'show_friends',
  RadarVisibility.hidden: 'hidden',
};
