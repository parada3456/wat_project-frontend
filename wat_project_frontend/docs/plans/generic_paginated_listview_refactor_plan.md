# Implementation Plan: Generic Paginated ListView & Date Formatter Refactoring

## Overview
Refactor date formatting logic from `missions_dashboard_page.dart` into `lib/core/utils/date_formatter.dart` and integrate `GenericPaginatedListView<T>` with `ListBloc<T>` across key list views:
1. `missions_dashboard_page.dart` (both "Explore" and "My Missions" tabs)
2. `home_page.dart`
3. `job_card_list.dart` (job market feed)

---

## Task List

### Phase 1: Date Formatter Extraction & Core Utils
- [x] **Task 1: Extract Date Formatter Utility**
  - **Description**: Create `lib/core/utils/date_formatter.dart` and extract helper functions out of `missions_dashboard_page.dart`.
  - **Acceptance criteria**:
    - [x] `lib/core/utils/date_formatter.dart` created.
    - [x] Inline formatting calls replaced in `missions_dashboard_page.dart`.
  - **Files**: `lib/core/utils/date_formatter.dart`, `lib/presentation/missions_tasks/screens/missions_dashboard_page.dart`

---

### Phase 2: Generic Paginated ListView Implementations
- [x] **Task 2: Implement Generic Paginated ListView in `missions_dashboard_page.dart`**
  - **Description**: Use `ListBloc` + `GenericPaginatedListView` for both "My Missions" and "Explore" tabs.
  - **Acceptance criteria**:
    - [x] Separate `ListBloc` instances for My Missions & Explore.
    - [x] Integrated with `GenericPaginatedListView`.
  - **Files**: `lib/presentation/missions_tasks/screens/missions_dashboard_page.dart`

- [x] **Task 3: Implement Generic Paginated ListView in `home_page.dart`**
  - **Description**: Refactor feed list in `home_page.dart` to use `GenericPaginatedListView`.
  - **Acceptance criteria**:
    - [x] Home feed uses `ListBloc` + `GenericPaginatedListView`.
  - **Files**: `lib/presentation/home/screens/home_page.dart`

- [x] **Task 4: Implement Generic Paginated ListView in `job_card_list.dart`**
  - **Description**: Refactor job list component to use `GenericPaginatedListView`.
  - **Acceptance criteria**:
    - [x] Job card list uses `ListBloc` + `GenericPaginatedListView`.
  - **Files**: `lib/presentation/job_market/widgets/job_card_list.dart`

---

### Phase 3: Final Verification & Plan Updates
- [x] **Task 5: Verify & Update Plan in `docs/plans/`**
  - **Description**: Run tests and static analysis, then update tasks as completed.
  - **Acceptance criteria**:
    - [x] `flutter analyze` clean.
    - [x] All checkmarks completed in plan.
