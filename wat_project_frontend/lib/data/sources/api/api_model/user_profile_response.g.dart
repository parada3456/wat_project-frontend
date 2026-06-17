// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileResponse _$UserProfileResponseFromJson(Map<String, dynamic> json) =>
    UserProfileResponse(
      user: UserEntity.fromJson(json['user'] as Map<String, dynamic>),
      profile: ProfileEntity.fromJson(json['profile'] as Map<String, dynamic>),
      creditScore: CreditScoreEntity.fromJson(
        json['credit_score'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$UserProfileResponseToJson(
  UserProfileResponse instance,
) => <String, dynamic>{
  'user': instance.user,
  'profile': instance.profile,
  'credit_score': instance.creditScore,
};
