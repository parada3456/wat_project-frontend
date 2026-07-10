import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wat_project_frontend/data/entities/user/user_profile_entity.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/domain/usecases/auth_usecases.dart';
import 'package:wat_project_frontend/domain/usecases/auth_usecases.dart';
import 'package:wat_project_frontend/domain/usecases/user_usecases.dart';
import 'package:wat_project_frontend/domain/usecases/auth_usecases.dart';
import 'package:wat_project_frontend/domain/usecases/auth_usecases.dart';
import 'package:wat_project_frontend/domain/services/auth_manager.dart';
import 'package:wat_project_frontend/domain/repositories/user_repository.dart';
import 'package:wat_project_frontend/core/error/failures.dart';

part 'login_state.dart';
part 'login_event.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final LogoutUseCase _logoutUseCase;
  final AuthSessionManager _authManager;
  final UserRepository _userRepository;

  LoginBloc(
    this._loginUseCase,
    this._registerUseCase,
    this._forgotPasswordUseCase,
    this._resetPasswordUseCase,
    this._logoutUseCase,
    this._authManager,
    this._userRepository,
  ) : super(LoginState()) {
    on<LoginSubmittedEvent>(_onLoginSubmitted);
    on<RegisterSubmittedEvent>(_onRegisterSubmitted);
    on<ForgotPasswordSubmittedEvent>(_onForgotPasswordSubmitted);
    on<ResetPasswordSubmittedEvent>(_onResetPasswordSubmitted);
    on<LogoutRequestedEvent>(_onLogoutRequested);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmittedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: const UIStatus.loading()));

    final result = await _loginUseCase(event.email, event.password);

    await result.fold(
      (failure) async {
        print("login fail");
        if (failure is BackendFailure) {
          print("backend failed");
          emit(
            state.copyWith(
              status: UIStatus.loadFailed(
                message: failure.message,
                apiError: failure.apiError,
              ),
            ),
          );
        } else {
          print("fail unknown");
          emit(
            state.copyWith(
              status: UIStatus.loadFailed(message: failure.message),
            ),
          );
        }
      },
      (tokens) async {
        print("login success");
        await _authManager.saveSession(tokens, null);
        try {
          final UserProfileEntity userProfileEntity = await _userRepository
              .getMe();
          await _authManager.saveSession(
            tokens,
            userProfileEntity.userAccount.userId,
          );

          emit(
            state.copyWith(
              status: const UIStatus.loadSuccess(message: 'เข้าสู่ระบบสำเร็จ'),
            ),
          );
        } catch (e) {
          print("auth save failed");
          emit(
            state.copyWith(status: UIStatus.loadFailed(message: e.toString())),
          );
        }
      },
    );
  }

  Future<void> _onRegisterSubmitted(
    RegisterSubmittedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: const UIStatus.loading()));

    final result = await _registerUseCase(
      event.email,
      event.password,
      event.firstName,
      event.lastName,
    );

    await result.fold(
      (failure) async {
        print("register fail");
        if (failure is BackendFailure) {
          print("backend failed");
          emit(
            state.copyWith(
              status: UIStatus.loadFailed(
                message: failure.message,
                apiError: failure.apiError,
              ),
            ),
          );
        } else {
          print("fail unknown");
          emit(
            state.copyWith(
              status: UIStatus.loadFailed(message: failure.message),
            ),
          );
        }
      },
      (tokens) async {
        print("register success");
        await _authManager.saveSession(tokens, null);
        try {
          final UserProfileEntity userProfileEntity = await _userRepository
              .getMe();
          await _authManager.saveSession(
            tokens,
            userProfileEntity.userAccount.userId,
          );

          emit(
            state.copyWith(
              status: const UIStatus.loadSuccess(message: 'สมัครสมาชิกสำเร็จ'),
            ),
          );
        } catch (e) {
          print("auth save failed");
          emit(
            state.copyWith(status: UIStatus.loadFailed(message: e.toString())),
          );
        }
      },
    );
  }

  Future<void> _onForgotPasswordSubmitted(
    ForgotPasswordSubmittedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: const UIStatus.loading()));

    final result = await _forgotPasswordUseCase(event.email);

    await result.fold(
      (failure) async {
        print("forgot password fail");
        if (failure is BackendFailure) {
          print("backend failed");
          emit(
            state.copyWith(
              status: UIStatus.loadFailed(
                message: failure.message,
                apiError: failure.apiError,
              ),
            ),
          );
        } else {
          print("fail unknown");
          emit(
            state.copyWith(
              status: UIStatus.loadFailed(message: failure.message),
            ),
          );
        }
      },
      (success) async {
        print("forgot password success");
        emit(
          state.copyWith(
            status: const UIStatus.loadSuccess(
              message: 'ส่งคำขอรีเซ็ตรหัสผ่านสำเร็จ',
            ),
          ),
        );
      },
    );
  }

  Future<void> _onResetPasswordSubmitted(
    ResetPasswordSubmittedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: const UIStatus.loading()));

    final result = await _resetPasswordUseCase(event.token, event.newPassword);

    await result.fold(
      (failure) async {
        print("reset password fail");
        if (failure is BackendFailure) {
          print("backend failed");
          emit(
            state.copyWith(
              status: UIStatus.loadFailed(
                message: failure.message,
                apiError: failure.apiError,
              ),
            ),
          );
        } else {
          print("fail unknown");
          emit(
            state.copyWith(
              status: UIStatus.loadFailed(message: failure.message),
            ),
          );
        }
      },
      (success) async {
        print("reset password success");
        emit(
          state.copyWith(
            status: const UIStatus.loadSuccess(message: 'รีเซ็ตรหัสผ่านสำเร็จ'),
          ),
        );
      },
    );
  }

  Future<void> _onLogoutRequested(
    LogoutRequestedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: const UIStatus.loading()));

    final refreshToken = _authManager.currentSession?.refreshToken ?? '';
    final result = await _logoutUseCase(refreshToken);

    await result.fold(
      (failure) async {
        print("logout fail");
        if (failure is BackendFailure) {
          print("backend failed");
          emit(
            state.copyWith(
              status: UIStatus.loadFailed(
                message: failure.message,
                apiError: failure.apiError,
              ),
            ),
          );
        } else {
          print("fail unknown");
          emit(
            state.copyWith(
              status: UIStatus.loadFailed(message: failure.message),
            ),
          );
        }
      },
      (success) async {
        print("logout success");
        await _authManager.clearSession();
        emit(
          state.copyWith(
            status: const UIStatus.loadSuccess(message: 'ออกจากระบบสำเร็จ'),
          ),
        );
      },
    );
  }
}
