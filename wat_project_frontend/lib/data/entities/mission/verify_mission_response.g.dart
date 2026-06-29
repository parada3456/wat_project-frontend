// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_mission_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyMissionResponse _$VerifyMissionResponseFromJson(
  Map<String, dynamic> json,
) => VerifyMissionResponse(
  userMissionId: json['userMissionId'] as String,
  status: json['status'] as String,
  verifiedAt: json['verifiedAt'] as String?,
  verifiedBy: json['verifiedBy'] as String?,
);

Map<String, dynamic> _$VerifyMissionResponseToJson(
  VerifyMissionResponse instance,
) => <String, dynamic>{
  'userMissionId': instance.userMissionId,
  'status': instance.status,
  'verifiedAt': instance.verifiedAt,
  'verifiedBy': instance.verifiedBy,
};
