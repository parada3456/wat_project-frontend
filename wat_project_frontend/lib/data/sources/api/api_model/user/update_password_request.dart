import 'package:json_annotation/json_annotation.dart';

part 'update_password_request.g.dart';

@JsonSerializable()
class UpdatePasswordRequest {
  @JsonKey(name: 'current_password')
  final String currentPassword;
  @JsonKey(name: 'new_password')
  final String newPassword;

  UpdatePasswordRequest({
    required this.currentPassword,
    required this.newPassword,
  });

  factory UpdatePasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdatePasswordRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdatePasswordRequestToJson(this);
}
