# Spec: ListBloc Pagination Parameters

## Objective
We want to allow `ListBloc` and its associated fetch/refresh events to optionally accept `page` and `pageSize` parameters. This allows callers or widgets to explicitly specify pagination constraints when triggering a fetch or refresh operation, rather than relying solely on the internal state values.

## Tech Stack
- Frontend: Flutter & Dart
- State Management: `flutter_bloc`

## Commands
- Run all tests: `flutter test`
- Run list bloc tests: `flutter test test/list_bloc_test.dart`
- Format code: `dart format lib/ test/`
- Analyze code: `flutter analyze`

## Project Structure
We will add/modify files in the following structure:
```
lib/
  presentation/
    widgets/
      list_bloc.dart         # Modify: Add page & pageSize to events and handle them in Bloc
test/
  list_bloc_test.dart        # New: Unit tests for ListBloc pagination logic
```

## Code Style
Here is a snippet showing how `ListFetchNextPage` and `ListRefresh` events will be defined and processed:

```dart
class ListFetchNextPage extends ListEvent {
  final int? page;
  final int? pageSize;
  const ListFetchNextPage({this.page, this.pageSize});
}

class ListRefresh extends ListEvent {
  final int? pageSize;
  const ListRefresh({this.pageSize});
}
```

And how they will be handled in `ListBloc`:
```dart
  Future<void> _onFetchNextPage(
    ListFetchNextPage event,
    Emitter<ListState<T>> emit,
  ) async {
    if (state.status == const UIStatus.loading() || !state.pagedModel.hasMore) {
      return;
    }

    emit(state.copyWith(status: const UIStatus.loading()));

    try {
      final nextPage = event.page ?? state.pagedModel.nextPage;
      final pageSize = event.pageSize ?? state.pagedModel.pageSize;
      final response = await fetchCallback(nextPage, pageSize);
      // ...
```

## Testing Strategy
We will write a new test suite at `test/list_bloc_test.dart` using the `bloc_test` package (if available, or standard `flutter_test` streams) to verify:
1. `ListFetchNextPage` with default/no parameters uses state-derived `nextPage` and `pageSize`.
2. `ListFetchNextPage` with custom `page` and `pageSize` passes those exact parameters to `fetchCallback`.
3. `ListRefresh` with custom `pageSize` correctly resets the list and triggers a fetch using the new `pageSize`.

## Boundaries
- **Always**: Follow the existing coding standards and clean architecture of the project.
- **Ask first**: Making changes to other Bloc features or core widgets.
- **Never**: Break backward compatibility for existing `ListBloc` usages (like in `mission_card_list.dart`).

## Success Criteria
- [ ] `ListFetchNextPage` modified to accept optional `page` and `pageSize` parameters.
- [ ] `ListRefresh` modified to accept optional `pageSize` parameter.
- [ ] `ListBloc` handles these parameters in `_onFetchNextPage` and `_onRefresh`.
- [ ] A new test suite `test/list_bloc_test.dart` is added and passes 100% of the checks.
- [ ] Existing usages in `mission_card_list.dart` continue to compile and work perfectly without changes.
- [ ] All project tests pass successfully.
