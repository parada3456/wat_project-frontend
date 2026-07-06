// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_mission_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyMissionResponse _$VerifyMissionResponseFromJson(
  Map<String, dynamic> json,
) => VerifyMissionResponse(
  userMissionId: json['user_mission_id'] as String,
  status: json['status'] as String,
  verifiedAt: json['verified_at'] as String?,
  verifiedBy: json['verified_by'] as String?,
);

Map<String, dynamic> _$VerifyMissionResponseToJson(
  VerifyMissionResponse instance,
) => <String, dynamic>{
  'user_mission_id': instance.userMissionId,
  'status': instance.status,
  'verified_at': instance.verifiedAt,
  'verified_by': instance.verifiedBy,
};
