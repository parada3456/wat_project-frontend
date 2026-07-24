import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:dartz/dartz.dart';

import 'package:wat_project_frontend/routes/app_router.dart';
import 'package:wat_project_frontend/domain/services/auth_manager.dart';
import 'package:wat_project_frontend/domain/usecases/journey/list_journey_phases_usecase.dart';
import 'package:wat_project_frontend/domain/providers/locale_provider.dart';
import 'package:wat_project_frontend/domain/providers/theme_provider.dart';
import 'package:wat_project_frontend/domain/models/auth_models.dart';
import 'package:wat_project_frontend/domain/repositories/user_repository.dart';
import 'package:wat_project_frontend/domain/repositories/mission_repository.dart';

import 'package:wat_project_frontend/presentation/auth_profile/login/bloc/login_bloc.dart';
import 'package:wat_project_frontend/presentation/auth_profile/profile/bloc/profile_bloc.dart';
import 'package:wat_project_frontend/presentation/home/bloc/home_bloc.dart';
import 'package:wat_project_frontend/presentation/journey_gamification/bloc/journey_gamification_bloc.dart';
import 'package:wat_project_frontend/presentation/journey_gamification/bloc/journey_gamification_event.dart';
import 'package:wat_project_frontend/presentation/journey_gamification/bloc/journey_gamification_state.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/bloc/expense_sharing_bloc.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/bloc/expense_sharing_event.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/bloc/expense_sharing_state.dart';
import 'package:wat_project_frontend/presentation/job_market/bloc/job_market_bloc.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/bloc/create_mission_bloc.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/bloc/mission_task_bloc.dart';
import 'package:wat_project_frontend/presentation/notifications/bloc/notifications_bloc.dart';
import 'package:wat_project_frontend/presentation/notifications/bloc/notifications_event.dart';
import 'package:wat_project_frontend/presentation/notifications/bloc/notifications_state.dart';
import 'package:wat_project_frontend/presentation/social_radar/bloc/social_radar_bloc.dart';
import 'package:wat_project_frontend/presentation/social_radar/bloc/social_radar_event.dart';
import 'package:wat_project_frontend/presentation/social_radar/bloc/social_radar_state.dart';
import 'package:wat_project_frontend/presentation/admin_dashboard/bloc/admin_dashboard_bloc.dart';
import 'package:wat_project_frontend/presentation/admin_dashboard/bloc/admin_dashboard_event.dart';
import 'package:wat_project_frontend/presentation/admin_dashboard/bloc/admin_dashboard_state.dart';

import 'package:wat_project_frontend/presentation/auth_profile/login/ui/login_page.dart';
import 'package:wat_project_frontend/presentation/auth_profile/login/ui/register_page.dart';
import 'package:wat_project_frontend/presentation/auth_profile/profile/ui/edit_profile_page.dart';
import 'package:wat_project_frontend/presentation/auth_profile/profile/ui/profile_page.dart';
import 'package:wat_project_frontend/presentation/auth_profile/screens/user_settings_page.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/screens/create_expense_page.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/screens/expense_details_page.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/screens/expense_history_page.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/screens/payment_submission_page.dart';
import 'package:wat_project_frontend/presentation/home/screens/home_page.dart';
import 'package:wat_project_frontend/presentation/home/screens/temp_test_screen.dart';
import 'package:wat_project_frontend/presentation/job_market/screens/job_cart_page.dart';
import 'package:wat_project_frontend/presentation/job_market/screens/job_compare_page.dart';
import 'package:wat_project_frontend/presentation/job_market/screens/job_details_page.dart';
import 'package:wat_project_frontend/presentation/job_market/screens/job_search_page.dart';
import 'package:wat_project_frontend/presentation/job_market/screens/write_review_page.dart';
import 'package:wat_project_frontend/presentation/journey_gamification/screens/badges_page.dart';
import 'package:wat_project_frontend/presentation/journey_gamification/screens/credit_history_page.dart';
import 'package:wat_project_frontend/presentation/journey_gamification/screens/journey_timeline_page.dart';
import 'package:wat_project_frontend/presentation/journey_gamification/screens/leaderboard_page.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/screens/mission_calendar_page.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/screens/mission_detail_page.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/screens/missions_dashboard_page.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/screens/missions_search_page.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/screens/create_mission_page.dart';
import 'package:wat_project_frontend/presentation/notifications/screens/notification_center_page.dart';
import 'package:wat_project_frontend/presentation/social_radar/screens/friend_requests_page.dart';
import 'package:wat_project_frontend/presentation/social_radar/screens/friends_list_page.dart';
import 'package:wat_project_frontend/presentation/social_radar/screens/radar_map_page.dart';
import 'package:wat_project_frontend/presentation/admin_dashboard/screens/admin_dashboard_page.dart';

// Mocks
class MockAuthSessionManager extends Mock implements AuthSessionManager {}

class MockListJourneyPhasesUseCase extends Mock
    implements ListJourneyPhasesUseCase {}

class MockUserRepository extends Mock implements UserRepository {}

class MockMissionRepository extends Mock implements MissionRepository {}

class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
    implements LoginBloc {}

class MockProfileBloc extends MockBloc<ProfileEvent, ProfileState>
    implements ProfileBloc {}

class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

class MockJourneyGamificationBloc
    extends MockBloc<JourneyGamificationEvent, JourneyGamificationState>
    implements JourneyGamificationBloc {}

class MockExpenseSharingBloc
    extends MockBloc<ExpenseSharingEvent, ExpenseSharingState>
    implements ExpenseSharingBloc {}

class MockJobMarketBloc extends MockBloc<JobMarketEvent, JobMarketState>
    implements JobMarketBloc {}

class MockMissionTaskBloc extends MockBloc<MissionTaskEvent, MissionTaskState>
    implements MissionTaskBloc {}

class MockCreateMissionBloc
    extends MockBloc<CreateMissionEvent, CreateMissionState>
    implements CreateMissionBloc {}

class MockNotificationsBloc
    extends MockBloc<NotificationsEvent, NotificationsState>
    implements NotificationsBloc {}

class MockSocialRadarBloc extends MockBloc<SocialRadarEvent, SocialRadarState>
    implements SocialRadarBloc {}

class MockAdminDashboardBloc
    extends MockBloc<AdminDashboardEvent, AdminDashboardState>
    implements AdminDashboardBloc {}

final getIt = GetIt.instance;

void main() {
  late MockAuthSessionManager mockAuthManager;
  late MockListJourneyPhasesUseCase mockListJourneyPhasesUseCase;
  late MockUserRepository mockUserRepository;
  late MockMissionRepository mockMissionRepository;
  late MockLoginBloc mockLoginBloc;
  late MockProfileBloc mockProfileBloc;
  late MockHomeBloc mockHomeBloc;
  late MockJourneyGamificationBloc mockJourneyGamificationBloc;
  late MockExpenseSharingBloc mockExpenseSharingBloc;
  late MockJobMarketBloc mockJobMarketBloc;
  late MockMissionTaskBloc mockMissionTaskBloc;
  late MockCreateMissionBloc mockCreateMissionBloc;
  late MockNotificationsBloc mockNotificationsBloc;
  late MockSocialRadarBloc mockSocialRadarBloc;
  late MockAdminDashboardBloc mockAdminDashboardBloc;

  setUp(() {
    mockAuthManager = MockAuthSessionManager();
    mockListJourneyPhasesUseCase = MockListJourneyPhasesUseCase();
    mockUserRepository = MockUserRepository();
    mockMissionRepository = MockMissionRepository();
    mockLoginBloc = MockLoginBloc();
    mockProfileBloc = MockProfileBloc();
    mockHomeBloc = MockHomeBloc();
    mockJourneyGamificationBloc = MockJourneyGamificationBloc();
    mockExpenseSharingBloc = MockExpenseSharingBloc();
    mockJobMarketBloc = MockJobMarketBloc();
    mockMissionTaskBloc = MockMissionTaskBloc();
    mockCreateMissionBloc = MockCreateMissionBloc();
    mockNotificationsBloc = MockNotificationsBloc();
    mockSocialRadarBloc = MockSocialRadarBloc();
    mockAdminDashboardBloc = MockAdminDashboardBloc();

    // Stub sessionNotifier and currentSession for AuthSessionManager
    final sessionNotifier = ValueNotifier<AuthModel?>(null);
    when(() => mockAuthManager.sessionNotifier).thenReturn(sessionNotifier);
    when(() => mockAuthManager.currentSession).thenReturn(null);
    when(() => mockAuthManager.userId).thenReturn('usr_123');
    when(() => mockAuthManager.isAdmin).thenReturn(false);

    // Stub UserRepository and MissionRepository
    when(
      () => mockUserRepository.getMe(),
    ).thenThrow(Exception('Not logged in / test'));

    // Stub Blocs initial states
    when(() => mockLoginBloc.state).thenReturn(const LoginState());
    when(() => mockLoginBloc.stream).thenAnswer((_) => const Stream.empty());

    when(() => mockProfileBloc.state).thenReturn(const ProfileState());
    when(() => mockProfileBloc.stream).thenAnswer((_) => const Stream.empty());

    when(() => mockHomeBloc.state).thenReturn(const HomeState());
    when(() => mockHomeBloc.stream).thenAnswer((_) => const Stream.empty());

    when(
      () => mockJourneyGamificationBloc.state,
    ).thenReturn(const JourneyGamificationState.initial());
    when(
      () => mockJourneyGamificationBloc.stream,
    ).thenAnswer((_) => const Stream.empty());

    when(
      () => mockExpenseSharingBloc.state,
    ).thenReturn(const ExpenseSharingState.initial());
    when(
      () => mockExpenseSharingBloc.stream,
    ).thenAnswer((_) => const Stream.empty());

    when(() => mockJobMarketBloc.state).thenReturn(const JobMarketState());
    when(
      () => mockJobMarketBloc.stream,
    ).thenAnswer((_) => const Stream.empty());

    when(() => mockMissionTaskBloc.state).thenReturn(const MissionTaskState());
    when(
      () => mockMissionTaskBloc.stream,
    ).thenAnswer((_) => const Stream.empty());

    when(
      () => mockCreateMissionBloc.state,
    ).thenReturn(const CreateMissionState());
    when(
      () => mockCreateMissionBloc.stream,
    ).thenAnswer((_) => const Stream.empty());

    when(
      () => mockNotificationsBloc.state,
    ).thenReturn(const NotificationsState.initial());
    when(
      () => mockNotificationsBloc.stream,
    ).thenAnswer((_) => const Stream.empty());

    when(
      () => mockSocialRadarBloc.state,
    ).thenReturn(const SocialRadarState.initial());
    when(
      () => mockSocialRadarBloc.stream,
    ).thenAnswer((_) => const Stream.empty());

    when(
      () => mockAdminDashboardBloc.state,
    ).thenReturn(const AdminDashboardState.initial());
    when(
      () => mockAdminDashboardBloc.stream,
    ).thenAnswer((_) => const Stream.empty());

    // Stub ListJourneyPhasesUseCase
    when(
      () => mockListJourneyPhasesUseCase.call(),
    ).thenAnswer((_) async => const Right([]));

    // Setup GetIt
    getIt.reset();
    getIt.registerLazySingleton<AuthSessionManager>(() => mockAuthManager);
    getIt.registerFactory<UserRepository>(() => mockUserRepository);
    getIt.registerFactory<MissionRepository>(() => mockMissionRepository);
    getIt.registerFactory<LoginBloc>(() => mockLoginBloc);
    getIt.registerFactory<ProfileBloc>(() => mockProfileBloc);
    getIt.registerFactory<HomeBloc>(() => mockHomeBloc);
    getIt.registerFactory<JourneyGamificationBloc>(
      () => mockJourneyGamificationBloc,
    );
    getIt.registerFactory<ExpenseSharingBloc>(() => mockExpenseSharingBloc);
    getIt.registerFactory<JobMarketBloc>(() => mockJobMarketBloc);
    getIt.registerFactory<MissionTaskBloc>(() => mockMissionTaskBloc);
    getIt.registerFactory<CreateMissionBloc>(() => mockCreateMissionBloc);
    getIt.registerFactory<NotificationsBloc>(() => mockNotificationsBloc);
    getIt.registerFactory<SocialRadarBloc>(() => mockSocialRadarBloc);
    getIt.registerFactory<AdminDashboardBloc>(() => mockAdminDashboardBloc);
    getIt.registerFactory<ListJourneyPhasesUseCase>(
      () => mockListJourneyPhasesUseCase,
    );
  });

  tearDown(getIt.reset);

  Widget buildTestableWidget(AppRouter appRouter) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MaterialApp.router(routerConfig: appRouter.router),
    );
  }

  Future<void> pumpRoute(
    WidgetTester tester,
    AppRouter appRouter,
    String path, {
    Object? extra,
  }) async {
    if (extra != null) {
      appRouter.router.go(path, extra: extra);
    } else {
      appRouter.router.go(path);
    }
    // Process GoRouter microtasks
    await tester.pump();
    // Build the new page
    await tester.pump(const Duration(milliseconds: 100));
  }

  group('AppRouter Navigation Tests', () {
    testWidgets('starts at initialLocation /login', (
      WidgetTester tester,
    ) async {
      final appRouter = AppRouter(mockAuthManager);
      await tester.pumpWidget(buildTestableWidget(appRouter));
      await tester.pump();

      expect(find.byType(LoginPage), findsOneWidget);
    });

    testWidgets('navigates to /register', (WidgetTester tester) async {
      final appRouter = AppRouter(mockAuthManager);
      await tester.pumpWidget(buildTestableWidget(appRouter));
      await tester.pump();

      await pumpRoute(tester, appRouter, '/register');

      expect(find.byType(RegisterPage), findsOneWidget);
    });

    testWidgets('navigates to /home', (WidgetTester tester) async {
      final appRouter = AppRouter(mockAuthManager);
      await tester.pumpWidget(buildTestableWidget(appRouter));
      await tester.pump();

      await pumpRoute(tester, appRouter, '/home');

      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets('navigates to /journey', (WidgetTester tester) async {
      final appRouter = AppRouter(mockAuthManager);
      await tester.pumpWidget(buildTestableWidget(appRouter));
      await tester.pump();

      await pumpRoute(tester, appRouter, '/journey');

      expect(find.byType(JourneyTimelinePage), findsOneWidget);
    });

    testWidgets('navigates to /expenses', (WidgetTester tester) async {
      final appRouter = AppRouter(mockAuthManager);
      await tester.pumpWidget(buildTestableWidget(appRouter));
      await tester.pump();

      await pumpRoute(tester, appRouter, '/expenses');

      expect(find.byType(ExpenseHistoryPage), findsOneWidget);
    });

    testWidgets('navigates to /jobs', (WidgetTester tester) async {
      final appRouter = AppRouter(mockAuthManager);
      await tester.pumpWidget(buildTestableWidget(appRouter));
      await tester.pump();

      await pumpRoute(tester, appRouter, '/jobs');

      expect(find.byType(JobSearchPage), findsOneWidget);
    });

    testWidgets('navigates to /profile', (WidgetTester tester) async {
      final appRouter = AppRouter(mockAuthManager);
      await tester.pumpWidget(buildTestableWidget(appRouter));
      await tester.pump();

      await pumpRoute(tester, appRouter, '/profile');

      expect(find.byType(ProfilePage), findsOneWidget);
    });

    testWidgets('navigates to /home/debug', (WidgetTester tester) async {
      final appRouter = AppRouter(mockAuthManager);
      await tester.pumpWidget(buildTestableWidget(appRouter));
      await tester.pump();

      await pumpRoute(tester, appRouter, '/home/debug');

      expect(find.byType(TempTestScreen), findsOneWidget);
    });

    testWidgets('navigates to /profile/edit', (WidgetTester tester) async {
      final appRouter = AppRouter(mockAuthManager);
      await tester.pumpWidget(buildTestableWidget(appRouter));
      await tester.pump();

      await pumpRoute(tester, appRouter, '/profile/edit');

      expect(find.byType(ProfileEditScreen), findsOneWidget);
    });

    testWidgets('navigates to /settings', (WidgetTester tester) async {
      final appRouter = AppRouter(mockAuthManager);
      await tester.pumpWidget(buildTestableWidget(appRouter));
      await tester.pump();

      await pumpRoute(tester, appRouter, '/settings');

      expect(find.byType(UserSettingsPage), findsOneWidget);
    });

    testWidgets('navigates to /missions', (WidgetTester tester) async {
      final appRouter = AppRouter(mockAuthManager);
      await tester.pumpWidget(buildTestableWidget(appRouter));
      await tester.pump();

      await pumpRoute(tester, appRouter, '/missions');

      expect(find.byType(MissionsDashboardPage), findsOneWidget);
    });

    testWidgets('navigates to /missions/detail', (WidgetTester tester) async {
      final appRouter = AppRouter(mockAuthManager);
      await tester.pumpWidget(buildTestableWidget(appRouter));
      await tester.pump();

      await pumpRoute(
        tester,
        appRouter,
        '/missions/detail',
        extra: 'mission_123',
      );

      expect(find.byType(MissionDetailPage), findsOneWidget);
    });

    testWidgets('navigates to /missions/calendar', (WidgetTester tester) async {
      final appRouter = AppRouter(mockAuthManager);
      await tester.pumpWidget(buildTestableWidget(appRouter));
      await tester.pump();

      await pumpRoute(tester, appRouter, '/missions/calendar');

      expect(find.byType(MissionCalendarPage), findsOneWidget);
    });

    testWidgets('navigates to /missions/search', (WidgetTester tester) async {
      final appRouter = AppRouter(mockAuthManager);
      await tester.pumpWidget(buildTestableWidget(appRouter));
      await tester.pump();

      await pumpRoute(tester, appRouter, '/missions/search');

      expect(find.byType(MissionsSearchPage), findsOneWidget);
    });

    testWidgets('navigates to /missions/create', (WidgetTester tester) async {
      final appRouter = AppRouter(mockAuthManager);
      await tester.pumpWidget(buildTestableWidget(appRouter));
      await tester.pump();

      await pumpRoute(tester, appRouter, '/missions/create');

      expect(find.byType(CreateMissionPage), findsOneWidget);
    });

    testWidgets('navigates to /leaderboard', (WidgetTester tester) async {
      final appRouter = AppRouter(mockAuthManager);
      await tester.pumpWidget(buildTestableWidget(appRouter));
      await tester.pump();

      await pumpRoute(tester, appRouter, '/leaderboard');

      expect(find.byType(LeaderboardPage), findsOneWidget);
    });

    testWidgets('navigates to /badges', (WidgetTester tester) async {
      final appRouter = AppRouter(mockAuthManager);
      await tester.pumpWidget(buildTestableWidget(appRouter));
      await tester.pump();

      await pumpRoute(tester, appRouter, '/badges');

      expect(find.byType(BadgesPage), findsOneWidget);
    });

    testWidgets('navigates to /credit-history', (WidgetTester tester) async {
      final appRouter = AppRouter(mockAuthManager);
      await tester.pumpWidget(buildTestableWidget(appRouter));
      await tester.pump();

      await pumpRoute(tester, appRouter, '/credit-history');

      expect(find.byType(CreditHistoryPage), findsOneWidget);
    });

    testWidgets('navigates to /friends', (WidgetTester tester) async {
      final appRouter = AppRouter(mockAuthManager);
      await tester.pumpWidget(buildTestableWidget(appRouter));
      await tester.pump();

      await pumpRoute(tester, appRouter, '/friends');

      expect(find.byType(FriendsListPage), findsOneWidget);
    });

    testWidgets('navigates to /friend-requests', (WidgetTester tester) async {
      final appRouter = AppRouter(mockAuthManager);
      await tester.pumpWidget(buildTestableWidget(appRouter));
      await tester.pump();

      await pumpRoute(tester, appRouter, '/friend-requests');

      expect(find.byType(FriendRequestsPage), findsOneWidget);
    });

    testWidgets('navigates to /radar', (WidgetTester tester) async {
      final appRouter = AppRouter(mockAuthManager);
      await tester.pumpWidget(buildTestableWidget(appRouter));
      await tester.pump();

      await pumpRoute(tester, appRouter, '/radar');

      expect(find.byType(RadarMapPage), findsOneWidget);
    });

    testWidgets('navigates to /expenses/new', (WidgetTester tester) async {
      final appRouter = AppRouter(mockAuthManager);
      await tester.pumpWidget(buildTestableWidget(appRouter));
      await tester.pump();

      await pumpRoute(tester, appRouter, '/expenses/new');

      expect(find.byType(CreateExpensePage), findsOneWidget);
    });

    testWidgets('navigates to /expenses/:id', (WidgetTester tester) async {
      final appRouter = AppRouter(mockAuthManager);
      await tester.pumpWidget(buildTestableWidget(appRouter));
      await tester.pump();

      await pumpRoute(tester, appRouter, '/expenses/exp_123');

      expect(find.byType(ExpenseDetailsPage), findsOneWidget);
    });

    testWidgets('navigates to /expenses/:id/pay', (WidgetTester tester) async {
      final appRouter = AppRouter(mockAuthManager);
      await tester.pumpWidget(buildTestableWidget(appRouter));
      await tester.pump();

      await pumpRoute(
        tester,
        appRouter,
        '/expenses/exp_123/pay?splitId=split_456',
      );

      expect(find.byType(PaymentSubmissionPage), findsOneWidget);
    });

    testWidgets('navigates to /notifications', (WidgetTester tester) async {
      final appRouter = AppRouter(mockAuthManager);
      await tester.pumpWidget(buildTestableWidget(appRouter));
      await tester.pump();

      await pumpRoute(tester, appRouter, '/notifications');

      expect(find.byType(NotificationCenterPage), findsOneWidget);
    });

    testWidgets('navigates to /admin', (WidgetTester tester) async {
      final appRouter = AppRouter(mockAuthManager);
      await tester.pumpWidget(buildTestableWidget(appRouter));
      await tester.pump();

      await pumpRoute(tester, appRouter, '/admin');

      expect(find.byType(AdminDashboardPage), findsOneWidget);
    });

    testWidgets('navigates to /jobs/cart', (WidgetTester tester) async {
      final appRouter = AppRouter(mockAuthManager);
      await tester.pumpWidget(buildTestableWidget(appRouter));
      await tester.pump();

      await pumpRoute(tester, appRouter, '/jobs/cart');

      expect(find.byType(JobCartPage), findsOneWidget);
    });

    testWidgets('navigates to /jobs/compare', (WidgetTester tester) async {
      final appRouter = AppRouter(mockAuthManager);
      await tester.pumpWidget(buildTestableWidget(appRouter));
      await tester.pump();

      await pumpRoute(tester, appRouter, '/jobs/compare?ids=job_123,job_456');

      expect(find.byType(JobComparePage), findsOneWidget);
    });

    testWidgets('navigates to /jobs/:id', (WidgetTester tester) async {
      final appRouter = AppRouter(mockAuthManager);
      await tester.pumpWidget(buildTestableWidget(appRouter));
      await tester.pump();

      await pumpRoute(tester, appRouter, '/jobs/job_123');

      expect(find.byType(JobDetailsPage), findsOneWidget);
    });

    testWidgets('navigates to /jobs/:id/reviews/new', (
      WidgetTester tester,
    ) async {
      final appRouter = AppRouter(mockAuthManager);
      await tester.pumpWidget(buildTestableWidget(appRouter));
      await tester.pump();

      await pumpRoute(tester, appRouter, '/jobs/job_123/reviews/new');

      expect(find.byType(WriteReviewPage), findsOneWidget);
    });
  });
}
