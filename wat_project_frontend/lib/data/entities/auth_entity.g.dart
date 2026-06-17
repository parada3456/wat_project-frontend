// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthEntity _$AuthEntityFromJson(Map<String, dynamic> json) => AuthEntity(
  token: json['token'] as String,
  refreshToken: json['refreshToken'] as String,
  expiresAt: json['expiresAt'] as String,
);

Map<String, dynamic> _$AuthEntityToJson(AuthEntity instance) =>
    <String, dynamic>{
      'token': instance.token,
      'refreshToken': instance.refreshToken,
      'expiresAt': instance.expiresAt,
    };
