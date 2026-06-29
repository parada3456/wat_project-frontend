import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wat_project_frontend/domain/usecases/list_available_missions_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/get_mission_detail_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/submit_mission_proof_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/toggle_task_usecase.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/bloc/mission_task_event.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/bloc/mission_task_state.dart';

class MissionTaskBloc extends Bloc<MissionTaskEvent, MissionTaskState> {
  final ListAvailableMissionsUseCase _listAvailableMissionsUseCase;
  final GetMissionDetailUseCase _getMissionDetailUseCase;
  final SubmitMissionProofUseCase _submitMissionProofUseCase;
  final ToggleTaskUseCase _toggleTaskUseCase;

  MissionTaskBloc(
    this._listAvailableMissionsUseCase,
    this._getMissionDetailUseCase,
    this._submitMissionProofUseCase,
    this._toggleTaskUseCase,
  ) : super(const MissionTaskInitial()) {
    on<MissionsTasksListRequested>(_onMissionsTasksListRequested);
    on<MissionTaskDetailRequested>(_onMissionTaskDetailRequested);
    on<MissionTaskProofSubmitted>(_onMissionTaskProofSubmitted);
    on<MissionTaskToggleRequested>(_onMissionTaskToggleRequested);
  }

  Future<void> _onMissionsTasksListRequested(
    MissionsTasksListRequested event,
    Emitter<MissionTaskState> emit,
  ) async {
    emit(const MissionTaskLoading());
    final result = await _listAvailableMissionsUseCase();
    result.fold(
      (failure) => emit(MissionTaskFailure(failure.message)),
      (missions) => emit(MissionTaskListSuccess(missions)),
    );
  }

  Future<void> _onMissionTaskDetailRequested(
    MissionTaskDetailRequested event,
    Emitter<MissionTaskState> emit,
  ) async {
    emit(const MissionTaskLoading());
    final result = await _getMissionDetailUseCase(event.missionId);
    result.fold(
      (failure) => emit(MissionTaskFailure(failure.message)),
      (detail) => emit(MissionTaskDetailSuccess(detail)),
    );
  }

  Future<void> _onMissionTaskProofSubmitted(
    MissionTaskProofSubmitted event,
    Emitter<MissionTaskState> emit,
  ) async {
    emit(const MissionTaskLoading());
    final result = await _submitMissionProofUseCase(event.missionId, event.file);
    result.fold(
      (failure) => emit(MissionTaskFailure(failure.message)),
      (_) => emit(const MissionTaskProofSubmitSuccess()),
    );
  }

  Future<void> _onMissionTaskToggleRequested(
    MissionTaskToggleRequested event,
    Emitter<MissionTaskState> emit,
  ) async {
    emit(const MissionTaskLoading());
    final result = await _toggleTaskUseCase(
      event.userMissionId,
      event.taskId,
      event.completed,
    );
    result.fold(
      (failure) => emit(MissionTaskFailure(failure.message)),
      (_) => emit(MissionTaskToggleSuccess(
        userMissionId: event.userMissionId,
        taskId: event.taskId,
        completed: event.completed,
      )),
    );
  }
}
