import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/data/entities/auth_entity.dart';
part 'login_entity.g.dart';

@JsonSerializable()
class LoginEntity {
  final AuthEntity auth;
  @JsonKey(name: 'user_id')
  final String userId;

  LoginEntity({
    required this.auth,
    required this.userId,
  });

  factory LoginEntity.fromJson(Map<String, dynamic> json) {
    return LoginEntity(
      userId: json['user_id'] as String,
      auth: AuthEntity.fromJson(json),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'user_id': userId,
        'access_token': auth.token,
        'refresh_token': auth.refreshToken,
        'expires_at': auth.expiresAt,
      };
}
