class TaskModel {
  final String taskId;
  final String missionId;
  final String title;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TaskModel({
    required this.taskId,
    required this.missionId,
    required this.title,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskModel &&
          runtimeType == other.runtimeType &&
          taskId == other.taskId &&
          missionId == other.missionId &&
          title == other.title &&
          description == other.description &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode => Object.hash(
        taskId,
        missionId,
        title,
        description,
        createdAt,
        updatedAt,
      );
}
