import 'package:wat_project_frontend/domain/models/home_data.dart';

abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeSuccess extends HomeState {
  final HomeData data;
  const HomeSuccess(this.data);
}

class HomeFailure extends HomeState {
  final String errorMessage;
  final HomeData? fallbackData;

  const HomeFailure(this.errorMessage, {this.fallbackData});
}
