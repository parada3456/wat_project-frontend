import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/domain/usecases/get_posts_usecase.dart';

part 'home_bloc.freezed.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.homeFetched() = HomeFetched;
}

class HomeState {
  final UiStatus uiStatus;

  const HomeState({
    this.uiStatus = const UiStatus.idle(),
  });

  HomeState copyWith({
    UiStatus? uiStatus,
  }) {
    return HomeState(
      uiStatus: uiStatus ?? this.uiStatus,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeState &&
          runtimeType == other.runtimeType &&
          uiStatus == other.uiStatus;

  @override
  int get hashCode => uiStatus.hashCode;
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetPostsUseCase _getPostsUseCase;

  HomeBloc(this._getPostsUseCase) : super(const HomeState()) {
    on<HomeFetched>(_onHomeFetched);
  }

  Future<void> _onHomeFetched(HomeFetched event, Emitter<HomeState> emit) async {
    emit(state.copyWith(uiStatus: const UiStatus.loading()));
    try {
      final posts = await _getPostsUseCase();
      emit(state.copyWith(uiStatus: UiStatus.success(posts)));
    } catch (e) {
      emit(state.copyWith(uiStatus: UiStatus.error(e.toString())));
    }
  }
}
