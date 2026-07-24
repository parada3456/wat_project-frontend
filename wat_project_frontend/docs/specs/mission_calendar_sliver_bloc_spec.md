# Spec: Mission Calendar Sliver & BLoC Refactor

## Objective
The mission calendar page needs to be upgraded for improved scrolling dynamics and dynamic state handling.
Specifically, we want to:
1. Replace the standard layout of `MissionCalendarPage` with a sliver-based scroll layout using `CustomScrollView` and `SliverAppBar` so the app bar and page contents scroll together beautifully.
2. Introduce a dedicated `CalendarBloc` to manage selected dates and month views, removing hardcoded logic and static calendar displays.
3. Update `MissionCalendar` to render dynamic days, align them to weekdays correctly, and update when the month or date changes.

## Tech Stack
- Frontend: Flutter & Dart
- State Management: `flutter_bloc`, `equatable`

## Commands
- Run all tests: `flutter test`
- Run specific test file: `flutter test test/mission_calendar_test.dart`
- Format code: `dart format lib/ test/`
- Analyze code: `flutter analyze`

## Project Structure
We will add/modify files in the following structure:
```
lib/
  presentation/
    missions_tasks/
      bloc/
        calendar_bloc.dart   # New: CalendarBloc (state, events, and bloc class)
      screens/
        mission_calendar_page.dart # Modify: Refactor page to CustomScrollView & Sliver layout
      widgets/
        mission_calendar.dart # Modify: Make dynamic, weekday-aligned and bind to CalendarBloc
test/
  mission_calendar_test.dart  # New: Unit tests for CalendarBloc and widget tests for calendar page
```

## Code Style
Here is a snippet showing how `MissionCalendarPage`'s sliver layout will be structured:

```dart
CustomScrollView(
  slivers: [
    SliverAppBar(
      pinned: true,
      expandedHeight: 400.0,
      backgroundColor: AppColors.background,
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 56.0), // Below title bar
            child: MissionCalendar(missions: taskState.missions),
          ),
        ),
      ),
      title: const Text('Mission Calendar'),
    ),
    SliverPadding(
      padding: const EdgeInsets.all(AppDimension.space16),
      sliver: SliverList(
        delegate: SliverChildListList([
          const Text(
            'Deadlines this month',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppDimension.space16),
        ]),
      ),
    ),
    // Sliver list of mission cards...
  ],
)
```

## Testing Strategy
- Unit tests for `CalendarBloc` to ensure state correctly transitions when month chevrons or dates are clicked.
- Widget tests to verify:
  1. `MissionCalendarPage` uses a `CustomScrollView` and a `SliverAppBar`.
  2. The `SliverAppBar` has an expanded height to accommodate the calendar.
- Verification location: `test/mission_calendar_test.dart`.

## Boundaries
- **Always**: Use the existing theme's `AppColors` and `AppDimension` for styling and margins.
- **Ask first**: Adding new external packages for calendars (e.g., table_calendar). We should implement a lightweight custom calendar widget directly.
- **Never**: Hardcode specific months (like June 2026) in the calendar calculations.

## Success Criteria
- [ ] `CalendarBloc` class created and successfully manages changing month/year and selecting dates.
- [ ] `MissionCalendarPage` converted to use `CustomScrollView` containing `SliverAppBar`, `SliverPadding`, `SliverList`, and `SliverToBoxAdapter` blocks.
- [ ] `MissionCalendar` dynamically renders weekdays row and day cells correctly mapped to the calendar month grid (with correct day offsets).
- [ ] Unit and widget tests written in `test/mission_calendar_test.dart` and pass 100% green.
- [ ] No static analysis errors or warnings are introduced in the modified files.
