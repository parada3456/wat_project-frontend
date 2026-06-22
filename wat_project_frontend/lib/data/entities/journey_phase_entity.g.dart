// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journey_phase_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JourneyPhaseEntity _$JourneyPhaseEntityFromJson(Map<String, dynamic> json) =>
    JourneyPhaseEntity(
      phaseId: json['phase_id'] as String,
      phaseNumber: (json['phase_number'] as num).toInt(),
      title: json['name'] as String,
      description: json['description'] as String?,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$JourneyPhaseEntityToJson(JourneyPhaseEntity instance) =>
    <String, dynamic>{
      'phase_id': instance.phaseId,
      'phase_number': instance.phaseNumber,
      'name': instance.title,
      'description': instance.description,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
