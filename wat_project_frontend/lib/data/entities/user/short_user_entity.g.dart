// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'short_user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShortUserEntity _$ShortUserEntityFromJson(Map<String, dynamic> json) =>
    ShortUserEntity(
      userId: json['user_id'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatar_url'] as String,
    );

Map<String, dynamic> _$ShortUserEntityToJson(ShortUserEntity instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'name': instance.name,
      'avatar_url': instance.avatarUrl,
    };
