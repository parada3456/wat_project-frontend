import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wat_project_frontend/domain/models/user_models.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/domain/usecases/user_usecases.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHomeDataUseCase _getHomeDataUseCase;

  HomeBloc(this._getHomeDataUseCase) : super(const HomeState()) {
    on<HomeFetched>(_onHomeFetched);
  }

  Future<void> _onHomeFetched(
    HomeFetched event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: const UIStatus.loading()));

    final result = await _getHomeDataUseCase();

    result.fold(
      (failure) => emit(
        state.copyWith(status: UIStatus.loadFailed(message: failure.message)),
      ),
      (homeData) => emit(
        state.copyWith(
          status: const UIStatus.loadSuccess(),
          homeData: homeData,
        ),
      ),
    );
  }
}
