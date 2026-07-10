import 'package:json_annotation/json_annotation.dart';

part 'verify_mission_request.g.dart';

@JsonSerializable()
class VerifyMissionRequest {
  final bool approved;
  @JsonKey(name: 'rejectionReason')
  final String? rejectionReason;

  VerifyMissionRequest({required this.approved, this.rejectionReason});

  factory VerifyMissionRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyMissionRequestFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyMissionRequestToJson(this);
}
