import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wat_project_frontend/domain/models/paged_model.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';

// ── Events ──────────────────────────────────────────────────────────────────

abstract class ListEvent {
  const ListEvent();
}

class ListFetchNextPage extends ListEvent {
  const ListFetchNextPage();
}

class ListRefresh extends ListEvent {
  const ListRefresh();
}

class ListResetItems<T> extends ListEvent {
  final List<T> items;
  final bool hasMore;
  const ListResetItems(this.items, {this.hasMore = false});
}

// ── State ───────────────────────────────────────────────────────────────────

class ListState<T> {
  final UIStatus status;
  final PagedModel<T> pagedModel;

  ListState({required this.status, required this.pagedModel});

  factory ListState.initial({
    int pageSize = 20,
    List<T>? initialItems,
    bool hasMore = true,
  }) {
    final hasItems = initialItems != null && initialItems.isNotEmpty;
    final nextPageVal = hasItems ? 2 : 1;
    final calculatedHasMore =
        initialItems == null || initialItems.length >= pageSize;
    if (initialItems != null) {
      print(
        'ListState.initial: initialItems provided (length: ${initialItems.length}), setting nextPage = $nextPageVal, hasMore = $calculatedHasMore',
      );
    } else {
      print('initialItem is null --------------- nextPageVal: $nextPageVal');
    }
    return ListState(
      status: hasItems
          ? const UIStatus.loadSuccess()
          : const UIStatus.initial(),
      pagedModel: PagedModel(
        items: initialItems ?? [],
        nextPage: nextPageVal,
        hasMore: calculatedHasMore,
        pageSize: pageSize,
      ),
    );
  }

  ListState<T> copyWith({UIStatus? status, PagedModel<T>? pagedModel}) {
    return ListState<T>(
      status: status ?? this.status,
      pagedModel: pagedModel ?? this.pagedModel,
    );
  }
}

// ── Bloc ────────────────────────────────────────────────────────────────────

typedef ListFetchCallback<T> =
    Future<PagedModel<T>> Function(int page, int pageSize);

class ListBloc<T> extends Bloc<ListEvent, ListState<T>> {
  final ListFetchCallback<T> fetchCallback;

  ListBloc({
    required this.fetchCallback,
    int pageSize = 20,
    List<T>? initialItems,
    bool hasMore = true,
  }) : super(
         ListState<T>.initial(
           pageSize: pageSize,
           initialItems: initialItems,
           hasMore: hasMore,
         ),
       ) {
    on<ListFetchNextPage>(_onFetchNextPage);
    on<ListRefresh>(_onRefresh);
    on<ListResetItems<T>>(_onResetItems);
  }

  Future<void> _onFetchNextPage(
    ListFetchNextPage event,
    Emitter<ListState<T>> emit,
  ) async {
    print("try fetch next page");
    if (state.status == const UIStatus.loading() || !state.pagedModel.hasMore) {
      return;
    }

    emit(state.copyWith(status: const UIStatus.loading()));

    try {
      final nextPage = state.pagedModel.nextPage;
      final response = await fetchCallback(nextPage, state.pagedModel.pageSize);

      final updatedItems = List<T>.from(state.pagedModel.items)
        ..addAll(response.items);

      emit(
        state.copyWith(
          status: const UIStatus.loadSuccess(),
          pagedModel: PagedModel<T>(
            items: updatedItems,
            nextPage: response.nextPage,
            hasMore: response.hasMore,
            pageSize: response.pageSize,
          ),
        ),
      );
    } catch (e) {
      print("try fetch next page fail");
      emit(state.copyWith(status: UIStatus.loadFailed(message: e.toString())));
    }
  }

  Future<void> _onRefresh(ListRefresh event, Emitter<ListState<T>> emit) async {
    print("on refresh list bloc");
    emit(ListState<T>.initial(pageSize: state.pagedModel.pageSize));
    add(const ListFetchNextPage());
  }

  void _onResetItems(ListResetItems<T> event, Emitter<ListState<T>> emit) {
    final nextPageVal = event.items.isNotEmpty ? 2 : 1;
    final calculatedHasMore = event.items.length >= state.pagedModel.pageSize;
    emit(
      state.copyWith(
        status: event.items.isNotEmpty
            ? const UIStatus.loadSuccess()
            : const UIStatus.initial(),
        pagedModel: PagedModel<T>(
          items: event.items,
          nextPage: nextPageVal,
          hasMore: calculatedHasMore,
          pageSize: state.pagedModel.pageSize,
        ),
      ),
    );
  }
}
