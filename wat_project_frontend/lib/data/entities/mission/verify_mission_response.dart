import 'package:json_annotation/json_annotation.dart';

part 'verify_mission_response.g.dart';

@JsonSerializable()
class VerifyMissionResponse {
  @JsonKey(name: 'userMissionId')
  final String userMissionId;
  final String status;
  @JsonKey(name: 'verifiedAt')
  final String? verifiedAt;
  @JsonKey(name: 'verifiedBy')
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
