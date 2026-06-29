import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/domain/models/auth_model.dart';

part 'auth_entity.g.dart';

@JsonSerializable()
class AuthEntity {
  @JsonKey(name: 'access_token')
  final String token;
  @JsonKey(name: 'refresh_token')
  final String refreshToken;
  @JsonKey(name: 'expires_at')
  final String expiresAt; 

  AuthEntity({
    required this.token,
    required this.refreshToken,
    required this.expiresAt,
  });

  factory AuthEntity.fromJson(Map<String, dynamic> json) => _$AuthEntityFromJson(json);

  AuthModel toModel() => AuthModel(
        token: token,
        refreshToken: refreshToken,
        expiresAt: DateTime.parse(expiresAt),
      );
}
