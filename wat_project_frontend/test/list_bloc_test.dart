import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:wat_project_frontend/domain/models/paged_model.dart';
import 'package:wat_project_frontend/presentation/widgets/paginated/bloc/paginated_bloc.dart';

void main() {
  group('ListBloc Pagination Tests', () {
    late List<Map<String, int>> fetchCalls;

    setUp(() {
      fetchCalls = [];
    });

    Future<PagedModel<String>> mockFetchCallback(int page, int pageSize) async {
      fetchCalls.add({'page': page, 'pageSize': pageSize});
      return PagedModel(
        items: List.generate(pageSize, (index) => 'Item ${page}_$index'),
        nextPage: page + 1,
        hasMore: page < 3,
        pageSize: pageSize,
      );
    }

    blocTest<ListBloc<String>, ListState<String>>(
      'uses state-derived nextPage and pageSize when ListFetchNextPage parameters are omitted',
      build: () =>
          ListBloc<String>(fetchCallback: mockFetchCallback, pageSize: 15),
      act: (bloc) => bloc.add(const ListFetchNextPage()),
      verify: (_) {
        expect(fetchCalls, hasLength(1));
        expect(fetchCalls.first, {'page': 1, 'pageSize': 15});
      },
    );

    blocTest<ListBloc<String>, ListState<String>>(
      'uses event-specified page and pageSize when provided in ListFetchNextPage',
      build: () =>
          ListBloc<String>(fetchCallback: mockFetchCallback, pageSize: 15),
      act: (bloc) => bloc.add(const ListFetchNextPage(page: 5, pageSize: 30)),
      verify: (_) {
        expect(fetchCalls, hasLength(1));
        expect(fetchCalls.first, {'page': 5, 'pageSize': 30});
      },
    );

    blocTest<ListBloc<String>, ListState<String>>(
      'uses event-specified pageSize when provided in ListRefresh',
      build: () =>
          ListBloc<String>(fetchCallback: mockFetchCallback, pageSize: 10),
      act: (bloc) => bloc.add(const ListRefresh(pageSize: 25)),
      verify: (_) {
        // Refresh triggers ListFetchNextPage with the custom pageSize
        expect(fetchCalls, hasLength(1));
        expect(fetchCalls.first, {'page': 1, 'pageSize': 25});
      },
    );
  });
}
