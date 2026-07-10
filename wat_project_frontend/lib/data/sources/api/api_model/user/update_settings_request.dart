import 'package:json_annotation/json_annotation.dart';

part 'update_settings_request.g.dart';

@JsonSerializable()
class UpdateSettingsRequest {
  @JsonKey(name: 'radar_visibility')
  final String? radarVisibility;
  @JsonKey(name: 'push_notifications')
  final bool? pushNotifications;

  UpdateSettingsRequest({this.radarVisibility, this.pushNotifications});

  factory UpdateSettingsRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateSettingsRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateSettingsRequestToJson(this);
}
