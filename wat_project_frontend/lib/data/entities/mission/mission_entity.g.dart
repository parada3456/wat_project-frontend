// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MissionEntity _$MissionEntityFromJson(Map<String, dynamic> json) =>
    MissionEntity(
      missionId: json['mission_id'] as String,
      phaseId: json['phase_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      location: json['location'] as String?,
      basePoints: (json['base_points'] as num).toInt(),
      isMandatory: json['is_mandatory'] as bool,
      verificationType: $enumDecode(
        _$VerificationTypeEnumMap,
        json['verification_type'],
      ),
      dueDateType: json['due_date_type'] as String?,
      fixedDueDate: json['fixed_due_date'] == null
          ? null
          : DateTime.parse(json['fixed_due_date'] as String),
      relativeTriggerEvent: json['relative_trigger_event'] as String?,
      relativeDaysOffset: (json['relative_days_offset'] as num?)?.toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$MissionEntityToJson(
  MissionEntity instance,
) => <String, dynamic>{
  'mission_id': instance.missionId,
  'phase_id': instance.phaseId,
  'title': instance.title,
  'description': instance.description,
  'location': instance.location,
  'base_points': instance.basePoints,
  'is_mandatory': instance.isMandatory,
  'verification_type': _$VerificationTypeEnumMap[instance.verificationType]!,
  'due_date_type': instance.dueDateType,
  'fixed_due_date': instance.fixedDueDate?.toIso8601String(),
  'relative_trigger_event': instance.relativeTriggerEvent,
  'relative_days_offset': instance.relativeDaysOffset,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};

const _$VerificationTypeEnumMap = {
  VerificationType.none: 'none',
  VerificationType.upload: 'upload',
  VerificationType.admin: 'admin',
};
