// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adjust_points_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdjustPointsRequest _$AdjustPointsRequestFromJson(Map<String, dynamic> json) =>
    AdjustPointsRequest(
      pointsDelta: (json['pointsDelta'] as num).toInt(),
      reason: json['reason'] as String,
    );

Map<String, dynamic> _$AdjustPointsRequestToJson(
  AdjustPointsRequest instance,
) => <String, dynamic>{
  'pointsDelta': instance.pointsDelta,
  'reason': instance.reason,
};
