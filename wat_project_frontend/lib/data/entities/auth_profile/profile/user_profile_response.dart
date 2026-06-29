import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/data/entities/auth_profile/profile/profile_entity.dart';
import 'package:wat_project_frontend/data/entities/auth_profile/profile/user_entity.dart';
import 'package:wat_project_frontend/data/entities/expense/credit_score_entity.dart';
import 'package:wat_project_frontend/data/entities/job_review/job/user_job_entity.dart';
import 'package:wat_project_frontend/domain/models/profile_model.dart';

part 'user_profile_response.g.dart';

@JsonSerializable()
class UserProfileResponse {
  final UserEntity user;
  final ProfileEntity profile;
  @JsonKey(name: 'credit_score')
  final CreditScoreEntity creditScore;
  @JsonKey(name: 'user_jobs')
  final List<String>? userJobs;

  UserProfileResponse({
    required this.user,
    required this.profile,
    required this.creditScore,
    this.userJobs,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
    List<String>? parsedJobs;
    if (json.containsKey('user_jobs') && json['user_jobs'] is List) {
      parsedJobs = (json['user_jobs'] as List)
          .map((e) => e.toString())
          .toList();
    }

    if (json.containsKey('user') && json['user'] is Map) {
      final creditScoreJson = json['credit_score'];
      CreditScoreEntity parsedCredit;
      if (creditScoreJson is Map<String, dynamic>) {
        parsedCredit = CreditScoreEntity.fromJson(creditScoreJson);
      } else {
        final score = creditScoreJson is num ? creditScoreJson.toInt() : 100;
        final userMap = json['user'] as Map<String, dynamic>;
        final userId = userMap['user_id'] as String? ?? '';
        parsedCredit = CreditScoreEntity(
          creditId: 'cred_$userId',
          userId: userId,
          currentScore: score,
          lastUpdated: DateTime.now().toIso8601String(),
        );
      }

      return UserProfileResponse(
        user: UserEntity.fromJson(json['user'] as Map<String, dynamic>),
        profile: ProfileEntity.fromJson(json['profile'] as Map<String, dynamic>),
        creditScore: parsedCredit,
        userJobs: parsedJobs,
      );
    }

    final userId = json['user_id'] as String? ?? '';
    
    final userEntity = UserEntity(
      id: userId,
      email: json['email'] as String? ?? '',
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      currentPhaseId: json['current_phase_id'] as String?,
      totalLifetimePoints: json['total_lifetime_points'] as int? ?? json['points'] as int? ?? 0,
      currentPhasePoints: json['current_phase_points'] as int? ?? 0,
      missionStreak: json['mission_streak'] as int? ?? 0,
      arrivalDate: json['arrival_date'] as String?,
      jobStartDate: json['job_start_date'] as String?,
      createdAt: json['created_at'] as String? ?? DateTime.now().toIso8601String(),
      updatedAt: json['updated_at'] as String? ?? DateTime.now().toIso8601String(),
    );

    final radarVal = json['radar_visibility'];
    RadarVisibility visibility = RadarVisibility.hidden;
    if (radarVal is String) {
      final lowerVal = radarVal.toLowerCase();
      if (lowerVal == 'visible') {
        visibility = RadarVisibility.showFriends;
      } else {
        visibility = RadarVisibility.values.firstWhere(
          (e) => e.name.toLowerCase() == lowerVal,
          orElse: () => RadarVisibility.hidden,
        );
      }
    } else if (radarVal is int && radarVal >= 0 && radarVal < RadarVisibility.values.length) {
      visibility = RadarVisibility.values[radarVal];
    }
    
    final profileEntity = ProfileEntity(
      profileId: json['profile_id'] as String? ?? 'prof_$userId',
      userId: userId,
      phoneNumber: json['phone_number'] as String?,
      bio: json['bio'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      radarVisibility: visibility,
      currentCoordinates: json['current_coordinates'] as String?,
      locationUpdatedAt: json['location_updated_at'] as String?,
      updatedAt: json['updated_at'] as String? ?? DateTime.now().toIso8601String(),
    );

    final creditScoreEntity = CreditScoreEntity(
      creditId: json['credit_id'] as String? ?? 'cred_$userId',
      userId: userId,
      currentScore: json['credit_score'] as int? ?? json['current_score'] as int? ?? 0,
      lastUpdated: json['last_updated'] as String? ?? json['updated_at'] as String? ?? DateTime.now().toIso8601String(),
    );

    return UserProfileResponse(
      user: userEntity,
      profile: profileEntity,
      creditScore: creditScoreEntity,
      userJobs: parsedJobs,
    );
  }
}
