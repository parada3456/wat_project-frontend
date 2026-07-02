// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthModel _$AuthModelFromJson(Map<String, dynamic> json) => AuthModel(
  token: json['AccessToken'] as String,
  refreshToken: json['RefreshToken'] as String,
  expiresAt: DateTime.parse(json['ExpiresAt'] as String),
  tokenType: json['token_type'] as String,
);

Map<String, dynamic> _$AuthModelToJson(AuthModel instance) => <String, dynamic>{
  'AccessToken': instance.token,
  'RefreshToken': instance.refreshToken,
  'token_type': instance.tokenType,
  'ExpiresAt': instance.expiresAt.toIso8601String(),
};
