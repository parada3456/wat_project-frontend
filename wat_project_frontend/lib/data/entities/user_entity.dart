import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/domain/models/user_model.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity {
  @JsonKey(name: 'user_id')
  final String id;
  final String email;
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  @JsonKey(name: 'current_phase_id')
  final String? currentPhaseId;
  @JsonKey(name: 'total_lifetime_points')
  final int totalLifetimePoints;
  @JsonKey(name: 'current_phase_points')
  final int currentPhasePoints;
  @JsonKey(name: 'mission_streak')
  final int missionStreak;
  @JsonKey(name: 'arrival_date')
  final String? arrivalDate;
  @JsonKey(name: 'job_start_date')
  final String? jobStartDate;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  UserEntity({
    required this.id,
    required this.email,
    this.firstName,
    this.lastName,
    this.currentPhaseId,
    required this.totalLifetimePoints,
    required this.currentPhasePoints,
    required this.missionStreak,
    this.arrivalDate,
    this.jobStartDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) => _$UserEntityFromJson(json);

  UserModel toModel() => UserModel(
        id: id,
        email: email,
        firstName: firstName,
        lastName: lastName,
        currentPhaseId: currentPhaseId,
        totalLifetimePoints: totalLifetimePoints,
        currentPhasePoints: currentPhasePoints,
        missionStreak: missionStreak,
        arrivalDate: arrivalDate != null ? DateTime.parse(arrivalDate!) : null,
        jobStartDate: jobStartDate != null ? DateTime.parse(jobStartDate!) : null,
        createdAt: DateTime.parse(createdAt),
        updatedAt: DateTime.parse(updatedAt),
      );
}
