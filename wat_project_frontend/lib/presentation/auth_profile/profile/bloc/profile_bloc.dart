import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wat_project_frontend/domain/usecases/get_profile_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/update_profile_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/get_badges_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/get_credit_score_history_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/update_location_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/delete_account_usecase.dart';
import 'package:wat_project_frontend/presentation/auth_profile/profile/bloc/profile_event.dart';
import 'package:wat_project_frontend/presentation/auth_profile/profile/bloc/profile_state.dart';

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
  ) : super(const ProfileInitial()) {
    on<GetProfileEvent>(_onGetProfile);
    on<UpdateProfileSubmittedEvent>(_onUpdateProfileSubmitted);
    on<UpdateLocationSubmittedEvent>(_onUpdateLocationSubmitted);
    on<DeleteAccountSubmittedEvent>(_onDeleteAccountSubmitted);
  }

  Future<void> _onGetProfile(
    GetProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());
    
    final profileResult = await _getProfileUseCase();
    final badgesResult = await _getBadgesUseCase();
    final historyResult = await _getCreditScoreHistoryUseCase();

    profileResult.fold(
      (failure) => emit(ProfileFailure(failure.message)),
      (profile) {
        badgesResult.fold(
          (failure) => emit(ProfileFailure(failure.message)),
          (badges) {
            historyResult.fold(
              (failure) => emit(ProfileFailure(failure.message)),
              (history) => emit(ProfileSuccess(
                profile: profile,
                badges: badges,
                creditHistory: history,
              )),
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
    emit(const ProfileLoading());

    final result = await _updateProfileUseCase(
      event.firstName,
      event.lastName,
      event.bio,
      event.avatarUrl,
    );

    await result.fold(
      (failure) async => emit(ProfileFailure(failure.message)),
      (profile) async {
        final badgesResult = await _getBadgesUseCase();
        final historyResult = await _getCreditScoreHistoryUseCase();

        badgesResult.fold(
          (failure) => emit(ProfileFailure(failure.message)),
          (badges) {
            historyResult.fold(
              (failure) => emit(ProfileFailure(failure.message)),
              (history) => emit(ProfileSuccess(
                profile: profile,
                badges: badges,
                creditHistory: history,
              )),
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
    emit(const ProfileLoading());
    final result = await _updateLocationUseCase(event.latitude, event.longitude);

    await result.fold(
      (failure) async => emit(ProfileFailure(failure.message)),
      (_) async {
        final profileResult = await _getProfileUseCase();
        final badgesResult = await _getBadgesUseCase();
        final historyResult = await _getCreditScoreHistoryUseCase();

        profileResult.fold(
          (failure) => emit(ProfileFailure(failure.message)),
          (profile) {
            badgesResult.fold(
              (failure) => emit(ProfileFailure(failure.message)),
              (badges) {
                historyResult.fold(
                  (failure) => emit(ProfileFailure(failure.message)),
                  (history) => emit(ProfileSuccess(
                    profile: profile,
                    badges: badges,
                    creditHistory: history,
                  )),
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
    emit(const ProfileLoading());
    final result = await _deleteAccountUseCase(event.password);
    result.fold(
      (failure) => emit(ProfileFailure(failure.message)),
      (_) => emit(const DeleteAccountSuccess()),
    );
  }
}
