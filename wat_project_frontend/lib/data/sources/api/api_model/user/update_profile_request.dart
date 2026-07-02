import 'package:json_annotation/json_annotation.dart';

part 'update_profile_request.g.dart';

@JsonSerializable()
class UpdateProfileRequest {
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  final String? bio;
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;

  UpdateProfileRequest({
    this.firstName,
    this.lastName,
    this.bio,
    this.avatarUrl,
  });

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateProfileRequestToJson(this);
}
