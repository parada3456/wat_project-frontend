
part of 'paginated_bloc.dart';

abstract class ListEvent {
  const ListEvent();
}

class ListFetchNextPage extends ListEvent {
  final int? page;
  final int? pageSize;
  const ListFetchNextPage({this.page, this.pageSize});
}

class ListRefresh extends ListEvent {
  final int? pageSize;
  const ListRefresh({this.pageSize});
}

class ListResetItems<T> extends ListEvent {
  final List<T> items;
  final bool hasMore;
  const ListResetItems(this.items, {this.hasMore = false});
}