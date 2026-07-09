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
      userMission: json['user_mission'] == null
          ? null
          : UserMissionEntity.fromJson(
              json['user_mission'] as Map<String, dynamic>,
            ),
      tasks:
          (json['tasks'] as List<dynamic>?)
              ?.map((e) => TaskEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      isActive: json['is_active'] as bool,
      isLocked: json['is_locked'] as bool,
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
  'is_active': instance.isActive,
  'is_locked': instance.isLocked,
  'user_mission': instance.userMission,
  'tasks': instance.tasks,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};

const _$VerificationTypeEnumMap = {
  VerificationType.none: 'none',
  VerificationType.upload: 'upload',
  VerificationType.admin: 'admin',
};
