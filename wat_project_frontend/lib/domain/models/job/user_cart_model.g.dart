// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCartModel _$UserCartModelFromJson(Map<String, dynamic> json) =>
    UserCartModel(
      cartId: json['cartId'] as String,
      userId: json['userId'] as String,
      jobId: json['jobId'] as String,
      status:
          $enumDecodeNullable(_$CartStatusEnumMap, json['status']) ??
          CartStatus.saved,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$UserCartModelToJson(UserCartModel instance) =>
    <String, dynamic>{
      'cartId': instance.cartId,
      'userId': instance.userId,
      'jobId': instance.jobId,
      'status': _$CartStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$CartStatusEnumMap = {
  CartStatus.saved: 'Saved',
  CartStatus.viewed: 'Viewed',
  CartStatus.applied: 'Applied',
  CartStatus.removed: 'Removed',
};
