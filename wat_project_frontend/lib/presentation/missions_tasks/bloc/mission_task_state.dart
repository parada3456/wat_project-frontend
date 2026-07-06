part of 'mission_task_bloc.dart';

@freezed
abstract class MissionTaskState with _$MissionTaskState {
  const factory MissionTaskState({
    @Default(UIStatus.initial()) UIStatus status,
    @Default([]) List<MissionDetailModel> missions,
    MissionDetailModel? detail,
    @Default([]) List<MissionModel> exploreMissions,
    @Default([]) List<MissionModel> allMissions,
    String? currentPhaseId,
    bool? isFilterMandatory,
  }) = _MissionTaskState;
}
