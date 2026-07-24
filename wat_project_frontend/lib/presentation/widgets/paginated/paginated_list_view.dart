import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/presentation/widgets/paginated/bloc/paginated_bloc.dart';


class GenericPaginatedListView<T> extends StatefulWidget {
  final ListBloc<T> bloc;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Widget? emptyWidget;
  final Widget? errorWidget;
  final EdgeInsetsGeometry padding;

  const GenericPaginatedListView({
    super.key,
    required this.bloc,
    required this.itemBuilder,
    this.emptyWidget,
    this.errorWidget,
    this.padding = const EdgeInsets.all(8.0),
  });

  @override
  State<GenericPaginatedListView<T>> createState() =>
      _GenericPaginatedListViewState<T>();
}

class _GenericPaginatedListViewState<T>
    extends State<GenericPaginatedListView<T>> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Trigger initial fetch if initial items are empty
    if (widget.bloc.state.pagedModel.items.isEmpty) {
      widget.bloc.add(const ListFetchNextPage());
    }

    // Listener for infinite scroll trigger
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isNearBottom && widget.bloc.state.pagedModel.hasMore) {
      widget.bloc.add(const ListFetchNextPage());
    }
  }

  bool get _isNearBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return currentScroll >= (maxScroll - 200); // Fetch 200px before reaching bottom
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListBloc<T>, ListState<T>>(
      bloc: widget.bloc,
      builder: (context, state) {
        final items = state.pagedModel.items;
        final isLoading = state.status.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );
        final isError = state.status.maybeWhen(
          loadFailed: (message, error) => true,
          orElse: () => false,
        );

        // 1. Initial Loading State
        if (isLoading && items.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        // 2. Initial Error State
        if (isError && items.isEmpty) {
          return RefreshIndicator(
            onRefresh: () async {
              widget.bloc.add(const ListRefresh());
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: widget.errorWidget ??
                    const Center(child: Text('Failed to load data. Tap to pull refresh.')),
              ),
            ),
          );
        }

        // 3. Empty State
        if (items.isEmpty) {
          return RefreshIndicator(
            onRefresh: () async {
              widget.bloc.add(const ListRefresh());
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: widget.emptyWidget ??
                    const Center(child: Text('No data available')),
              ),
            ),
          );
        }

        // 4. Data Loaded State with Infinite Scroll
        return RefreshIndicator(
          onRefresh: () async {
            widget.bloc.add(const ListRefresh());
          },
          child: ListView.builder(
            controller: _scrollController,
            padding: widget.padding,
            itemCount: items.length + (state.pagedModel.hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              // Bottom Loader item
              if (index == items.length) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              return widget.itemBuilder(context, items[index], index);
            },
          ),
        );
      },
    );
  }
}