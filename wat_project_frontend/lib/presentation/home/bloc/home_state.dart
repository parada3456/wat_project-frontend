part of 'home_bloc.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default(UIStatus.initial()) UIStatus status,
    HomeData? homeData,
  }) = _HomeState;
}
