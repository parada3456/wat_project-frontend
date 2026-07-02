part of 'mission_task_bloc.dart';

@freezed
class MissionTaskEvent with _$MissionTaskEvent {
  const factory MissionTaskEvent.listRequested() = MissionsTasksListRequested;
  
  const factory MissionTaskEvent.detailRequested(String missionId) = MissionTaskDetailRequested;

  const factory MissionTaskEvent.proofSubmitted({
    required String missionId,
    required File file,
  }) = MissionTaskProofSubmitted;

  const factory MissionTaskEvent.toggleRequested({
    required String userMissionId,
    required String taskId,
    required bool completed,
  }) = MissionTaskToggleRequested;
}
