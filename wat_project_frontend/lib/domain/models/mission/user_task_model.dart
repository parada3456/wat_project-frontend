class UserTaskModel {
  final String userTaskId;
  final String userId;
  final String taskId;
  final String userMissionId;
  final bool isCompleted;
  final DateTime? completedAt;
  final DateTime updatedAt;

  const UserTaskModel({
    required this.userTaskId,
    required this.userId,
    required this.taskId,
    required this.userMissionId,
    this.isCompleted = false,
    this.completedAt,
    required this.updatedAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserTaskModel &&
          runtimeType == other.runtimeType &&
          userTaskId == other.userTaskId &&
          userId == other.userId &&
          taskId == other.taskId &&
          userMissionId == other.userMissionId &&
          isCompleted == other.isCompleted &&
          completedAt == other.completedAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode => Object.hash(
        userTaskId,
        userId,
        taskId,
        userMissionId,
        isCompleted,
        completedAt,
        updatedAt,
      );
}
