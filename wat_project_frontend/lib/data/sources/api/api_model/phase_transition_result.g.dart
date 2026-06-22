// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phase_transition_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhaseTransitionResult _$PhaseTransitionResultFromJson(
  Map<String, dynamic> json,
) => PhaseTransitionResult(
  transitioned: json['transitioned'] as bool,
  previousPhaseId: json['previousPhaseId'] as String?,
  newPhaseId: json['newPhaseId'] as String?,
  pointsRewarded: (json['pointsRewarded'] as num?)?.toInt(),
  completedAt: json['completedAt'] as String?,
);

Map<String, dynamic> _$PhaseTransitionResultToJson(
  PhaseTransitionResult instance,
) => <String, dynamic>{
  'transitioned': instance.transitioned,
  'previousPhaseId': instance.previousPhaseId,
  'newPhaseId': instance.newPhaseId,
  'pointsRewarded': instance.pointsRewarded,
  'completedAt': instance.completedAt,
};
