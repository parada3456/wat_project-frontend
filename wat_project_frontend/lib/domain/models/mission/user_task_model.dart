import 'package:equatable/equatable.dart';

class UserTaskModel extends Equatable {
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
  List<Object?> get props => [
    userTaskId,
    userId,
    taskId,
    userMissionId,
    isCompleted,
    completedAt,
    updatedAt,
  ];
}
