part of 'home_bloc.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class HomeFetched extends HomeEvent {
  const HomeFetched();
}
