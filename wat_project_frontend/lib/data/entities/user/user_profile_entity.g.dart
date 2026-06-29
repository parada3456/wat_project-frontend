// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileEntity _$UserProfileEntityFromJson(Map<String, dynamic> json) =>
    UserProfileEntity(
      userAccount: UserAccountEntity.fromJson(
        json['user'] as Map<String, dynamic>,
      ),
      creditScore: CreditScoreEntity.fromJson(
        json['credit_score'] as Map<String, dynamic>,
      ),
      userJobs: (json['user_jobs'] as List<dynamic>)
          .map((e) => AssignedJobEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserProfileEntityToJson(UserProfileEntity instance) =>
    <String, dynamic>{
      'user': instance.userAccount,
      'credit_score': instance.creditScore,
      'user_jobs': instance.userJobs,
    };
