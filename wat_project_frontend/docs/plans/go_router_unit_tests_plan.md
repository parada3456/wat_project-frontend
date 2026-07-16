# Plan: GoRouter Configuration Unit/Widget Testing

## Objective
Establish unit/widget tests for all GoRouter routes defined in `lib/routes/app_router.dart` and ensure they load their target page widgets correctly.

## Implementation Steps

### Phase 1: Create Mock Classes
Create mocks for the following classes inside `test/app_router_test.dart`:
- `AuthSessionManager` using `Mock` from `mocktail`
- `ListJourneyPhasesUseCase` using `Mock` from `mocktail`
- Blocs using `MockBloc` from `bloc_test` and implementing the respective Bloc class:
  - `LoginBloc`
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

### Phase 2: Stub Default States
For all mock Blocs, stub their `state` and `stream` methods:
- `when(() => mockLoginBloc.state).thenReturn(const LoginState())`
- `when(() => mockLoginBloc.stream).thenAnswer((_) => const Stream.empty())`
Ensure that we stub all required states with initial/idle status to prevent build crashes.

### Phase 3: Setup GetIt DI in Tests
In `setUp()`, we will:
1. Reset GetIt: `getIt.reset()`
2. Register the mock Blocs and UseCases so they can be retrieved by widgets:
   - `getIt.registerFactory<LoginBloc>(() => mockLoginBloc)`
   - `getIt.registerFactory<ProfileBloc>(() => mockProfileBloc)`
   - `getIt.registerFactory<HomeBloc>(() => mockHomeBloc)`
   - `getIt.registerFactory<JourneyGamificationBloc>(() => mockJourneyGamificationBloc)`
   - `getIt.registerFactory<ExpenseSharingBloc>(() => mockExpenseSharingBloc)`
   - `getIt.registerFactory<JobMarketBloc>(() => mockJobMarketBloc)`
   - `getIt.registerFactory<MissionTaskBloc>(() => mockMissionTaskBloc)`
   - `getIt.registerFactory<CreateMissionBloc>(() => mockCreateMissionBloc)`
   - `getIt.registerFactory<NotificationsBloc>(() => mockNotificationsBloc)`
   - `getIt.registerFactory<SocialRadarBloc>(() => mockSocialRadarBloc)`
   - `getIt.registerFactory<AdminDashboardBloc>(() => mockAdminDashboardBloc)`
   - `getIt.registerFactory<ListJourneyPhasesUseCase>(() => mockListJourneyPhasesUseCase)`

### Phase 4: Create Router Helper
Define a helper function to build the router instance using a mock `AuthSessionManager` and returning a `MaterialApp.router` with the router Config. We also need to mock `authSessionManager.sessionNotifier` and `authSessionManager.currentSession`.

### Phase 5: Write Route Verification Tests
For each route path:
1. Navigate using `router.go(path)`.
2. Call `tester.pumpAndSettle()`.
3. Assert that the specific page widget or key element corresponding to that route path is present in the widget tree.

### Phase 6: Run Tests and Validate
Run `flutter test test/app_router_test.dart` and fix any failures or routing issues.
