// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friendship_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendshipEntity _$FriendshipEntityFromJson(Map<String, dynamic> json) =>
    FriendshipEntity(
      friendshipId: json['friendship_id'] as String,
      userId1: json['user_id_1'] as String,
      userId2: json['user_id_2'] as String,
      status: $enumDecode(_$FriendshipStatusEnumMap, json['status']),
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$FriendshipEntityToJson(FriendshipEntity instance) =>
    <String, dynamic>{
      'friendship_id': instance.friendshipId,
      'user_id_1': instance.userId1,
      'user_id_2': instance.userId2,
      'status': _$FriendshipStatusEnumMap[instance.status]!,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

const _$FriendshipStatusEnumMap = {
  FriendshipStatus.pending: 'pending',
  FriendshipStatus.accepted: 'accepted',
  FriendshipStatus.rejected: 'rejected',
};
