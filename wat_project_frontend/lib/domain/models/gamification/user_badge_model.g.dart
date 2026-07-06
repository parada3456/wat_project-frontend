// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_badge_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBadgeModel _$UserBadgeModelFromJson(Map<String, dynamic> json) =>
    UserBadgeModel(
      userBadgeId: json['userBadgeId'] as String,
      userId: json['userId'] as String,
      badgeId: json['badgeId'] as String,
      sourceId: json['sourceId'] as String?,
      earnedAt: DateTime.parse(json['earnedAt'] as String),
      badge: BadgeModel.fromJson(json['badge'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserBadgeModelToJson(UserBadgeModel instance) =>
    <String, dynamic>{
      'userBadgeId': instance.userBadgeId,
      'userId': instance.userId,
      'badgeId': instance.badgeId,
      'sourceId': instance.sourceId,
      'earnedAt': instance.earnedAt.toIso8601String(),
      'badge': instance.badge,
    };
