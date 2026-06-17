// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_cart_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCartEntity _$UserCartEntityFromJson(Map<String, dynamic> json) =>
    UserCartEntity(
      cartId: json['cart_id'] as String,
      userId: json['user_id'] as String,
      jobId: json['job_id'] as String,
      status: $enumDecode(_$CartStatusEnumMap, json['status']),
      addedAt: json['added_at'] as String,
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$UserCartEntityToJson(UserCartEntity instance) =>
    <String, dynamic>{
      'cart_id': instance.cartId,
      'user_id': instance.userId,
      'job_id': instance.jobId,
      'status': _$CartStatusEnumMap[instance.status]!,
      'added_at': instance.addedAt,
      'updated_at': instance.updatedAt,
    };

const _$CartStatusEnumMap = {
  CartStatus.saved: 'Saved',
  CartStatus.viewed: 'Viewed',
  CartStatus.applied: 'Applied',
  CartStatus.removed: 'Removed',
};
