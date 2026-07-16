import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/domain/models/paged_model.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/presentation/widgets/error_page.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

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
      emit(state.copyWith(status: UIStatus.loadFailed(message: e.toString())));
    }
  }

  Future<void> _onRefresh(ListRefresh event, Emitter<ListState<T>> emit) async {
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

// ── UI Paged List View ──────────────────────────────────────────────────────

class PagedListView<T> extends StatefulWidget {
  final ListBloc<T> bloc;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final Widget Function(BuildContext context)? emptyBuilder;
  final String? emptyMessage;
  final EdgeInsetsGeometry? padding;
  final String? noMoreItemsMessage;
  final bool enablePullToRefresh;
  final ScrollController? scrollController;
  final Widget Function(BuildContext context, int index)? separatorBuilder;

  const PagedListView({
    super.key,
    required this.bloc,
    required this.itemBuilder,
    this.emptyBuilder,
    this.emptyMessage,
    this.padding,
    this.noMoreItemsMessage,
    this.enablePullToRefresh = true,
    this.scrollController,
    this.separatorBuilder,
  });

  @override
  State<PagedListView<T>> createState() => _PagedListViewState<T>();
}

class _PagedListViewState<T> extends State<PagedListView<T>> {
  late final ScrollController _scrollController;
  bool _isLocalScrollController = false;

  @override
  void initState() {
    super.initState();
    if (widget.scrollController != null) {
      _scrollController = widget.scrollController!;
    } else {
      _scrollController = ScrollController();
      _isLocalScrollController = true;
    }
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    if (_isLocalScrollController) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  void _onScroll() {
    final pos = _scrollController.position;
    if (pos.pixels >= pos.maxScrollExtent - 250) {
      widget.bloc.add(const ListFetchNextPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    final subtextColor = AppColors.textSub(context);

    return BlocBuilder<ListBloc<T>, ListState<T>>(
      bloc: widget.bloc,
      builder: (context, state) {
        final items = state.pagedModel.items;
        final hasMore = state.pagedModel.hasMore;
        final isLoading = state.status == const UIStatus.loading();
        final isFailed = state.status is UILoadFailed;
        final errorMessage = state.status.mapOrNull(
          loadFailed: (f) =>
              f.message ?? 'An error occurred. Please try again.',
        );

        if (items.isEmpty && isLoading) {
          return const Center(
            child: PixelLoadingDots(color: AppColors.primary),
          );
        }

        if (items.isEmpty && isFailed) {
          return ErrorPage(
            message:
                (errorMessage ?? 'Failed to load. Please try again.')
                    .toUpperCase(),
            onRetry: () => widget.bloc.add(const ListFetchNextPage()),
          );
        }

        if (items.isEmpty && !hasMore) {
          if (widget.emptyBuilder != null) {
            return widget.emptyBuilder!(context);
          }
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Text(
                (widget.emptyMessage ?? 'No items available.').toUpperCase(),
                style: GoogleFonts.pressStart2p(
                  fontSize: 7,
                  color: subtextColor,
                ),
              ),
            ),
          );
        }

        final listWidget = ListView.separated(
          controller: _scrollController,
          padding:
              widget.padding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: items.length + 1,
          separatorBuilder: (context, index) {
            if (index < items.length - 1 && widget.separatorBuilder != null) {
              return widget.separatorBuilder!(context, index);
            }
            return const SizedBox.shrink();
          },
          itemBuilder: (context, index) {
            if (index < items.length) {
              return widget.itemBuilder(context, items[index]);
            }

            if (isLoading) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Center(
                  child: PixelLoadingDots(color: AppColors.primary),
                ),
              );
            }

            if (isFailed) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: WatButton(
                    label: 'LOAD MORE',
                    width: 140,
                    onPressed: () => widget.bloc.add(const ListFetchNextPage()),
                  ),
                ),
              );
            }

            if (!hasMore) {
              if (widget.noMoreItemsMessage == "") {
                return const SizedBox.shrink();
              }
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Center(
                  child: Text(
                    (widget.noMoreItemsMessage ?? "YOU'VE SEEN EVERYTHING 🎉")
                        .toUpperCase(),
                    style: GoogleFonts.pressStart2p(
                      fontSize: 6,
                      color: subtextColor,
                    ),
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        );

        if (!widget.enablePullToRefresh) {
          return listWidget;
        }

        return RefreshIndicator(
          onRefresh: () async {
            widget.bloc.add(const ListRefresh());
            await widget.bloc.stream.firstWhere(
              (state) => state.status != const UIStatus.loading(),
            );
          },
          child: listWidget,
        );
      },
    );
  }
}
