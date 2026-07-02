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
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$BadgeEntityToJson(BadgeEntity instance) =>
    <String, dynamic>{
      'badge_id': instance.badgeId,
      'title': instance.title,
      'description': instance.description,
      'trigger_type': _$BadgeTriggerTypeEnumMap[instance.triggerType]!,
      'icon_url': instance.iconUrl,
      'created_at': instance.createdAt.toIso8601String(),
    };

const _$BadgeTriggerTypeEnumMap = {
  BadgeTriggerType.speed: 'speed',
  BadgeTriggerType.streak: 'streak',
  BadgeTriggerType.firstCompleter: 'first_completer',
  BadgeTriggerType.phaseComplete: 'phase_complete',
  BadgeTriggerType.manual: 'manual',
};
