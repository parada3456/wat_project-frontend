import 'package:json_annotation/json_annotation.dart';

part 'join_mission_request.g.dart';

@JsonSerializable()
class JoinMissionRequest {
  @JsonKey(name: 'mission_id')
  final String missionId;

  JoinMissionRequest({required this.missionId});

  factory JoinMissionRequest.fromJson(Map<String, dynamic> json) =>
      _$JoinMissionRequestFromJson(json);
  Map<String, dynamic> toJson() => _$JoinMissionRequestToJson(this);
}
