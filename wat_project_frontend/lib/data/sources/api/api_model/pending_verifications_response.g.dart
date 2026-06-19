// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_verifications_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PendingVerificationsResponse _$PendingVerificationsResponseFromJson(
  Map<String, dynamic> json,
) => PendingVerificationsResponse(
  data: (json['data'] as List<dynamic>)
      .map((e) => UserMissionEntity.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PendingVerificationsResponseToJson(
  PendingVerificationsResponse instance,
) => <String, dynamic>{'data': instance.data};
