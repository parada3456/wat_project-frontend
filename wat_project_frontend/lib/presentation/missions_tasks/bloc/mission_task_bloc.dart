import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wat_project_frontend/domain/models/mission_detail_model.dart';
import 'package:wat_project_frontend/domain/models/user_task_model.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/domain/usecases/list_available_missions_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/get_mission_detail_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/submit_mission_proof_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/toggle_task_usecase.dart';

part 'mission_task_event.dart';
part 'mission_task_state.dart';
part 'mission_task_bloc.freezed.dart';

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
  ) : super(const MissionTaskState()) {
    on<MissionsTasksListRequested>(_onMissionsTasksListRequested);
    on<MissionTaskDetailRequested>(_onMissionTaskDetailRequested);
    on<MissionTaskProofSubmitted>(_onMissionTaskProofSubmitted);
    on<MissionTaskToggleRequested>(_onMissionTaskToggleRequested);
  }

  Future<void> _onMissionsTasksListRequested(
    MissionsTasksListRequested event,
    Emitter<MissionTaskState> emit,
  ) async {
    emit(state.copyWith(status: const UIStatus.loading()));
    final result = await _listAvailableMissionsUseCase();
    result.fold(
      (failure) => emit(state.copyWith(
        status: UIStatus.loadFailed(message: failure.message),
      )),
      (missions) => emit(state.copyWith(
        status: const UIStatus.loadSuccess(),
        missions: missions,
      )),
    );
  }

  Future<void> _onMissionTaskDetailRequested(
    MissionTaskDetailRequested event,
    Emitter<MissionTaskState> emit,
  ) async {
    emit(state.copyWith(status: const UIStatus.loading()));
    final result = await _getMissionDetailUseCase(event.missionId);
    result.fold(
      (failure) => emit(state.copyWith(
        status: UIStatus.loadFailed(message: failure.message),
      )),
      (detail) => emit(state.copyWith(
        status: const UIStatus.loadSuccess(),
        detail: detail,
      )),
    );
  }

  Future<void> _onMissionTaskProofSubmitted(
    MissionTaskProofSubmitted event,
    Emitter<MissionTaskState> emit,
  ) async {
    emit(state.copyWith(status: const UIStatus.loading()));
    final result = await _submitMissionProofUseCase(event.missionId, event.file);
    result.fold(
      (failure) => emit(state.copyWith(
        status: UIStatus.loadFailed(message: failure.message),
      )),
      (_) => emit(state.copyWith(
        status: const UIStatus.loadSuccess(message: 'PROOF_SUBMIT_SUCCESS'),
      )),
    );
  }

  Future<void> _onMissionTaskToggleRequested(
    MissionTaskToggleRequested event,
    Emitter<MissionTaskState> emit,
  ) async {
    emit(state.copyWith(status: const UIStatus.loading()));
    final result = await _toggleTaskUseCase(
      event.userMissionId,
      event.taskId,
      event.completed,
    );
    result.fold(
      (failure) => emit(state.copyWith(
        status: UIStatus.loadFailed(message: failure.message),
      )),
      (_) {
        if (state.detail != null) {
          final updatedUserTasks = state.detail!.userTasks.map((ut) {
            if (ut.taskId == event.taskId) {
              return UserTaskModel(
                userTaskId: ut.userTaskId,
                userId: ut.userId,
                taskId: ut.taskId,
                userMissionId: ut.userMissionId,
                isCompleted: event.completed,
                completedAt: event.completed ? DateTime.now() : null,
                updatedAt: DateTime.now(),
              );
            }
            return ut;
          }).toList();

          final updatedDetail = MissionDetailModel(
            mission: state.detail!.mission,
            userMission: state.detail!.userMission,
            tasks: state.detail!.tasks,
            userTasks: updatedUserTasks,
          );

          emit(state.copyWith(
            status: const UIStatus.loadSuccess(message: 'TOGGLE_SUCCESS'),
            detail: updatedDetail,
          ));
        } else {
          emit(state.copyWith(
            status: const UIStatus.loadSuccess(message: 'TOGGLE_SUCCESS'),
          ));
        }
      },
    );
  }
}
