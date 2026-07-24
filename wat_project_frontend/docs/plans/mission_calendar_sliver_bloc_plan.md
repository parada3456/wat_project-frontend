# Implementation Plan: Mission Calendar Sliver & BLoC Refactor

## Overview
We need to refactor the Mission Calendar feature to:
1. Convert the page structure to use a `CustomScrollView` utilizing a `SliverAppBar` and other sliver components (like `SliverPadding`, `SliverList`, and `SliverToBoxAdapter`) for maximum layout flexibility and scrolling integration.
2. Design and implement a new `CalendarBloc` that manages the selected date and focused month states, replacing manual setState or static values in the calendar view and widgets.
3. Connect the calendar's header and grid navigation (chevrons and day selections) directly to `CalendarBloc` events, supporting dynamic monthly grid calculation instead of hardcoding June 2026.
4. Ensure all project tests compile and write new unit/widget tests for the newly created Bloc and refactored UI.

## Architecture Decisions
- **`CalendarBloc` Placement**: Since this Bloc is specific to calendar state management, we will place it under `lib/presentation/missions_tasks/bloc/calendar_bloc.dart`.
- **Local BLoC Provider**: We will inject `CalendarBloc` locally inside `MissionCalendarPage` using a `MultiBlocProvider` along with `MissionTaskBloc`, ensuring scope isolation.
- **Sliver Grid & List**: The page will scroll uniformly as a single viewport using a `CustomScrollView` containing a `SliverAppBar` (which embeds the `MissionCalendar` in its `flexibleSpace` background with an expanded height of ~400.0), and a dynamic list of `MissionCard`s underneath as a `SliverList` or `SliverPadding` to prevent nested scroll views.
- **Accurate Calendar Calculations**: Implement standard monthly grid math (using month/year offsets and lengths) so the calendar works for any month, not just June 2026.

## Task List

### Phase 1: BLoC Implementation
- [ ] **Task 1: Create `CalendarBloc` and its State/Events**
  - *Description*: Create the events (`PreviousMonthRequested`, `NextMonthRequested`, `DateSelected`), the state (`CalendarState` holding `focusedMonth` and `selectedDate`), and the bloc class `CalendarBloc` using `equatable` for props.
  - *Acceptance*: `CalendarBloc` class is defined and compiles.
  - *Verification*: Write and run isolated bloc tests.
  - *Files*: `lib/presentation/missions_tasks/bloc/calendar_bloc.dart`
  - *Scope*: S

### Phase 2: Widget Refactoring
- [ ] **Task 2: Refactor `MissionCalendar` Widget**
  - *Description*: Convert `MissionCalendar` to read month and date values from `CalendarBloc` instead of hardcoding June 2026. Calculate the actual number of days in the month and weekday starting offsets for the grid. Add header weekdays (`Su`, `Mo`, etc.) and connect chevrons and day cells to the Bloc.
  - *Acceptance*: Calendar updates dynamically on chevron clicks and displays weekday aligned grids.
  - *Verification*: Verify layout and interactions in widget tests.
  - *Files*: `lib/presentation/missions_tasks/widgets/mission_calendar.dart`
  - *Scope*: M

- [ ] **Task 3: Refactor `MissionCalendarPage` to use CustomScrollView and Silvers**
  - *Description*: Replace the standard scaffold layout in `MissionCalendarPage` with a `CustomScrollView` containing `SliverAppBar` and other sliver components. Provide `CalendarBloc` and `MissionTaskBloc` in a `MultiBlocProvider`. Filter displayed deadlines based on `CalendarBloc`'s `focusedMonth`.
  - *Acceptance*: Entire page scrolls smoothly using sliver layout and updates based on the selected month/date.
  - *Verification*: Confirm smooth layout rendering and correct deadline filtering.
  - *Files*: `lib/presentation/missions_tasks/screens/mission_calendar_page.dart`
  - *Scope*: M

### Phase 3: Testing & Verification
- [ ] **Task 4: Create Unit & Widget Tests for Calendar**
  - *Description*: Write tests in `test/mission_calendar_test.dart` to verify `CalendarBloc` transitions and `MissionCalendarPage` rendering structure.
  - *Acceptance*: All new calendar-focused tests compile and pass.
  - *Verification*: Run `flutter test test/mission_calendar_test.dart`.
  - *Files*: `test/mission_calendar_test.dart`
  - *Scope*: S

- [ ] **Task 5: Run Code Verification**
  - *Description*: Run formatter, analyzer, and the full test suite.
  - *Acceptance*: All verification commands run successfully with zero errors.
  - *Verification*: Run `dart format`, `flutter analyze`, and `flutter test`.
  - *Files*: None
  - *Scope*: XS

## Risks and Mitigations
| Risk | Impact | Mitigation |
|------|--------|------------|
| Inaccurate grid count / offsets leading to UI layout errors or grid overflow | Medium | Write unit tests checking date math and first weekday offset calculation for a variety of months. |
| Sliver scroll physics conflicting with RefreshIndicator | Low | Set `physics: const AlwaysScrollableScrollPhysics()` on `CustomScrollView` to guarantee standard drag behavior. |
