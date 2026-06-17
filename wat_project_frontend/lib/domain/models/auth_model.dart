import 'package:json_annotation/json_annotation.dart';

part 'auth_model.g.dart';

@JsonSerializable()
class AuthModel {
  final String token;
  final String refreshToken;
  final DateTime expiresAt;

  const AuthModel({
    required this.token,
    required this.refreshToken,
    required this.expiresAt,
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
