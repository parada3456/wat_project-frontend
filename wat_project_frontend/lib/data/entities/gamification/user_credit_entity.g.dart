// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_credit_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCreditEntity _$UserCreditEntityFromJson(Map<String, dynamic> json) =>
    UserCreditEntity(
      rank: (json['rank'] as num).toInt(),
      user: ShortUserEntity.fromJson(json['user'] as Map<String, dynamic>),
      creditScore: (json['credit_score'] as num).toInt(),
    );

Map<String, dynamic> _$UserCreditEntityToJson(UserCreditEntity instance) =>
    <String, dynamic>{
      'rank': instance.rank,
      'user': instance.user,
      'credit_score': instance.creditScore,
    };
