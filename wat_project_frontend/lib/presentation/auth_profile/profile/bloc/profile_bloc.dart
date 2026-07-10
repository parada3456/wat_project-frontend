import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wat_project_frontend/domain/usecases/user_usecases.dart';
import 'package:wat_project_frontend/domain/usecases/user_usecases.dart';
import 'package:wat_project_frontend/domain/usecases/gamification_usecases.dart';
import 'package:wat_project_frontend/domain/usecases/user_usecases.dart';
import 'package:wat_project_frontend/domain/usecases/user_usecases.dart';
import 'package:wat_project_frontend/domain/usecases/user_usecases.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/domain/models/user_models.dart';
import 'package:wat_project_frontend/domain/models/gamification_models.dart';
import 'package:wat_project_frontend/domain/models/user_models.dart';

part 'profile_event.dart';
part 'profile_state.dart';
part 'profile_bloc.freezed.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase _getProfileUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;
  final GetBadgesUseCase _getBadgesUseCase;
  final GetCreditScoreHistoryUseCase _getCreditScoreHistoryUseCase;
  final UpdateLocationUseCase _updateLocationUseCase;
  final DeleteAccountUseCase _deleteAccountUseCase;

  ProfileBloc(
    this._getProfileUseCase,
    this._updateProfileUseCase,
    this._getBadgesUseCase,
    this._getCreditScoreHistoryUseCase,
    this._updateLocationUseCase,
    this._deleteAccountUseCase,
  ) : super(const ProfileState()) {
    on<GetProfileEvent>(_onGetProfile);
    on<UpdateProfileSubmittedEvent>(_onUpdateProfileSubmitted);
    on<UpdateLocationSubmittedEvent>(_onUpdateLocationSubmitted);
    on<DeleteAccountSubmittedEvent>(_onDeleteAccountSubmitted);
  }

  Future<void> _onGetProfile(
    GetProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: const UIStatus.loading()));

    final profileResult = await _getProfileUseCase();
    final badgesResult = await _getBadgesUseCase();
    final historyResult = await _getCreditScoreHistoryUseCase();

    await profileResult.fold(
      (failure) async => emit(
        state.copyWith(status: UIStatus.loadFailed(message: failure.message)),
      ),
      (profile) async {
        await badgesResult.fold(
          (failure) async => emit(
            state.copyWith(
              status: UIStatus.loadFailed(message: failure.message),
            ),
          ),
          (badges) async {
            await historyResult.fold(
              (failure) async => emit(
                state.copyWith(
                  status: UIStatus.loadFailed(message: failure.message),
                ),
              ),
              (history) async => emit(
                state.copyWith(
                  status: const UIStatus.loadSuccess(),
                  profile: profile,
                  badges: badges,
                  creditHistory: history,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _onUpdateProfileSubmitted(
    UpdateProfileSubmittedEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: const UIStatus.loading()));

    final result = await _updateProfileUseCase(
      event.firstName,
      event.lastName,
      event.bio,
      event.avatarUrl,
    );

    await result.fold(
      (failure) async => emit(
        state.copyWith(status: UIStatus.loadFailed(message: failure.message)),
      ),
      (profile) async {
        final badgesResult = await _getBadgesUseCase();
        final historyResult = await _getCreditScoreHistoryUseCase();

        await badgesResult.fold(
          (failure) async => emit(
            state.copyWith(
              status: UIStatus.loadFailed(message: failure.message),
            ),
          ),
          (badges) async {
            await historyResult.fold(
              (failure) async => emit(
                state.copyWith(
                  status: UIStatus.loadFailed(message: failure.message),
                ),
              ),
              (history) async => emit(
                state.copyWith(
                  status: const UIStatus.loadSuccess(
                    message: 'อัปเดตโปรไฟล์สำเร็จ',
                  ),
                  profile: profile,
                  badges: badges,
                  creditHistory: history,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _onUpdateLocationSubmitted(
    UpdateLocationSubmittedEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: const UIStatus.loading()));
    final result = await _updateLocationUseCase(
      event.latitude,
      event.longitude,
    );

    await result.fold(
      (failure) async => emit(
        state.copyWith(status: UIStatus.loadFailed(message: failure.message)),
      ),
      (_) async {
        final profileResult = await _getProfileUseCase();
        final badgesResult = await _getBadgesUseCase();
        final historyResult = await _getCreditScoreHistoryUseCase();

        await profileResult.fold(
          (failure) async => emit(
            state.copyWith(
              status: UIStatus.loadFailed(message: failure.message),
            ),
          ),
          (profile) async {
            await badgesResult.fold(
              (failure) async => emit(
                state.copyWith(
                  status: UIStatus.loadFailed(message: failure.message),
                ),
              ),
              (badges) async {
                await historyResult.fold(
                  (failure) async => emit(
                    state.copyWith(
                      status: UIStatus.loadFailed(message: failure.message),
                    ),
                  ),
                  (history) async => emit(
                    state.copyWith(
                      status: const UIStatus.loadSuccess(
                        message: 'อัปเดตตำแหน่งสำเร็จ',
                      ),
                      profile: profile,
                      badges: badges,
                      creditHistory: history,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Future<void> _onDeleteAccountSubmitted(
    DeleteAccountSubmittedEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: const UIStatus.loading()));
    final result = await _deleteAccountUseCase(event.password);
    result.fold(
      (failure) => emit(
        state.copyWith(status: UIStatus.loadFailed(message: failure.message)),
      ),
      (_) => emit(
        state.copyWith(
          status: const UIStatus.loadSuccess(message: 'DELETE_ACCOUNT_SUCCESS'),
        ),
      ),
    );
  }
}
