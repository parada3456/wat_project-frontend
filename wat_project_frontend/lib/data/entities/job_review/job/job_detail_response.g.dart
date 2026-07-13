// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobDetailResponse _$JobDetailResponseFromJson(Map<String, dynamic> json) =>
    JobDetailResponse(
      job: JobPostingEntity.fromJson(json['job'] as Map<String, dynamic>),
      housing: json['housing'] == null
          ? null
          : JobHousingEntity.fromJson(json['housing'] as Map<String, dynamic>),
      rating: json['rating'] == null
          ? null
          : JobOverallRatingEntity.fromJson(
              json['rating'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$JobDetailResponseToJson(JobDetailResponse instance) =>
    <String, dynamic>{
      'job': instance.job,
      'housing': instance.housing,
      'rating': instance.rating,
    };
