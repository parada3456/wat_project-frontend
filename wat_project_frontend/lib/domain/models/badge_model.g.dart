// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BadgeModel _$BadgeModelFromJson(Map<String, dynamic> json) => BadgeModel(
  badgeId: json['badgeId'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  triggerType: $enumDecode(_$BadgeTriggerTypeEnumMap, json['triggerType']),
  iconUrl: json['iconUrl'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$BadgeModelToJson(BadgeModel instance) =>
    <String, dynamic>{
      'badgeId': instance.badgeId,
      'title': instance.title,
      'description': instance.description,
      'triggerType': _$BadgeTriggerTypeEnumMap[instance.triggerType]!,
      'iconUrl': instance.iconUrl,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$BadgeTriggerTypeEnumMap = {
  BadgeTriggerType.speed: 'Speed',
  BadgeTriggerType.streak: 'Streak',
  BadgeTriggerType.firstCompleter: 'First_Completer',
  BadgeTriggerType.phaseComplete: 'Phase_Complete',
  BadgeTriggerType.manual: 'Manual',
};
