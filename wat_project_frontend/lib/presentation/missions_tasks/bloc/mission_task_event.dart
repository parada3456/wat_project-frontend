part of 'mission_task_bloc.dart';

@freezed
class MissionTaskEvent with _$MissionTaskEvent {
  const factory MissionTaskEvent.listRequested() = MissionsTasksListRequested;

  const factory MissionTaskEvent.detailRequested(String missionId) =
      MissionTaskDetailRequested;

  const factory MissionTaskEvent.proofSubmitted({
    required String missionId,
    File? file,
  }) = MissionTaskProofSubmitted;

  const factory MissionTaskEvent.toggleRequested({
    required String userMissionId,
    required String taskId,
    required bool completed,
  }) = MissionTaskToggleRequested;

  const factory MissionTaskEvent.exploreMissionsRequested() =
      ExploreMissionsRequested;

  const factory MissionTaskEvent.joinMissionRequested(String missionId) =
      JoinMissionRequested;

  const factory MissionTaskEvent.filterMissionsRequested(bool? showMandatory) =
      FilterMissionsRequested;

  const factory MissionTaskEvent.createMissionSubmitted({
    required CreateMissionRequest request,
  }) = CreateMissionSubmitted;
}
