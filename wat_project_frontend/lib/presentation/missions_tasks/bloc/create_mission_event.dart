part of 'create_mission_bloc.dart';

@freezed
abstract class CreateMissionEvent with _$CreateMissionEvent {
  const factory CreateMissionEvent.submitted({
    required CreateMissionRequest request,
  }) = CreateMissionSubmitted;
}
