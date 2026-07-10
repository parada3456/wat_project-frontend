import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

enum UserMissionStatus {
  @JsonValue('not_started')
  notStarted,
  @JsonValue('in_progress')
  inProgress,
  @JsonValue('pending_verification')
  pendingVerification,
  @JsonValue('completed')
  completed,
  @JsonValue('overdue')
  overdue,
}

class UserMissionModel extends Equatable {
  final String userMissionId;
  final String userId;
  final String missionId;
  final UserMissionStatus status;
  final DateTime? calculatedDueDate;
  final String? proofUrl;
  final DateTime? proofSubmittedAt;
  final DateTime? verifiedAt;
  final String? verifiedBy;
  final int basePointsEarned;
  final int speedBonusPoints;
  final int streakBonusPoints;
  final int firstCompleterBonusPoints;
  final int totalPointsEarned;
  final DateTime? rewardedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserMissionModel({
    required this.userMissionId,
    required this.userId,
    required this.missionId,
    this.status = UserMissionStatus.notStarted,
    this.calculatedDueDate,
    this.proofUrl,
    this.proofSubmittedAt,
    this.verifiedAt,
    this.verifiedBy,
    this.basePointsEarned = 0,
    this.speedBonusPoints = 0,
    this.streakBonusPoints = 0,
    this.firstCompleterBonusPoints = 0,
    this.totalPointsEarned = 0,
    this.rewardedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    userMissionId,
    userId,
    missionId,
    status,
    calculatedDueDate,
    proofUrl,
    proofSubmittedAt,
    verifiedAt,
    verifiedBy,
    basePointsEarned,
    speedBonusPoints,
    streakBonusPoints,
    firstCompleterBonusPoints,
    totalPointsEarned,
    rewardedAt,
    createdAt,
    updatedAt,
  ];
}
