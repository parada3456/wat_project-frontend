import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/mission/create_mission_request.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/domain/usecases/mission_usecases.dart';
import 'package:wat_project_frontend/domain/usecases/user_usecases.dart';

part 'mission_task_event.dart';
part 'mission_task_state.dart';
part 'mission_task_bloc.freezed.dart';

class MissionTaskBloc extends Bloc<MissionTaskEvent, MissionTaskState> {
  final ListAllMissionsUseCase _listAllMissionsUseCase;
  final ListMyMissionsUseCase _listMyMissionsUseCase;
  final GetExploreMissionUseCase _getExploreMissionUseCase;
  final GetMissionDetailUseCase _getMissionDetailUseCase;
  final SubmitMissionProofUseCase _submitMissionProofUseCase;
  final ToggleTaskUseCase _toggleTaskUseCase;
  final JoinMissionUseCase _joinMissionUseCase;
  final GetProfileUseCase _getProfileUseCase;
  final CreateMissionUseCase _createMissionUseCase;

  MissionTaskBloc(
    this._listMyMissionsUseCase,
    this._getMissionDetailUseCase,
    this._submitMissionProofUseCase,
    this._toggleTaskUseCase,
    this._getExploreMissionUseCase,
    this._joinMissionUseCase,
    this._getProfileUseCase,
    this._listAllMissionsUseCase,
    this._createMissionUseCase,
  ) : super(const MissionTaskState()) {
    on<MissionsTasksListRequested>(_onMissionsTasksListRequested);
    on<MissionTaskDetailRequested>(_onMissionTaskDetailRequested);
    on<MissionTaskProofSubmitted>(_onMissionTaskProofSubmitted);
    on<MissionTaskToggleRequested>(_onMissionTaskToggleRequested);
    on<ExploreMissionsRequested>(_onExploreMissionsRequested);
    on<JoinMissionRequested>(_onJoinMissionRequested);
    on<FilterMissionsRequested>(_onFilterMissionsRequested);
    on<CreateMissionSubmitted>(_onCreateMissionSubmitted);
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
    final result = await _listMyMissionsUseCase();
    final allMissionsResult = await _listAllMissionsUseCase();

    List<MissionModel> allMissions = [];
    allMissionsResult.fold((_) {}, (p) => allMissions = p.data);

    result.fold(
      (failure) => emit(
        state.copyWith(status: UIStatus.loadFailed(message: failure.message)),
      ),
      (paginated) => emit(
        state.copyWith(
          status: const UIStatus.loadSuccess(),
          missions: paginated.data,
          allMissions: allMissions,
          currentPhaseId: currentPhaseId,
        ),
      ),
    );
  }

  Future<void> _onMissionTaskDetailRequested(
    MissionTaskDetailRequested event,
    Emitter<MissionTaskState> emit,
  ) async {
    emit(state.copyWith(status: const UIStatus.loading()));
    final result = await _getMissionDetailUseCase(event.missionId);
    result.fold(
      (failure) => emit(
        state.copyWith(status: UIStatus.loadFailed(message: failure.message)),
      ),
      (detail) => emit(
        state.copyWith(status: const UIStatus.loadSuccess(), detail: detail),
      ),
    );
  }

  Future<void> _onMissionTaskProofSubmitted(
    MissionTaskProofSubmitted event,
    Emitter<MissionTaskState> emit,
  ) async {
    emit(state.copyWith(status: const UIStatus.loading()));
    final result = await _submitMissionProofUseCase(
      event.missionId,
      event.file,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(status: UIStatus.loadFailed(message: failure.message)),
      ),
      (_) => emit(
        state.copyWith(
          status: const UIStatus.loadSuccess(message: 'PROOF_SUBMIT_SUCCESS'),
        ),
      ),
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
      (failure) => emit(
        state.copyWith(status: UIStatus.loadFailed(message: failure.message)),
      ),
      (_) {
        if (state.detail != null) {
          final updatedTasks = state.detail!.tasks.map((task) {
            if (task.taskId == event.taskId) {
              return TaskModel(
                taskId: task.taskId,
                title: task.title,
                description: task.description,
                isCompleted: event.completed,
                completedAt: event.completed ? DateTime.now() : null,
              );
            }
            return task;
          }).toList();

          final updatedDetail = MissionModel(
            missionId: state.detail!.missionId,
            phaseId: state.detail!.phaseId,
            title: state.detail!.title,
            description: state.detail!.description,
            location: state.detail!.location,
            basePoints: state.detail!.basePoints,
            isMandatory: state.detail!.isMandatory,
            verificationType: state.detail!.verificationType,
            userMission: state.detail!.userMission,
            tasks: updatedTasks,
            isActive: state.detail!.isActive,
            isLocked: state.detail!.isLocked,
            createdAt: state.detail!.createdAt,
            updatedAt: state.detail!.updatedAt,
          );

          emit(
            state.copyWith(
              status: const UIStatus.loadSuccess(message: 'TOGGLE_SUCCESS'),
              detail: updatedDetail,
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: const UIStatus.loadSuccess(message: 'TOGGLE_SUCCESS'),
            ),
          );
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
      (failure) => emit(
        state.copyWith(status: UIStatus.loadFailed(message: failure.message)),
      ),
      (paginated) => emit(
        state.copyWith(
          status: const UIStatus.loadSuccess(),
          exploreMissions: paginated.data,
          currentPhaseId: currentPhaseId,
        ),
      ),
    );
  }

  Future<void> _onJoinMissionRequested(
    JoinMissionRequested event,
    Emitter<MissionTaskState> emit,
  ) async {
    emit(state.copyWith(status: const UIStatus.loading()));
    final result = await _joinMissionUseCase(event.missionId);
    await result.fold(
      (failure) async => emit(
        state.copyWith(status: UIStatus.loadFailed(message: failure.message)),
      ),
      (_) async {
        emit(
          state.copyWith(
            status: const UIStatus.loadSuccess(message: 'JOIN_SUCCESS'),
          ),
        );

        final profileResult = await _getProfileUseCase();
        String? currentPhaseId;
        profileResult.fold(
          (_) {},
          (profile) => currentPhaseId = profile.user.currentPhaseId,
        );

        final userMissionsResult = await _listMyMissionsUseCase();
        final exploreMissionsResult = await _getExploreMissionUseCase();
        final allMissionsResult = await _listAllMissionsUseCase();

        List<MissionModel> missions = state.missions;
        userMissionsResult.fold((_) {}, (p) => missions = p.data);

        List<MissionModel> exploreMissions = state.exploreMissions;
        exploreMissionsResult.fold((_) {}, (p) => exploreMissions = p.data);

        List<MissionModel> allMissions = state.allMissions;
        allMissionsResult.fold((_) {}, (p) => allMissions = p.data);

        emit(
          state.copyWith(
            missions: missions,
            exploreMissions: exploreMissions,
            allMissions: allMissions,
            currentPhaseId: currentPhaseId,
          ),
        );
      },
    );
  }

  Future<void> _onFilterMissionsRequested(
    FilterMissionsRequested event,
    Emitter<MissionTaskState> emit,
  ) async {
    emit(state.copyWith(isFilterMandatory: event.showMandatory));
  }

  Future<void> _onCreateMissionSubmitted(
    CreateMissionSubmitted event,
    Emitter<MissionTaskState> emit,
  ) async {
    emit(state.copyWith(status: const UIStatus.loading()));
    final result = await _createMissionUseCase(event.request);
    result.fold(
      (failure) => emit(
        state.copyWith(status: UIStatus.loadFailed(message: failure.message)),
      ),
      (mission) => emit(
        state.copyWith(
          status: const UIStatus.loadSuccess(message: 'MISSION_CREATED'),
          createdMission: mission,
        ),
      ),
    );
  }
}
