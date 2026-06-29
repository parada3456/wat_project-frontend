import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/data/entities/mission/user_mission_entity.dart';

part 'pending_verifications_response.g.dart';

@JsonSerializable()
class PendingVerificationsResponse {
  final List<UserMissionEntity> data;

  PendingVerificationsResponse({required this.data});

  factory PendingVerificationsResponse.fromJson(Map<String, dynamic> json) => _$PendingVerificationsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PendingVerificationsResponseToJson(this);
}
