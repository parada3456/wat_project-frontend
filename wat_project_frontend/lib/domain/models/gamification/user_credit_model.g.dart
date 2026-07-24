// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_credit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserCreditModel _$UserCreditModelFromJson(Map<String, dynamic> json) =>
    _UserCreditModel(
      rank: (json['rank'] as num).toInt(),
      userId: json['userId'] as String,
      name: json['name'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      creditScore: (json['creditScore'] as num).toInt(),
    );

Map<String, dynamic> _$UserCreditModelToJson(_UserCreditModel instance) =>
    <String, dynamic>{
      'rank': instance.rank,
      'userId': instance.userId,
      'name': instance.name,
      'avatarUrl': instance.avatarUrl,
      'creditScore': instance.creditScore,
    };
