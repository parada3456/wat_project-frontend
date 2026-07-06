import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';
import 'package:wat_project_frontend/domain/usecases/mission_usecases.dart';
import 'package:wat_project_frontend/domain/usecases/user_usecases.dart';

part 'mission_task_event.dart';
part 'mission_task_state.dart';
part 'mission_task_bloc.freezed.dart';

class MissionTaskBloc extends Bloc<MissionTaskEvent, MissionTaskState> {
  final ListAllMissionsUseCase _listAllMissionsUseCase;
  final ListUserMissionsUseCase _listAvailableMissionsUseCase;
  final GetExploreMissionUseCase _getExploreMissionUseCase;
  final GetMissionDetailUseCase _getMissionDetailUseCase;
  final SubmitMissionProofUseCase _submitMissionProofUseCase;
  final ToggleTaskUseCase _toggleTaskUseCase;
  final JoinMissionUseCase _joinMissionUseCase;
  final GetProfileUseCase _getProfileUseCase;

  MissionTaskBloc(
    this._listAvailableMissionsUseCase,
    this._getMissionDetailUseCase,
    this._submitMissionProofUseCase,
    this._toggleTaskUseCase,
    this._getExploreMissionUseCase,
    this._joinMissionUseCase,
    this._getProfileUseCase,
    this._listAllMissionsUseCase,
  ) : super(const MissionTaskState()) {
    on<MissionsTasksListRequested>(_onMissionsTasksListRequested);
    on<MissionTaskDetailRequested>(_onMissionTaskDetailRequested);
    on<MissionTaskProofSubmitted>(_onMissionTaskProofSubmitted);
    on<MissionTaskToggleRequested>(_onMissionTaskToggleRequested);
    on<ExploreMissionsRequested>(_onExploreMissionsRequested);
    on<JoinMissionRequested>(_onJoinMissionRequested);
    on<FilterMissionsRequested>(_onFilterMissionsRequested);
  }

  Future<void> _onMissionsTasksListRequested(
    MissionsTasksListRequested event,
    Emitter<MissionTaskState> emit,
  ) async {
    emit(state.copyWith(status: const UIStatus.loading()));
    final profileResult = await _getProfileUseCase();
    String? currentPhaseId;
    profileResult.fold(
      (_) {},
      (profile) => currentPhaseId = profile.user.currentPhaseId,
    );
    final result = await _listAvailableMissionsUseCase();
    final allMissionsResult = await _listAllMissionsUseCase();
    
    List<MissionModel> allMissions = [];
    allMissionsResult.fold((_) {}, (m) => allMissions = m);

    result.fold(
      (failure) => emit(state.copyWith(
        status: UIStatus.loadFailed(message: failure.message),
      )),
      (missions) => emit(state.copyWith(
        status: const UIStatus.loadSuccess(),
        missions: missions,
        allMissions: allMissions,
        currentPhaseId: currentPhaseId,
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

  Future<void> _onExploreMissionsRequested(
    ExploreMissionsRequested event,
    Emitter<MissionTaskState> emit,
  ) async {
    emit(state.copyWith(status: const UIStatus.loading()));
    final profileResult = await _getProfileUseCase();
    String? currentPhaseId;
    profileResult.fold(
      (_) {},
      (profile) => currentPhaseId = profile.user.currentPhaseId,
    );
    final result = await _getExploreMissionUseCase();
    result.fold(
      (failure) => emit(state.copyWith(
        status: UIStatus.loadFailed(message: failure.message),
      )),
      (exploreMissions) => emit(state.copyWith(
        status: const UIStatus.loadSuccess(),
        exploreMissions: exploreMissions,
        currentPhaseId: currentPhaseId,
      )),
    );
  }

  Future<void> _onJoinMissionRequested(
    JoinMissionRequested event,
    Emitter<MissionTaskState> emit,
  ) async {
    emit(state.copyWith(status: const UIStatus.loading()));
    final result = await _joinMissionUseCase(event.missionId);
    await result.fold(
      (failure) async => emit(state.copyWith(
        status: UIStatus.loadFailed(message: failure.message),
      )),
      (_) async {
        emit(state.copyWith(
          status: const UIStatus.loadSuccess(message: 'JOIN_SUCCESS'),
        ));
        
        final profileResult = await _getProfileUseCase();
        String? currentPhaseId;
        profileResult.fold(
          (_) {},
          (profile) => currentPhaseId = profile.user.currentPhaseId,
        );

        final userMissionsResult = await _listAvailableMissionsUseCase();
        final exploreMissionsResult = await _getExploreMissionUseCase();
        final allMissionsResult = await _listAllMissionsUseCase();
        
        List<MissionDetailModel> missions = state.missions;
        userMissionsResult.fold((_) {}, (m) => missions = m);

        List<MissionModel> exploreMissions = state.exploreMissions;
        exploreMissionsResult.fold((_) {}, (em) => exploreMissions = em);

        List<MissionModel> allMissions = state.allMissions;
        allMissionsResult.fold((_) {}, (m) => allMissions = m);

        emit(state.copyWith(
          missions: missions,
          exploreMissions: exploreMissions,
          allMissions: allMissions,
          currentPhaseId: currentPhaseId,
        ));
      },
    );
  }

  Future<void> _onFilterMissionsRequested(
    FilterMissionsRequested event,
    Emitter<MissionTaskState> emit,
  ) async {
    emit(state.copyWith(isFilterMandatory: event.showMandatory));
  }
}
