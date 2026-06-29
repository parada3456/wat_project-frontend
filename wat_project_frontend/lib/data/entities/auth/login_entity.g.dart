// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginEntity _$LoginEntityFromJson(Map<String, dynamic> json) => LoginEntity(
  auth: AuthEntity.fromJson(json['auth'] as Map<String, dynamic>),
  user: UserAccountEntity.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LoginEntityToJson(LoginEntity instance) =>
    <String, dynamic>{'auth': instance.auth, 'user': instance.user};
