class UserModel {
  final String id;
  final String email;
  final String? firstName;
  final String? lastName;
  final String? currentPhaseId;
  final int totalLifetimePoints;
  final int currentPhasePoints;
  final int missionStreak;
  final DateTime? arrivalDate;
  final DateTime? jobStartDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserModel({
    required this.id,
    required this.email,
    this.firstName,
    this.lastName,
    this.currentPhaseId,
    this.totalLifetimePoints = 0,
    this.currentPhasePoints = 0,
    this.missionStreak = 0,
    this.arrivalDate,
    this.jobStartDate,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          currentPhaseId == other.currentPhaseId &&
          totalLifetimePoints == other.totalLifetimePoints &&
          currentPhasePoints == other.currentPhasePoints &&
          missionStreak == other.missionStreak &&
          arrivalDate == other.arrivalDate &&
          jobStartDate == other.jobStartDate &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode => Object.hash(
    id,
    email,
    firstName,
    lastName,
    currentPhaseId,
    totalLifetimePoints,
    currentPhasePoints,
    missionStreak,
    arrivalDate,
    jobStartDate,
    createdAt,
    updatedAt,
  );
}
