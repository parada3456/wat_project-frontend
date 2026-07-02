import 'package:json_annotation/json_annotation.dart';

part 'adjust_points_request.g.dart';

@JsonSerializable()
class AdjustPointsRequest {
  @JsonKey(name: 'pointsDelta')
  final int pointsDelta;
  final String reason;

  AdjustPointsRequest({
    required this.pointsDelta,
    required this.reason,
  });

  factory AdjustPointsRequest.fromJson(Map<String, dynamic> json) => _$AdjustPointsRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AdjustPointsRequestToJson(this);
}
