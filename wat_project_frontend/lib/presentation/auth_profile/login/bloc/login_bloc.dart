import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wat_project_frontend/domain/usecases/login_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/register_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/forgot_password_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/reset_password_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/logout_usecase.dart';
import 'package:wat_project_frontend/domain/services/auth_manager.dart';
import 'package:wat_project_frontend/domain/repositories/user_repository.dart';
import 'package:wat_project_frontend/presentation/auth_profile/login/bloc/login_event.dart';
import 'package:wat_project_frontend/presentation/auth_profile/login/bloc/login_state.dart';
import 'package:wat_project_frontend/core/error/failures.dart';

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
  ) : super(const LoginInitial()) {
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
    emit(const LoginLoading());
    final result = await _loginUseCase(event.email, event.password);
    await result.fold(
      (failure) async {
        if (failure is BackendFailure) {
          emit(LoginFailure(failure.message, apiError: failure.apiError));
        } else {
          emit(LoginFailure(failure.message));
        }
      },
      (tokens) async {
        await _authManager.saveSession(tokens, null);
        try {
          final user = await _userRepository.getMe();
          await _authManager.saveSession(tokens, user.id);
          emit(LoginSuccess(tokens));
        } catch (e) {
          emit(LoginFailure(e.toString()));
        }
      },
    );
  }

  Future<void> _onRegisterSubmitted(
    RegisterSubmittedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginLoading());
    final result = await _registerUseCase(
      event.email,
      event.password,
      event.firstName,
      event.lastName,
    );
    await result.fold(
      (failure) async {
        if (failure is BackendFailure) {
          emit(LoginFailure(failure.message, apiError: failure.apiError));
        } else {
          emit(LoginFailure(failure.message));
        }
      },
      (tokens) async {
        await _authManager.saveSession(tokens, null);
        try {
          final user = await _userRepository.getMe();
          await _authManager.saveSession(tokens, user.id);
          emit(LoginSuccess(tokens));
        } catch (e) {
          emit(LoginFailure(e.toString()));
        }
      },
    );
  }

  Future<void> _onForgotPasswordSubmitted(
    ForgotPasswordSubmittedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginLoading());
    final result = await _forgotPasswordUseCase(event.email);
    result.fold(
      (failure) => emit(LoginFailure(failure.message)),
      (_) => emit(const ForgotPasswordSuccess()),
    );
  }

  Future<void> _onResetPasswordSubmitted(
    ResetPasswordSubmittedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginLoading());
    final result = await _resetPasswordUseCase(event.token, event.newPassword);
    result.fold(
      (failure) => emit(LoginFailure(failure.message)),
      (_) => emit(const ResetPasswordSuccess()),
    );
  }

  Future<void> _onLogoutRequested(
    LogoutRequestedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginLoading());
    final refreshToken = _authManager.currentSession?.refreshToken ?? '';
    final result = await _logoutUseCase(refreshToken);
    result.fold(
      (failure) => emit(LoginFailure(failure.message)),
      (_) async {
        await _authManager.clearSession();
        emit(const LoginInitial());
      },
    );
  }
}
