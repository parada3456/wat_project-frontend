// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersListResponse _$UsersListResponseFromJson(Map<String, dynamic> json) =>
    UsersListResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => UserEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UsersListResponseToJson(UsersListResponse instance) =>
    <String, dynamic>{'data': instance.data};
