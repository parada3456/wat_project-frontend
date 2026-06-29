// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_mission_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyMissionRequest _$VerifyMissionRequestFromJson(
  Map<String, dynamic> json,
) => VerifyMissionRequest(
  approved: json['approved'] as bool,
  rejectionReason: json['rejectionReason'] as String?,
);

Map<String, dynamic> _$VerifyMissionRequestToJson(
  VerifyMissionRequest instance,
) => <String, dynamic>{
  'approved': instance.approved,
  'rejectionReason': instance.rejectionReason,
};
