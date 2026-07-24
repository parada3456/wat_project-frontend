import 'package:wat_project_frontend/domain/models/paged_model.dart';

/// Generic repository contract for fetching paginated data without filter,
/// supporting page, pageSize, and optional limit.
abstract class PaginatedRepository<T> {
  Future<PagedModel<T>> fetch({
    required int page,
    required int pageSize,
    int? limit,
  });
}
