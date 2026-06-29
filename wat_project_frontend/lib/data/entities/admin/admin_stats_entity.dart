import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/domain/models/admin_stats_model.dart';

part 'admin_stats_entity.g.dart';

@JsonSerializable()
class AdminStatsEntity {
  final int totalUsers;
  final int activeUsers;
  final int pendingVerifications;
  final int activeJobs;
  final int averageCreditScore;
  final int totalPointsAwarded;

  AdminStatsEntity({
    required this.totalUsers,
    required this.activeUsers,
    required this.pendingVerifications,
    required this.activeJobs,
    required this.averageCreditScore,
    required this.totalPointsAwarded,
  });

  factory AdminStatsEntity.fromJson(Map<String, dynamic> json) => _$AdminStatsEntityFromJson(json);

  AdminStatsModel toModel() => AdminStatsModel(
        totalUsers: totalUsers,
        activeUsers: activeUsers,
        pendingVerifications: pendingVerifications,
        activeJobs: activeJobs,
        averageCreditScore: averageCreditScore,
        totalPointsAwarded: totalPointsAwarded,
      );
}
