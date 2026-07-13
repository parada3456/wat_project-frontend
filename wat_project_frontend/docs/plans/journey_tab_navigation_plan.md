# Implementation Plan: Journey Navigation Tab

## Overview
We need to add a "Journey" tab to the bottom navigation bar of the application. The Journey tab's main page will be `JourneyTimelinePage`, which will display a TabBar with three sub-views: Timeline, Leaderboard, and Badges.

## Architecture Decisions
- **`GoRouter` Shell Routing**: Move the `/journey` route inside the `ShellRoute` in `AppRouter` so that it renders with the bottom navigation bar.
- **Bottom Navigation State Mapping**:
  - Update `CustomBottomNavBar` to display 5 items (Home, Journey, Expenses, Jobs, Profile).
  - Update `MainShellPage` to correctly resolve the index (0 to 4) based on matching routes and handle the transitions.
- **Unified Journey Tabs**: Refactor `JourneyTimelinePage` from a stateless single-list view into a tabbed layout (`Timeline`, `Leaderboard`, `Badges`) leveraging `DefaultTabController` and reusing the existing row/tile widgets from the journey widgets folder.

## Task List

### Phase 1: Navigation Configuration
- [ ] **Task 1: Add Journey to ShellRoute in AppRouter**
  - *Description*: Relocate the `/journey` GoRoute inside the `ShellRoute` block and remove the duplicate standalone route definition.
  - *Acceptance*: Route `/journey` resolves inside the shell layout.
  - *Files*: `lib/routes/app_router.dart`
  - *Scope*: XS

- [ ] **Task 2: Update CustomBottomNavBar & MainShellPage**
  - *Description*: Add "Journey" tab item with map/timeline icon. Update index mapping in shell page.
  - *Acceptance*: Clicking the Journey icon navigates to `/journey` and highlights the tab correctly.
  - *Files*:
    - `lib/presentation/navigation/widgets/custom_bottom_nav_bar.dart`
    - `lib/presentation/navigation/screens/main_shell_page.dart`
  - *Scope*: S

### Phase 2: Journey Tabbed Layout
- [ ] **Task 3: Refactor JourneyTimelinePage with Sub-Tabs**
  - *Description*: Wrap the scaffold in a `DefaultTabController` with three tabs: Timeline, Leaderboard, and Badges. Pull the leaderboard row and badge grid tile widgets into the corresponding tab views.
  - *Acceptance*: Journey page has functional tabs for Timeline, Leaderboard, and Badges.
  - *Files*: `lib/presentation/journey_gamification/screens/journey_timeline_page.dart`
  - *Scope*: S

### Checkpoint: Complete Verification
- [ ] Run static analysis (`flutter analyze`).
- [ ] Run tests (`flutter test`) to verify compilation and baseline logic.

## Risks and Mitigations
None identified.
