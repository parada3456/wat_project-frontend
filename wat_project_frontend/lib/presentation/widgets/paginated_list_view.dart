import 'package:flutter/material.dart';
import 'package:wat_project_frontend/domain/models/paged_model.dart';
import 'package:wat_project_frontend/presentation/widgets/paginated/bloc/paginated_bloc.dart';
import 'package:wat_project_frontend/presentation/widgets/paginated/paginated_list_view.dart';

export 'package:wat_project_frontend/presentation/widgets/paginated/bloc/paginated_bloc.dart';
export 'package:wat_project_frontend/presentation/widgets/paginated/paginated_list_view.dart';

typedef FetchPageCallback<T> = Future<PagedModel<T>> Function(int page, int pageSize);

class PaginatedListView<T> extends StatefulWidget {
  final FetchPageCallback<T> fetchPage;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final int pageSize;
  final int? limit;
  final EdgeInsetsGeometry? padding;
  final String? emptyMessage;
  final Widget Function(BuildContext context, int index)? separatorBuilder;
  final List<T>? initialItems;

  const PaginatedListView({
    super.key,
    required this.fetchPage,
    required this.itemBuilder,
    this.pageSize = 20,
    this.limit,
    this.padding,
    this.emptyMessage,
    this.separatorBuilder,
    this.initialItems,
  });

  @override
  State<PaginatedListView<T>> createState() => _PaginatedListViewState<T>();
}

class _PaginatedListViewState<T> extends State<PaginatedListView<T>> {
  late final ListBloc<T> _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = ListBloc<T>(
      pageSize: widget.pageSize,
      initialItems: widget.initialItems,
      fetchCallback: widget.fetchPage,
    );
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GenericPaginatedListView<T>(
      bloc: _bloc,
      padding: widget.padding ?? const EdgeInsets.all(8.0),
      emptyWidget: widget.emptyMessage != null
          ? Center(child: Text(widget.emptyMessage!))
          : null,
      itemBuilder: (context, item, index) {
        if (widget.limit != null && index >= widget.limit!) {
          return const SizedBox.shrink();
        }
        final child = widget.itemBuilder(context, item);
        if (widget.separatorBuilder != null) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              child,
              widget.separatorBuilder!(context, index),
            ],
          );
        }
        return child;
      },
    );
  }
}
