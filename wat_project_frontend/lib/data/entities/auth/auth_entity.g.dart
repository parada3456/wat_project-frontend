// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthEntity _$AuthEntityFromJson(Map<String, dynamic> json) => AuthEntity(
  token: json['AccessToken'] as String,
  refreshToken: json['RefreshToken'] as String,
  tokenType: json['token_type'] as String,
  expiresAt: DateTime.parse(json['ExpiresAt'] as String),
);

Map<String, dynamic> _$AuthEntityToJson(AuthEntity instance) =>
    <String, dynamic>{
      'AccessToken': instance.token,
      'RefreshToken': instance.refreshToken,
      'token_type': instance.tokenType,
      'ExpiresAt': instance.expiresAt.toIso8601String(),
    };
