
import 'package:go_router/go_router.dart';
import 'package:wat_project_frontend/presentation/auth_profile/login/ui/login_page.dart';
import 'package:wat_project_frontend/presentation/auth_profile/profile/ui/edit_profile_page.dart';
import 'package:wat_project_frontend/presentation/auth_profile/profile/ui/profile_page.dart';
import 'package:wat_project_frontend/presentation/auth_profile/login/ui/login_page.dart';
import 'package:wat_project_frontend/presentation/auth_profile/login/ui/register_page.dart';
import 'package:wat_project_frontend/presentation/auth_profile/login/ui/register_page_2.dart';
import 'package:wat_project_frontend/presentation/auth_profile/screens/user_settings_page.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/screens/create_expense_page.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/screens/expense_details_page.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/screens/expense_history_page.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/screens/payment_submission_page.dart';
import 'package:wat_project_frontend/presentation/home/screens/temp_test_screen.dart';
import 'package:wat_project_frontend/presentation/job_market/screens/job_cart_page.dart';
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
import 'package:wat_project_frontend/presentation/notifications/screens/notification_center_page.dart';
import 'package:wat_project_frontend/presentation/social_radar/screens/friend_requests_page.dart';
import 'package:wat_project_frontend/presentation/social_radar/screens/friends_list_page.dart';
import 'package:wat_project_frontend/presentation/social_radar/screens/radar_map_page.dart';
import 'package:wat_project_frontend/domain/services/auth_manager.dart';
import 'package:wat_project_frontend/presentation/navigation/screens/main_shell_page.dart';
import 'package:wat_project_frontend/presentation/home/screens/home_page.dart';
import 'package:wat_project_frontend/presentation/admin_dashboard/screens/admin_dashboard_page.dart';

class AppRouter {
  final AuthSessionManager _authManager;

  AppRouter(this._authManager);

  late final router = GoRouter(
    initialLocation: '/login',
    refreshListenable: _authManager.sessionNotifier,
    // redirect: (context, state) {
    //   final isLoggedIn = _authManager.currentSession != null;
    //   final isLoggingIn = state.matchedLocation == '/login' || state.matchedLocation == '/register';

    //   if (!isLoggedIn && !isLoggingIn) {
    //     print('Redirecting to login page');
    //     return '/login';
    //   }
    //   if (isLoggedIn && isLoggingIn) {
    //     print("Redirecting to home page");
    //     return '/home';
    //   }
    //   return null;
    // },
    routes: [
      // GoRoute(
      //   path: '/home',
      //   builder: (context, state) => const HomePage(),
      // ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      // GoRoute(
      //   path: '/register',
      //   builder: (context, state) => const RegisterPage(),
      // ),
      // GoRoute(
      //   path: '/register',
      //   builder: (context, state) => const RegisterPage2(),
      // ),
      ShellRoute(
        builder: (context, state, child) {
          return MainShellPage(child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const TempTestScreen(),
          ),
          GoRoute(
            path: '/expenses',
            builder: (context, state) => const ExpenseHistoryPage(),
          ),
          GoRoute(
            path: '/jobs',
            builder: (context, state) => const JobSearchPage(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfilePage(),
          ),
        ],
      ),
      GoRoute(
        path: '/home/debug',
        builder: (context, state) => const TempTestScreen(),
      ),
      GoRoute(
        path: '/profile/edit',
        builder: (context, state) => const ProfileEditScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const UserSettingsPage(),
      ),
      GoRoute(
        path: '/missions',
        builder: (context, state) => const MissionsDashboardPage(),
      ),
      GoRoute(
        path: '/missions/detail',
        builder: (context, state) => const MissionDetailPage(),
      ),
      GoRoute(
        path: '/missions/calendar',
        builder: (context, state) => const MissionCalendarPage(),
      ),
      GoRoute(
        path: '/missions/search',
        builder: (context, state) => const MissionsSearchPage(),
      ),
      GoRoute(
        path: '/journey',
        builder: (context, state) => const JourneyTimelinePage(),
      ),
      GoRoute(
        path: '/leaderboard',
        builder: (context, state) => const LeaderboardPage(),
      ),
      GoRoute(
        path: '/badges',
        builder: (context, state) => const BadgesPage(),
      ),
      GoRoute(
        path: '/credit-history',
        builder: (context, state) => const CreditHistoryPage(),
      ),
      GoRoute(
        path: '/friends',
        builder: (context, state) => const FriendsListPage(),
      ),
      GoRoute(
        path: '/friend-requests',
        builder: (context, state) => const FriendRequestsPage(),
      ),
      GoRoute(
        path: '/radar',
        builder: (context, state) => const RadarMapPage(),
      ),
      GoRoute(
        path: '/expenses/create',
        builder: (context, state) => const CreateExpensePage(),
      ),
      GoRoute(
        path: '/expenses/details',
        builder: (context, state) => const ExpenseDetailsPage(),
      ),
      GoRoute(
        path: '/expenses/submit',
        builder: (context, state) => const PaymentSubmissionPage(),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationCenterPage(),
      ),
      GoRoute(
        path: '/admin',
        builder: (context, state) => const AdminDashboardPage(),
        // redirect: (context, state) {
        //   final session = _authManager.currentSession;
        //   if (session == null) return '/login';
        //   final parts = session.token.split('.');
        //   if (parts.length >= 2) {
        //     try {
        //       final payload = parts[1];
        //       final normalized = base64.normalize(payload);
        //       final decoded = utf8.decode(base64Decode(normalized));
        //       final Map<String, dynamic> claims = jsonDecode(decoded) as Map<String, dynamic>;
        //       if (claims['is_admin'] == true) {
        //         return null;
        //       }
        //     } catch (_) {}
        //   }
        //   return '/home';
        // },
      ),
      GoRoute(
        path: '/jobs/details',
        builder: (context, state) => const JobDetailsPage(),
      ),
      GoRoute(
        path: '/jobs/cart',
        builder: (context, state) => const JobCartPage(),
      ),
      GoRoute(
        path: '/jobs/review',
        builder: (context, state) => const WriteReviewPage(),
      ),
    ],
  );
}
