import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/domain/models/auth_model.dart';

part 'auth_entity.g.dart';

@JsonSerializable()
class AuthEntity {
  @JsonKey(name: 'AccessToken')
  final String token;
  @JsonKey(name: 'RefreshToken')
  final String refreshToken;
  @JsonKey(name: 'TokenType')
  final String tokenType;
  @JsonKey(name: 'ExpiresAt')
  final DateTime expiresAt; 

  AuthEntity({
    required this.token,
    required this.refreshToken,
    required this.tokenType,
    required this.expiresAt,
  });

  factory AuthEntity.fromJson(Map<String, dynamic> json) => _$AuthEntityFromJson(json);
  Map<String, dynamic> toJson() => _$AuthEntityToJson(this);

  AuthModel toModel() => AuthModel(
    token: token,
    refreshToken: refreshToken,
    tokenType: tokenType,
    expiresAt: expiresAt,
  );
}
