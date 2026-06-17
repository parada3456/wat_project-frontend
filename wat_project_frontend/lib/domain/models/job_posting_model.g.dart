// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_posting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobPostingModel _$JobPostingModelFromJson(Map<String, dynamic> json) =>
    JobPostingModel(
      jobId: json['jobId'] as String,
      agencyName: json['agencyName'] as String?,
      employerTitle: json['employerTitle'] as String?,
      position: json['position'] as String?,
      positionType: json['positionType'] as String?,
      locationCity: json['locationCity'] as String?,
      locationState: json['locationState'] as String?,
      groupLocation: json['groupLocation'] as String?,
      usSponsor: json['usSponsor'] as bool? ?? false,
      salaryRangeMin: (json['salaryRangeMin'] as num?)?.toDouble() ?? 0.0,
      salaryRangeMax: (json['salaryRangeMax'] as num?)?.toDouble() ?? 0.0,
      availableSlots: (json['availableSlots'] as num?)?.toInt() ?? 0,
      description: json['description'] as String?,
      sourceUrl: json['sourceUrl'] as String?,
      scrapeAt: json['scrapeAt'] == null
          ? null
          : DateTime.parse(json['scrapeAt'] as String),
      postedAt: json['postedAt'] == null
          ? null
          : DateTime.parse(json['postedAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$JobPostingModelToJson(JobPostingModel instance) =>
    <String, dynamic>{
      'jobId': instance.jobId,
      'agencyName': instance.agencyName,
      'employerTitle': instance.employerTitle,
      'position': instance.position,
      'positionType': instance.positionType,
      'locationCity': instance.locationCity,
      'locationState': instance.locationState,
      'groupLocation': instance.groupLocation,
      'usSponsor': instance.usSponsor,
      'salaryRangeMin': instance.salaryRangeMin,
      'salaryRangeMax': instance.salaryRangeMax,
      'availableSlots': instance.availableSlots,
      'description': instance.description,
      'sourceUrl': instance.sourceUrl,
      'scrapeAt': instance.scrapeAt?.toIso8601String(),
      'postedAt': instance.postedAt?.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
