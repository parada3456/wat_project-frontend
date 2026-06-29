// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_stats_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminStatsEntity _$AdminStatsEntityFromJson(Map<String, dynamic> json) =>
    AdminStatsEntity(
      totalUsers: (json['totalUsers'] as num).toInt(),
      activeUsers: (json['activeUsers'] as num).toInt(),
      pendingVerifications: (json['pendingVerifications'] as num).toInt(),
      activeJobs: (json['activeJobs'] as num).toInt(),
      averageCreditScore: (json['averageCreditScore'] as num).toInt(),
      totalPointsAwarded: (json['totalPointsAwarded'] as num).toInt(),
    );

Map<String, dynamic> _$AdminStatsEntityToJson(AdminStatsEntity instance) =>
    <String, dynamic>{
      'totalUsers': instance.totalUsers,
      'activeUsers': instance.activeUsers,
      'pendingVerifications': instance.pendingVerifications,
      'activeJobs': instance.activeJobs,
      'averageCreditScore': instance.averageCreditScore,
      'totalPointsAwarded': instance.totalPointsAwarded,
    };
