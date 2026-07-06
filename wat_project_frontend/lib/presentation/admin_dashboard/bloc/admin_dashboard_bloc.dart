import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wat_project_frontend/domain/usecases/admin_usecases.dart';
import 'package:wat_project_frontend/domain/usecases/admin_usecases.dart';
import 'package:wat_project_frontend/domain/usecases/admin_usecases.dart';
import 'package:wat_project_frontend/domain/usecases/admin_usecases.dart';
import 'package:wat_project_frontend/domain/usecases/admin_usecases.dart';
import 'package:wat_project_frontend/domain/usecases/admin_usecases.dart';
import 'package:wat_project_frontend/presentation/admin_dashboard/bloc/admin_dashboard_event.dart';
import 'package:wat_project_frontend/presentation/admin_dashboard/bloc/admin_dashboard_state.dart';

class AdminDashboardBloc extends Bloc<AdminDashboardEvent, AdminDashboardState> {
  final GetAdminStatsUseCase _getAdminStatsUseCase;
  final ListPendingVerificationsUseCase _listPendingVerificationsUseCase;
  final VerifyAdminMissionUseCase _verifyAdminMissionUseCase;
  final GetAdminUsersUseCase _getAdminUsersUseCase;
  final GetAdminUserDetailUseCase _getAdminUserDetailUseCase;
  final AdjustPointsUseCase _adjustPointsUseCase;

  AdminDashboardBloc(
    this._getAdminStatsUseCase,
    this._listPendingVerificationsUseCase,
    this._verifyAdminMissionUseCase,
    this._getAdminUsersUseCase,
    this._getAdminUserDetailUseCase,
    this._adjustPointsUseCase,
  ) : super(const AdminDashboardInitial()) {
    on<AdminStatsRequested>(_onStatsRequested);
    on<AdminPendingVerificationsRequested>(_onPendingVerificationsRequested);
    on<AdminVerifyMissionSubmitted>(_onVerifyMissionSubmitted);
    on<AdminUsersSearchRequested>(_onUsersSearchRequested);
    on<AdminUserDetailRequested>(_onUserDetailRequested);
    on<AdminAdjustPointsSubmitted>(_onAdjustPointsSubmitted);
  }

  Future<void> _onStatsRequested(
    AdminStatsRequested event,
    Emitter<AdminDashboardState> emit,
  ) async {
    emit(const AdminDashboardLoading());
    final result = await _getAdminStatsUseCase();
    result.fold(
      (failure) => emit(AdminDashboardFailure(failure.message)),
      (stats) => emit(AdminDashboardStatsSuccess(stats)),
    );
  }

  Future<void> _onPendingVerificationsRequested(
    AdminPendingVerificationsRequested event,
    Emitter<AdminDashboardState> emit,
  ) async {
    emit(const AdminDashboardLoading());
    final result = await _listPendingVerificationsUseCase();
    result.fold(
      (failure) => emit(AdminDashboardFailure(failure.message)),
      (verifications) => emit(AdminDashboardPendingVerificationsSuccess(verifications)),
    );
  }

  Future<void> _onVerifyMissionSubmitted(
    AdminVerifyMissionSubmitted event,
    Emitter<AdminDashboardState> emit,
  ) async {
    emit(const AdminDashboardLoading());
    final result = await _verifyAdminMissionUseCase(
      event.userMissionId,
      event.approved,
      event.reason,
    );
    result.fold(
      (failure) => emit(AdminDashboardFailure(failure.message)),
      (um) => emit(AdminDashboardVerifySuccess(um)),
    );
  }

  Future<void> _onUsersSearchRequested(
    AdminUsersSearchRequested event,
    Emitter<AdminDashboardState> emit,
  ) async {
    emit(const AdminDashboardLoading());
    // final result = await _getAdminUsersUseCase(event.search);
    // result.fold(
    //   (failure) => emit(AdminDashboardFailure(failure.message)),
    //   (users) => emit(AdminDashboardUsersSuccess(users)),
    // );
  }

  Future<void> _onUserDetailRequested(
    AdminUserDetailRequested event,
    Emitter<AdminDashboardState> emit,
  ) async {
    emit(const AdminDashboardLoading());
    final result = await _getAdminUserDetailUseCase(event.userId);
    result.fold(
      (failure) => emit(AdminDashboardFailure(failure.message)),
      (user) => emit(AdminDashboardUserDetailSuccess(user)),
    );
  }

  Future<void> _onAdjustPointsSubmitted(
    AdminAdjustPointsSubmitted event,
    Emitter<AdminDashboardState> emit,
  ) async {
    emit(const AdminDashboardLoading());
    final result = await _adjustPointsUseCase(
      event.userId,
      event.pointsDelta,
      event.reason,
    );
    result.fold(
      (failure) => emit(AdminDashboardFailure(failure.message)),
      (adjResult) => emit(AdminDashboardAdjustPointsSuccess(adjResult)),
    );
  }
}
