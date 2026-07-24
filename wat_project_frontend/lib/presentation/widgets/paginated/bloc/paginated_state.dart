

part of 'paginated_bloc.dart';

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
