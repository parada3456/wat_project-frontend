import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/data/entities/user_entity.dart';import 'package:wat_project_frontend/data/entities/profile_entity.dart';import 'package:wat_project_frontend/data/entities/credit_score_entity.dart';
part 'user_profile_response.g.dart';

@JsonSerializable()
class UserProfileResponse {
  final UserEntity user;
  final ProfileEntity profile;
  @JsonKey(name: 'credit_score')
  final CreditScoreEntity creditScore;

  UserProfileResponse({
    required this.user,
    required this.profile,
    required this.creditScore,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$UserProfileResponseFromJson(json);
}
