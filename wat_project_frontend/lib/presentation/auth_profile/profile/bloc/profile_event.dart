part of 'profile_bloc.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.getProfile() = GetProfileEvent;

  const factory ProfileEvent.updateProfile({
    required String firstName,
    required String lastName,
    required String bio,
    required String avatarUrl,
  }) = UpdateProfileSubmittedEvent;

  const factory ProfileEvent.updateLocation({
    required double latitude,
    required double longitude,
  }) = UpdateLocationSubmittedEvent;

  const factory ProfileEvent.deleteAccount(String password) = DeleteAccountSubmittedEvent;
}
