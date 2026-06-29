import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/domain/models/user_model.dart';
import 'package:wat_project_frontend/domain/models/profile_model.dart';

part 'user_account_entity.g.dart';

@JsonSerializable()
class UserAccountEntity {
  @JsonKey(name: 'user_id')
  final String userId;
  final String email;
  // @JsonKey(name: 'password_hash')
  // final String? passwordHash;
  @JsonKey(name: 'current_phase_id')
  final String? currentPhaseId;
  @JsonKey(name: 'total_lifetime_points')
  final int? totalLifetimePoints;
  @JsonKey(name: 'current_phase_points')
  final int? currentPhasePoints;
  @JsonKey(name: 'mission_streak')
  final int? missionStreak;
  @JsonKey(name: 'arrival_date')
  final DateTime? arrivalDate;
  @JsonKey(name: 'job_start_date')
  final DateTime? jobStartDate;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  // Profile fields merged
  @JsonKey(name: 'profile_id')
  final String? profileId;
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  final String? bio;
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @JsonKey(name: 'radar_visibility')
  final RadarVisibility? radarVisibility;
  @JsonKey(name: 'current_coordinates')
  final String? currentCoordinates;
  @JsonKey(name: 'location_updated_at')
  final DateTime? locationUpdatedAt;

  UserAccountEntity({
    required this.userId,
    required this.email,
    this.currentPhaseId,
    this.totalLifetimePoints,
    this.currentPhasePoints,
    this.missionStreak,
    this.arrivalDate,
    this.jobStartDate,
    required this.createdAt,
    required this.updatedAt,
    this.profileId,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.bio,
    this.avatarUrl,
    this.radarVisibility,
    this.currentCoordinates,
    this.locationUpdatedAt, 
    // this.passwordHash,
  });

  factory UserAccountEntity.fromJson(Map<String, dynamic> json) => _$UserAccountEntityFromJson(json);
  Map<String, dynamic> toJson() => _$UserAccountEntityToJson(this);

  UserModel toModel() => UserModel(
    id: userId,
    email: email,
    firstName: firstName,
    lastName: lastName,
    currentPhaseId: currentPhaseId,
    totalLifetimePoints: totalLifetimePoints ?? 0,
    currentPhasePoints: currentPhasePoints ?? 0,
    missionStreak: missionStreak ?? 0,
    arrivalDate: arrivalDate,
    jobStartDate: jobStartDate,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  ProfileModel toProfileModel() => ProfileModel(
    profileId: profileId ?? '',
    userId: userId,
    phoneNumber: phoneNumber,
    bio: bio,
    avatarUrl: avatarUrl,
    radarVisibility: radarVisibility ?? RadarVisibility.hidden,
    currentCoordinates: currentCoordinates,
    locationUpdatedAt: locationUpdatedAt,
    updatedAt: updatedAt,
  );
}
