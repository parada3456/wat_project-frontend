import 'package:equatable/equatable.dart';

class TaskModel extends Equatable {
  final String taskId;
  // final String missionId;
  final String title;
  final String? description;
  final bool? isCompleted;
  final DateTime? completedAt;
  // final DateTime createdAt;
  // final DateTime updatedAt;

  const TaskModel({
    required this.taskId,
    // required this.missionId,
    required this.title,
    this.description,
    this.isCompleted,
    this.completedAt,
    // required this.createdAt,
    // required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    taskId,
    title,
    description,
    isCompleted,
    completedAt,
  ];
}
