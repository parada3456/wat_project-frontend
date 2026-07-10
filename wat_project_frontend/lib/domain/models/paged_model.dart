class PagedModel<T> {
  final List<T> items;
  final int nextPage;
  final bool hasMore;
  final int pageSize;

  PagedModel({
    required this.items,
    required this.nextPage,
    required this.hasMore,
    required this.pageSize,
  });

  // A factory to easily convert your backend response into UI-friendly state
  factory PagedModel.fromResponse({
    required List<T> updatedItems,
    required int serverCurrentPage,
    required int totalPages,
    required int pageSize,
  }) {
    return PagedModel(
      items: updatedItems,
      nextPage: serverCurrentPage + 1,
      hasMore: serverCurrentPage < totalPages,
      pageSize: pageSize,
    );
  }
}
