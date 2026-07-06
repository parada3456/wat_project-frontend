import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/data/entities/auth/auth_entity.dart';

part 'auth_model.g.dart';

@JsonSerializable()
class AuthModel extends AuthEntity{

  AuthModel({
    required super.token,
    required super.refreshToken,
    required super.expiresAt, 
    required super.tokenType,
  });

  bool get isExpired => DateTime.now().isAfter(expiresAt);

  bool get isNearExpiration =>
      DateTime.now().isAfter(expiresAt.subtract(const Duration(minutes: 2)));

  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      _$AuthModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthModelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthModel &&
          runtimeType == other.runtimeType &&
          token == other.token &&
          refreshToken == other.refreshToken &&
          expiresAt == other.expiresAt;

  @override
  int get hashCode => Object.hash(token, refreshToken, expiresAt);
}
