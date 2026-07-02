part of 'profile_bloc.dart';

@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(UIStatus.initial()) UIStatus status,
    UserProfileModel? profile,
    @Default([]) List<Badge> badges,
    @Default([]) List<CreditRecord> creditHistory,
  }) = _ProfileState;
}
