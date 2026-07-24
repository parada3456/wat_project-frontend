# Implementation Plan: ListBloc Pagination Parameters

## Overview
We need to enhance `ListBloc` and its fetch/refresh events to support optional `page` and `pageSize` parameters, allowing callers to override internal state values when querying pagination data. We will also add unit tests to verify the correctness of the changes.

## Architecture Decisions
- **Immutable State-fallback**: If parameters are omitted from events, `ListBloc` continues to resolve `page` and `pageSize` from the current state's `pagedModel` (backward compatible).
- **Separate Unit Testing**: We will write unit tests using `flutter_test` and `bloc_test` inside `test/list_bloc_test.dart` to comprehensively test the various event payload scenarios.

## Task List

### Phase 1: Implementation
- [ ] **Task 1: Update Events in `list_bloc.dart`**
  - *Description*: Update `ListFetchNextPage` and `ListRefresh` to accept optional `page` and/or `pageSize` arguments in their constructors.
  - *Acceptance*: Code compiles, constructors exist.
  - *Files*: `lib/presentation/widgets/list_bloc.dart`
  - *Scope*: XS

- [ ] **Task 2: Update BLoC Event Handlers**
  - *Description*: Update `_onFetchNextPage` and `_onRefresh` in `ListBloc` to retrieve and use `page` and `pageSize` parameters from incoming events if provided.
  - *Acceptance*: Event-specified parameters are forwarded to `fetchCallback` instead of state-derived defaults.
  - *Files*: `lib/presentation/widgets/list_bloc.dart`
  - *Scope*: S

### Phase 2: Testing & Verification
- [ ] **Task 3: Create Unit Tests for ListBloc**
  - *Description*: Create `test/list_bloc_test.dart` to verify that when parameters are passed in the events, they are correctly forwarded to the callback. Also verify default fallback behavior when parameters are absent.
  - *Acceptance*: Run `flutter test test/list_bloc_test.dart` and see all tests pass.
  - *Files*: `test/list_bloc_test.dart`
  - *Scope*: S

- [ ] **Task 4: Run Code Verification**
  - *Description*: Run format, static analysis, and full test suite to guarantee zero regressions.
  - *Acceptance*: `flutter analyze`, `dart format`, and `flutter test` are all green.
  - *Files*: None
  - *Scope*: XS

## Risks and Mitigations
- **Risk**: Breaking compilation of existing usages.
- **Mitigation**: Keep event parameter constructors optional (`{this.page, this.pageSize}`) with no required inputs. Ensure defaults are fully backward-compatible.
