import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/data/entities/mission/mission_entity.dart';
import 'package:wat_project_frontend/data/entities/mission/task_entity.dart';
import 'package:wat_project_frontend/data/entities/mission/user_mission_entity.dart';
import 'package:wat_project_frontend/data/entities/mission/user_task_entity.dart';
import 'package:wat_project_frontend/domain/models/user_mission_model.dart';
import 'package:wat_project_frontend/domain/models/mission_model.dart';

part 'mission_detail_response.g.dart';

@JsonSerializable()
class MissionDetailResponse {
  final MissionEntity mission;
  @JsonKey(name: 'user_mission')
  final UserMissionEntity userMission;
  final List<String> tasks;
  @JsonKey(name: 'user_tasks')
  final List<String> userTasks;

  MissionDetailResponse({
    required this.mission,
    required this.userMission,
    required this.tasks,
    required this.userTasks,
  });

  factory MissionDetailResponse.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('mission') && json['mission'] is Map) {
      return MissionDetailResponse(
        mission: MissionEntity.fromJson(json['mission'] as Map<String, dynamic>),
        userMission: UserMissionEntity.fromJson(json['user_mission'] as Map<String, dynamic>),
        tasks: (json['tasks'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ?? [],
        userTasks: (json['user_tasks'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ?? [],
      );
    }

    final userMissionId = json['user_mission_id'] as String? ?? json['userMissionId'] as String? ?? '';
    final missionId = json['mission_id'] as String? ?? json['missionId'] as String? ?? '';
    
    final statusStr = json['status'] as String? ?? 'assigned';
    UserMissionStatus status = UserMissionStatus.notStarted;
    final normalizedStatus = statusStr.toLowerCase().replaceAll('_', '');
    if (normalizedStatus == 'completed') {
      status = UserMissionStatus.completed;
    } else if (normalizedStatus == 'inprogress') {
      status = UserMissionStatus.inProgress;
    } else if (normalizedStatus == 'pendingverification') {
      status = UserMissionStatus.pendingVerification;
    } else if (normalizedStatus == 'overdue') {
      status = UserMissionStatus.overdue;
    } else if (normalizedStatus == 'notstarted') {
      status = UserMissionStatus.notStarted;
    }

    final userMissionEntity = UserMissionEntity(
      userMissionId: userMissionId,
      userId: json['user_id'] as String? ?? '',
      missionId: missionId,
      status: status,
      basePointsEarned: json['base_points_earned'] as int? ?? 0,
      speedBonusPoints: json['speed_bonus_points'] as int? ?? 0,
      streakBonusPoints: json['streak_bonus_points'] as int? ?? 0,
      firstCompleterBonusPoints: json['first_completer_bonus_points'] as int? ?? 0,
      totalPointsEarned: json['total_points_earned'] as int? ?? 0,
      createdAt: json['created_at'] as String? ?? DateTime.now().toIso8601String(),
      updatedAt: json['updated_at'] as String? ?? DateTime.now().toIso8601String(),
    );

    final phaseId = json['phase_id'] as String? ?? '';
    final title = json['title'] as String? ?? json['mission_title'] as String? ?? 'Mission $missionId';
    final basePoints = json['base_points'] as int? ?? 0;
    
    final missionEntity = MissionEntity(
      missionId: missionId,
      phaseId: phaseId,
      title: title,
      basePoints: basePoints,
      isMandatory: json['is_mandatory'] as bool? ?? false,
      verificationType: VerificationType.upload,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );

    final taskIds = (json['tasks'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ?? [];
    final userTaskIds = (json['user_tasks'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ?? [];

    return MissionDetailResponse(
      mission: missionEntity,
      userMission: userMissionEntity,
      tasks: taskIds,
      userTasks: userTaskIds,
    );
  }
}
