import 'dart:io';

abstract class MissionTaskEvent {
  const MissionTaskEvent();
}

class MissionsTasksListRequested extends MissionTaskEvent {
  const MissionsTasksListRequested();
}

class MissionTaskDetailRequested extends MissionTaskEvent {
  final String missionId;
  const MissionTaskDetailRequested(this.missionId);
}

class MissionTaskProofSubmitted extends MissionTaskEvent {
  final String missionId;
  final File file;
  const MissionTaskProofSubmitted(this.missionId, this.file);
}

class MissionTaskToggleRequested extends MissionTaskEvent {
  final String userMissionId;
  final String taskId;
  final bool completed;

  const MissionTaskToggleRequested({
    required this.userMissionId,
    required this.taskId,
    required this.completed,
  });
}
