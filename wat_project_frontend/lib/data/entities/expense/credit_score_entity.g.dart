// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_score_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditScoreEntity _$CreditScoreEntityFromJson(Map<String, dynamic> json) =>
    CreditScoreEntity(
      creditId: json['credit_id'] as String,
      userId: json['user_id'] as String,
      currentScore: (json['current_score'] as num).toInt(),
      lastUpdated: json['last_updated'] as String?,
    );

Map<String, dynamic> _$CreditScoreEntityToJson(CreditScoreEntity instance) =>
    <String, dynamic>{
      'credit_id': instance.creditId,
      'user_id': instance.userId,
      'current_score': instance.currentScore,
      'last_updated': instance.lastUpdated,
    };
