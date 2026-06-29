// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_posting_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobPostingEntity _$JobPostingEntityFromJson(Map<String, dynamic> json) =>
    JobPostingEntity(
      jobId: json['job_id'] as String,
      agencyName: json['agency_name'] as String?,
      employerTitle: json['employer_title'] as String?,
      position: json['position'] as String?,
      positionType: json['position_type'] as String?,
      locationCity: json['location_city'] as String?,
      locationState: json['location_state'] as String?,
      groupLocation: json['group_location'] as String?,
      usSponsor: json['us_sponsor'] as bool,
      salaryRangeMin: (json['salary_range_min'] as num).toDouble(),
      salaryRangeMax: (json['salary_range_max'] as num).toDouble(),
      availableSlots: (json['available_slots'] as num).toInt(),
      description: json['description'] as String?,
      sourceUrl: json['source_url'] as String?,
      scrapeAt: json['scrape_at'] as String?,
      postedAt: json['posted_at'] as String?,
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$JobPostingEntityToJson(JobPostingEntity instance) =>
    <String, dynamic>{
      'job_id': instance.jobId,
      'agency_name': instance.agencyName,
      'employer_title': instance.employerTitle,
      'position': instance.position,
      'position_type': instance.positionType,
      'location_city': instance.locationCity,
      'location_state': instance.locationState,
      'group_location': instance.groupLocation,
      'us_sponsor': instance.usSponsor,
      'salary_range_min': instance.salaryRangeMin,
      'salary_range_max': instance.salaryRangeMax,
      'available_slots': instance.availableSlots,
      'description': instance.description,
      'source_url': instance.sourceUrl,
      'scrape_at': instance.scrapeAt,
      'posted_at': instance.postedAt,
      'updated_at': instance.updatedAt,
    };
