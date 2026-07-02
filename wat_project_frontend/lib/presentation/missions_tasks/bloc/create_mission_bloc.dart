import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/mission/create_mission_request.dart';
import 'package:wat_project_frontend/domain/models/mission_model.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/domain/usecases/create_mission_usecase.dart';

part 'create_mission_event.dart';
part 'create_mission_state.dart';
part 'create_mission_bloc.freezed.dart';

class CreateMissionBloc extends Bloc<CreateMissionEvent, CreateMissionState> {
  final CreateMissionUseCase _createMissionUseCase;

  CreateMissionBloc(this._createMissionUseCase)
      : super(const CreateMissionState()) {
    on<CreateMissionSubmitted>(_onCreateMissionSubmitted);
  }

  Future<void> _onCreateMissionSubmitted(
    CreateMissionSubmitted event,
    Emitter<CreateMissionState> emit,
  ) async {
    emit(state.copyWith(status: const UIStatus.loading()));
    final result = await _createMissionUseCase(event.request);
    result.fold(
      (failure) => emit(state.copyWith(
        status: UIStatus.loadFailed(message: failure.message),
      )),
      (mission) => emit(state.copyWith(
        status: const UIStatus.loadSuccess(message: 'MISSION_CREATED'),
        createdMission: mission,
      )),
    );
  }
}
