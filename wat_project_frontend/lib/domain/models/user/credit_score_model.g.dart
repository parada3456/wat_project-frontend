// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_score_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditScoreModel _$CreditScoreModelFromJson(Map<String, dynamic> json) =>
    CreditScoreModel(
      creditId: json['creditId'] as String,
      userId: json['userId'] as String,
      currentScore: (json['currentScore'] as num?)?.toInt() ?? 100,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$CreditScoreModelToJson(CreditScoreModel instance) =>
    <String, dynamic>{
      'creditId': instance.creditId,
      'userId': instance.userId,
      'currentScore': instance.currentScore,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
    };
