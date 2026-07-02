// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journey_phase_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JourneyPhaseEntity _$JourneyPhaseEntityFromJson(Map<String, dynamic> json) =>
    JourneyPhaseEntity(
      phaseId: json['PhaseId'] as String,
      phaseNumber: (json['PhaseNumber'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String?,
      createdAt: DateTime.parse(json['CreatedAt'] as String),
      updatedAt: DateTime.parse(json['UpdatedAt'] as String),
    );

Map<String, dynamic> _$JourneyPhaseEntityToJson(JourneyPhaseEntity instance) =>
    <String, dynamic>{
      'PhaseId': instance.phaseId,
      'PhaseNumber': instance.phaseNumber,
      'title': instance.title,
      'description': instance.description,
      'CreatedAt': instance.createdAt.toIso8601String(),
      'UpdatedAt': instance.updatedAt.toIso8601String(),
    };
