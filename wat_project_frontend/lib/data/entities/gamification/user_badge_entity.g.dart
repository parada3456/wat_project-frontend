// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_badge_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBadgeEntity _$UserBadgeEntityFromJson(Map<String, dynamic> json) =>
    UserBadgeEntity(
      userBadgeId: json['user_badge_id'] as String,
      userId: json['user_id'] as String,
      badgeId: json['badge_id'] as String,
      sourceId: json['source_id'] as String?,
      earnedAt: DateTime.parse(json['earned_at'] as String),
    );

Map<String, dynamic> _$UserBadgeEntityToJson(UserBadgeEntity instance) =>
    <String, dynamic>{
      'user_badge_id': instance.userBadgeId,
      'user_id': instance.userId,
      'badge_id': instance.badgeId,
      'source_id': instance.sourceId,
      'earned_at': instance.earnedAt.toIso8601String(),
    };
