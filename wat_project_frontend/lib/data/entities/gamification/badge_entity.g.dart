// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BadgeEntity _$BadgeEntityFromJson(Map<String, dynamic> json) => BadgeEntity(
  badgeId: json['badge_id'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  triggerType: $enumDecode(_$BadgeTriggerTypeEnumMap, json['trigger_type']),
  iconUrl: json['icon_url'] as String?,
  createdAt: json['created_at'] as String,
);

Map<String, dynamic> _$BadgeEntityToJson(BadgeEntity instance) =>
    <String, dynamic>{
      'badge_id': instance.badgeId,
      'title': instance.title,
      'description': instance.description,
      'trigger_type': _$BadgeTriggerTypeEnumMap[instance.triggerType]!,
      'icon_url': instance.iconUrl,
      'created_at': instance.createdAt,
    };

const _$BadgeTriggerTypeEnumMap = {
  BadgeTriggerType.speed: 'Speed',
  BadgeTriggerType.streak: 'Streak',
  BadgeTriggerType.firstCompleter: 'First_Completer',
  BadgeTriggerType.phaseComplete: 'Phase_Complete',
  BadgeTriggerType.manual: 'Manual',
};
