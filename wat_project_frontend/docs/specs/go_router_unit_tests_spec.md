# Spec: GoRouter Configuration Unit/Widget Testing

## Objective
The goal is to write a comprehensive test suite (`test/app_router_test.dart`) to test all routing configurations in `AppRouter` (`lib/routes/app_router.dart`). The test suite will verify:
1. Every defined path in `AppRouter` resolves correctly and matches the expected widget/screen.
2. The router navigates to the login page as the initial location.
3. Path parameters and query parameters are parsed and passed to the screen widgets correctly.
4. Mocks are registered in `GetIt` for all Blocs and UseCases instantiated by the routed widgets so they do not crash during navigation testing.

## Tech Stack
- Flutter & Dart
- Routing: `go_router`
- DI: `get_it`
- Mocking: `mocktail`, `bloc_test`

## Commands
- Run all tests: `flutter test`
- Run routing tests: `flutter test test/app_router_test.dart`
- Analyze code: `flutter analyze`

## Project Structure
We will add a new test file:
```
test/
  app_router_test.dart       # New: Widget and unit tests for AppRouter
```

## Testing Strategy
1. **Mock Dependencies**:
   Create mock classes using `mocktail` and `bloc_test` for:
   - `AuthSessionManager`
   - `LoginBloc`
   - `ListJourneyPhasesUseCase`
   - `ProfileBloc`
   - `HomeBloc`
   - `JourneyGamificationBloc`
   - `ExpenseSharingBloc`
   - `JobMarketBloc`
   - `MissionTaskBloc`
   - `CreateMissionBloc`
   - `NotificationsBloc`
   - `SocialRadarBloc`
   - `AdminDashboardBloc`

2. **Test Setup**:
   In `setUp()`, reset `GetIt` using `getIt.reset()` and register the mocked Blocs and dependencies. This ensures that the widget build methods do not throw `GetIt` resolution errors.

3. **Routing Scenarios**:
   - Initial location: Verify that the router lands on `/login`.
   - Top-level routes: `/login`, `/register`, `/settings`, `/leaderboard`, `/badges`, `/credit-history`, `/friends`, `/friend-requests`, `/radar`, `/expenses/new`, `/notifications`, `/admin`, `/jobs/cart`.
   - Shell routes: `/home`, `/journey`, `/expenses`, `/jobs`, `/profile`.
   - Parametric routes: `/expenses/:id`, `/expenses/:id/pay`, `/jobs/:id`, `/jobs/:id/reviews/new`, `/missions/detail`, `/jobs/compare`.

4. **Verifications**:
   Verify that navigating to the path (e.g. `router.go(path)`) compiles, settles, and correctly displays the respective screen widget in the tree.

## Success Criteria
- [ ] `test/app_router_test.dart` created with full coverage of the routes.
- [ ] All routes resolve to their respective page widgets without throwing errors.
- [ ] `flutter test test/app_router_test.dart` runs and passes successfully.
- [ ] Code has no analyze errors or warnings.
