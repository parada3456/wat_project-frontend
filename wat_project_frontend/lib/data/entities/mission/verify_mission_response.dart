import 'package:json_annotation/json_annotation.dart';

part 'verify_mission_response.g.dart';

@JsonSerializable()
class VerifyMissionResponse {
  @JsonKey(name: 'user_mission_id')
  final String userMissionId;
  final String status;
  @JsonKey(name: 'verified_at')
  final String? verifiedAt;
  @JsonKey(name: 'verified_by')
  final String? verifiedBy;

  VerifyMissionResponse({
    required this.userMissionId,
    required this.status,
    this.verifiedAt,
    this.verifiedBy,
  });

  factory VerifyMissionResponse.fromJson(Map<String, dynamic> json) => _$VerifyMissionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyMissionResponseToJson(this);
}
