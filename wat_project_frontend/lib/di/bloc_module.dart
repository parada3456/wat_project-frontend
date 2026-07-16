import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/domain/usecases/admin_usecases.dart';
import 'package:wat_project_frontend/domain/usecases/auth_usecases.dart';
import 'package:wat_project_frontend/domain/usecases/expense_usecases.dart';
import 'package:wat_project_frontend/domain/usecases/friend_usecases.dart';
import 'package:wat_project_frontend/domain/usecases/gamification_usecases.dart';
import 'package:wat_project_frontend/domain/usecases/job_usecases.dart';
import 'package:wat_project_frontend/domain/usecases/journey_usecases.dart';
import 'package:wat_project_frontend/domain/usecases/mission_usecases.dart';
import 'package:wat_project_frontend/domain/usecases/notification_usecases.dart';
import 'package:wat_project_frontend/domain/usecases/user_usecases.dart';
import 'package:wat_project_frontend/presentation/home/bloc/home_bloc.dart';
import 'package:wat_project_frontend/presentation/auth_profile/login/bloc/login_bloc.dart';
import 'package:wat_project_frontend/presentation/auth_profile/profile/bloc/profile_bloc.dart';
import 'package:wat_project_frontend/presentation/admin_dashboard/bloc/admin_dashboard_bloc.dart';
import 'package:wat_project_frontend/domain/services/auth_manager.dart';
import 'package:wat_project_frontend/domain/repositories/user_repository.dart';

// Module 2 BLoC & UseCases
import 'package:wat_project_frontend/presentation/expense_sharing/bloc/expense_sharing_bloc.dart';

// Module 3 BLoC & UseCases
import 'package:wat_project_frontend/presentation/job_market/bloc/job_market_bloc.dart';

// Module 4 BLoC & UseCases
import 'package:wat_project_frontend/presentation/missions_tasks/bloc/mission_task_bloc.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/bloc/create_mission_bloc.dart';

// Module 5 BLoC & UseCases
import 'package:wat_project_frontend/presentation/journey_gamification/bloc/journey_gamification_bloc.dart';

// Module 6 BLoC & UseCases
import 'package:wat_project_frontend/presentation/social_radar/bloc/social_radar_bloc.dart';

// Module 7 BLoC & UseCases
import 'package:wat_project_frontend/presentation/notifications/bloc/notifications_bloc.dart';

@module
abstract class BlocModule {
  @injectable
  HomeBloc homeBloc(GetHomeDataUseCase getHomeDataUseCase) =>
      HomeBloc(getHomeDataUseCase);

  @injectable
  LoginBloc loginBloc(
    LoginUseCase loginUseCase,
    RegisterUseCase registerUseCase,
    ForgotPasswordUseCase forgotPasswordUseCase,
    ResetPasswordUseCase resetPasswordUseCase,
    LogoutUseCase logoutUseCase,
    AuthSessionManager authManager,
    UserRepository userRepository,
    GoogleLoginUseCase googleLoginUseCase,
  ) => LoginBloc(
    loginUseCase,
    registerUseCase,
    forgotPasswordUseCase,
    resetPasswordUseCase,
    logoutUseCase,
    authManager,
    userRepository,
    googleLoginUseCase,
  );

  @injectable
  ProfileBloc profileBloc(
    GetProfileUseCase getProfileUseCase,
    UpdateProfileUseCase updateProfileUseCase,
    GetBadgesUseCase getBadgesUseCase,
    GetCreditScoreHistoryUseCase getCreditScoreHistoryUseCase,
    UpdateLocationUseCase updateLocationUseCase,
    DeleteAccountUseCase deleteAccountUseCase,
  ) => ProfileBloc(
    getProfileUseCase,
    updateProfileUseCase,
    getBadgesUseCase,
    getCreditScoreHistoryUseCase,
    updateLocationUseCase,
    deleteAccountUseCase,
  );

  @injectable
  AdminDashboardBloc adminDashboardBloc(
    GetAdminStatsUseCase getAdminStatsUseCase,
    ListPendingVerificationsUseCase listPendingVerificationsUseCase,
    VerifyAdminMissionUseCase verifyAdminMissionUseCase,
    GetAdminUsersUseCase getAdminUsersUseCase,
    GetAdminUserDetailUseCase getAdminUserDetailUseCase,
    AdjustPointsUseCase adjustPointsUseCase,
  ) => AdminDashboardBloc(
    getAdminStatsUseCase,
    listPendingVerificationsUseCase,
    verifyAdminMissionUseCase,
    getAdminUsersUseCase,
    getAdminUserDetailUseCase,
    adjustPointsUseCase,
  );

  @injectable
  ExpenseSharingBloc expenseSharingBloc(
    ListExpensesUseCase listExpensesUseCase,
    CreateExpenseUseCase createExpenseUseCase,
    GetExpenseDetailUseCase getExpenseDetailUseCase,
    DeleteExpenseUseCase deleteExpenseUseCase,
    ListPendingSplitsUseCase listPendingSplitsUseCase,
    PayExpenseSplitUseCase payExpenseSplitUseCase,
    ApproveExpenseSplitPaymentUseCase approveExpenseSplitPaymentUseCase,
  ) => ExpenseSharingBloc(
    listExpensesUseCase,
    createExpenseUseCase,
    getExpenseDetailUseCase,
    deleteExpenseUseCase,
    listPendingSplitsUseCase,
    payExpenseSplitUseCase,
    approveExpenseSplitPaymentUseCase,
  );

  @injectable
  JobMarketBloc jobMarketBloc(
    ListJobsUseCase listJobsUseCase,
    GetJobDetailUseCase getJobDetailUseCase,
    AddJobToCartUseCase addJobToCartUseCase,
    ListCartItemsUseCase listCartItemsUseCase,
    RemoveJobFromCartUseCase removeJobFromCartUseCase,
    CreateJobReviewUseCase createJobReviewUseCase,
    ListApplicationsUseCase listApplicationsUseCase,
    ListJobReviewsUseCase listJobReviewsUseCase,
    UpdateCartStatusUseCase updateCartStatusUseCase,
    CreateJobUseCase createJobUseCase,
    UpdateJobUseCase updateJobUseCase,
    DeleteJobUseCase deleteJobUseCase,
  ) => JobMarketBloc(
    listJobsUseCase: listJobsUseCase,
    getJobDetailUseCase: getJobDetailUseCase,
    addJobToCartUseCase: addJobToCartUseCase,
    listCartItemsUseCase: listCartItemsUseCase,
    removeJobFromCartUseCase: removeJobFromCartUseCase,
    createJobReviewUseCase: createJobReviewUseCase,
    listApplicationsUseCase: listApplicationsUseCase,
    listJobReviewsUseCase: listJobReviewsUseCase,
    updateCartStatusUseCase: updateCartStatusUseCase,
    createJobUseCase: createJobUseCase,
    updateJobUseCase: updateJobUseCase,
    deleteJobUseCase: deleteJobUseCase,
  );

  @injectable
  MissionTaskBloc missionTaskBloc(
    ListMyMissionsUseCase listMyMissionsUseCase,
    GetMissionDetailUseCase getMissionDetailUseCase,
    SubmitMissionProofUseCase submitMissionProofUseCase,
    ToggleTaskUseCase toggleTaskUseCase,
    GetExploreMissionUseCase getExploreMissionUseCase,
    JoinMissionUseCase joinMissionUseCase,
    GetProfileUseCase getProfileUseCase,
    ListAllMissionsUseCase listAllMissionsUseCase,
  ) => MissionTaskBloc(
    listMyMissionsUseCase,
    getMissionDetailUseCase,
    submitMissionProofUseCase,
    toggleTaskUseCase,
    getExploreMissionUseCase,
    joinMissionUseCase,
    getProfileUseCase,
    listAllMissionsUseCase,
  );

  @injectable
  CreateMissionBloc createMissionBloc(
    CreateMissionUseCase createMissionUseCase,
  ) => CreateMissionBloc(createMissionUseCase);

  @injectable
  JourneyGamificationBloc journeyGamificationBloc(
    ListJourneyPhasesUseCase listJourneyPhasesUseCase,
    AdvancePhaseUseCase advancePhaseUseCase,
    GetJourneyHistoryUseCase getJourneyHistoryUseCase,
    GetLeaderboardUseCase getLeaderboardUseCase,
  ) => JourneyGamificationBloc(
    listJourneyPhasesUseCase,
    advancePhaseUseCase,
    getJourneyHistoryUseCase,
    getLeaderboardUseCase,
  );

  @injectable
  SocialRadarBloc socialRadarBloc(
    SendFriendRequestUseCase sendFriendRequestUseCase,
    ListPendingRequestsUseCase listPendingRequestsUseCase,
    RespondToFriendRequestUseCase respondToFriendRequestUseCase,
    ListFriendsUseCase listFriendsUseCase,
    RemoveFriendUseCase removeFriendUseCase,
    GetRadarUsersUseCase getRadarUsersUseCase,
  ) => SocialRadarBloc(
    sendFriendRequestUseCase,
    listPendingRequestsUseCase,
    respondToFriendRequestUseCase,
    listFriendsUseCase,
    removeFriendUseCase,
    getRadarUsersUseCase,
  );

  @injectable
  NotificationsBloc notificationsBloc(
    ListNotificationsUseCase listNotificationsUseCase,
    MarkNotificationReadUseCase markNotificationReadUseCase,
    MarkAllNotificationsReadUseCase markAllNotificationsReadUseCase,
    DeleteNotificationUseCase deleteNotificationUseCase,
  ) => NotificationsBloc(
    listNotificationsUseCase,
    markNotificationReadUseCase,
    markAllNotificationsReadUseCase,
    deleteNotificationUseCase,
  );
}
