import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/data/entities/user_entity.dart';
import 'package:wat_project_frontend/data/entities/profile_entity.dart';
import 'package:wat_project_frontend/data/entities/credit_score_entity.dart';
import 'package:wat_project_frontend/domain/models/profile_model.dart';

part 'user_profile_response.g.dart';

@JsonSerializable()
class UserProfileResponse {
  final UserEntity user;
  final ProfileEntity profile;
  @JsonKey(name: 'credit_score')
  final CreditScoreEntity creditScore;

  UserProfileResponse({
    required this.user,
    required this.profile,
    required this.creditScore,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('user') && json['user'] is Map) {
      return UserProfileResponse(
        user: UserEntity.fromJson(json['user'] as Map<String, dynamic>),
        profile: ProfileEntity.fromJson(json['profile'] as Map<String, dynamic>),
        creditScore: CreditScoreEntity.fromJson(json['credit_score'] as Map<String, dynamic>),
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
    );
  }
}
