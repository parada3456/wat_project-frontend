part of 'create_mission_bloc.dart';

@freezed
abstract class CreateMissionState with _$CreateMissionState {
  const factory CreateMissionState({
    @Default(UIStatus.initial()) UIStatus status,
    MissionModel? createdMission,
  }) = _CreateMissionState;
}
