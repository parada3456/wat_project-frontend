# Implementation Plan: Mission Calendar Tab Fixes

## Overview
We need to fix the mission calendar tab so that:
1. Selecting a date in the calendar successfully filters and updates the list of displayed missions below it to match that selected date.
2. Changing the calendar month updates the calendar view and resets/updates the selected date to the 1st of the new month to keep the list underneath in sync. The calendar highlights should only display missions with deadlines in the currently viewed month.
3. Expose a minimum height configuration (with a default of `200.0` pixels) on the `MissionCardList` widget to ensure empty/loading states occupy a consistent baseline layout height.

## Architecture Decisions
- **`MissionCardList` constructor addition**: Expose a `minHeight` double property in `MissionCardList` and wrap the body with a `ConstrainedBox` utilizing `BoxConstraints(minHeight: minHeight ?? 200.0)`.
- **Month Transition Date Synced**: In `_prevMonth()` and `_nextMonth()`, update `_selectedDate` to the first of the newly selected month so that the list updates.
- **Calendar Data Filtering**: Filter the joined missions passed to the calendar grid and list view based on `_currentMonth` and `_selectedDate`.

## Task List

### Phase 1: MissionCardList Improvements
- [ ] **Task 1: Expose `minHeight` and wrap in `ConstrainedBox`**
  - *Description*: Add an optional `minHeight` parameter to the `MissionCardList` widget and wrap its build output inside a `ConstrainedBox`.
  - *Acceptance*: `MissionCardList` respects `minHeight` or defaults to `200.0` if not specified.
  - *Verification*: Verify layout spacing in widget tree.
  - *Files*: `lib/presentation/missions_tasks/widgets/mission_card_list.dart`
  - *Scope*: S

### Checkpoint: MissionCardList
- [ ] Application builds successfully.

### Phase 2: Calendar Navigation and Filtering
- [ ] **Task 2: Filter Missions by Selected Date on Calendar Tab**
  - *Description*: Pass the filtered missions list (`myMissions` filtered by `_selectedDate`) into `MissionCardList` in `_buildCalendarView`.
  - *Acceptance*: Selecting a day in the calendar updates the list of missions shown underneath.
  - *Verification*: Tap on different calendar days and verify list refreshes.
  - *Files*: `lib/presentation/missions_tasks/screens/missions_dashboard_page.dart`
  - *Scope*: S

- [ ] **Task 3: Synchronize Month Selection with Selected Date & Filter Current Month**
  - *Description*: In `_prevMonth()` and `_nextMonth()`, set `_selectedDate` to the 1st day of the new month. Filter `myMissions` passed to `_buildCalendarCard` to only contain missions for the current month.
  - *Acceptance*: Changing the month automatically selects the 1st of that month and displays the corresponding list. Calendar highlight cells only display current month deadlines.
  - *Verification*: Click month chevrons and verify selected date and highlights update correctly.
  - *Files*: `lib/presentation/missions_tasks/screens/missions_dashboard_page.dart`
  - *Scope*: S

### Checkpoint: Complete Refactor
- [ ] All unit and widget tests pass.
- [ ] `flutter analyze` shows no errors.

## Risks and Mitigations
| Risk | Impact | Mitigation |
|------|--------|------------|
| Clashing keys in `MissionCardList` state recreation | Low | Maintain unique `ValueKey` using both type and selected date values. |
