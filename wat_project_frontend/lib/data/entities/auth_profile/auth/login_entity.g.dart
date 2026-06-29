// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginEntity _$LoginEntityFromJson(Map<String, dynamic> json) => LoginEntity(
  auth: AuthEntity.fromJson(json['auth'] as Map<String, dynamic>),
  userId: json['user_id'] as String,
);

Map<String, dynamic> _$LoginEntityToJson(LoginEntity instance) =>
    <String, dynamic>{'auth': instance.auth, 'user_id': instance.userId};
