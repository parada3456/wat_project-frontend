import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/presentation/home/bloc/home_bloc.dart';
import 'package:wat_project_frontend/presentation/auth_profile/login/bloc/login_bloc.dart';
import 'package:wat_project_frontend/presentation/auth_profile/profile/bloc/profile_bloc.dart';
import 'package:wat_project_frontend/presentation/admin_dashboard/bloc/admin_dashboard_bloc.dart';
import 'package:wat_project_frontend/domain/usecases/get_home_data_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/login_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/register_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/forgot_password_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/reset_password_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/logout_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/get_profile_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/update_profile_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/get_badges_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/get_credit_score_history_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/update_location_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/delete_account_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/get_admin_stats_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/list_pending_verifications_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/verify_admin_mission_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/get_admin_users_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/get_admin_user_detail_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/adjust_points_usecase.dart';
import 'package:wat_project_frontend/domain/services/auth_manager.dart';
import 'package:wat_project_frontend/domain/repositories/user_repository.dart';

// Module 2 BLoC & UseCases
import 'package:wat_project_frontend/presentation/expense_sharing/bloc/expense_sharing_bloc.dart';
import 'package:wat_project_frontend/domain/usecases/list_expenses_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/create_expense_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/get_expense_detail_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/delete_expense_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/list_pending_splits_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/pay_expense_split_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/approve_expense_split_payment_usecase.dart';

// Module 3 BLoC & UseCases
import 'package:wat_project_frontend/presentation/job_market/bloc/job_market_bloc.dart';
import 'package:wat_project_frontend/domain/usecases/list_jobs_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/get_job_detail_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/add_job_to_cart_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/list_cart_items_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/remove_job_from_cart_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/create_job_review_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/list_applications_usecase.dart';

// Module 4 BLoC & UseCases
import 'package:wat_project_frontend/presentation/missions_tasks/bloc/mission_task_bloc.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/bloc/create_mission_bloc.dart';
import 'package:wat_project_frontend/domain/usecases/list_available_missions_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/get_mission_detail_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/submit_mission_proof_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/toggle_task_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/create_mission_usecase.dart';

// Module 5 BLoC & UseCases
import 'package:wat_project_frontend/presentation/journey_gamification/bloc/journey_gamification_bloc.dart';
import 'package:wat_project_frontend/domain/usecases/list_journey_phases_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/advance_phase_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/get_journey_history_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/get_leaderboard_usecase.dart';

// Module 6 BLoC & UseCases
import 'package:wat_project_frontend/presentation/social_radar/bloc/social_radar_bloc.dart';
import 'package:wat_project_frontend/domain/usecases/send_friend_request_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/list_pending_requests_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/respond_to_friend_request_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/list_friends_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/remove_friend_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/get_radar_users_usecase.dart';

// Module 7 BLoC & UseCases
import 'package:wat_project_frontend/presentation/notifications/bloc/notifications_bloc.dart';
import 'package:wat_project_frontend/domain/usecases/list_notifications_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/mark_notification_read_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/mark_all_notifications_read_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/delete_notification_usecase.dart';

@module
abstract class BlocModule {
  @injectable
  HomeBloc homeBloc(GetHomeDataUseCase getHomeDataUseCase) => HomeBloc(getHomeDataUseCase);

  @injectable
  LoginBloc loginBloc(
    LoginUseCase loginUseCase,
    RegisterUseCase registerUseCase,
    ForgotPasswordUseCase forgotPasswordUseCase,
    ResetPasswordUseCase resetPasswordUseCase,
    LogoutUseCase logoutUseCase,
    AuthSessionManager authManager,
    UserRepository userRepository,
  ) =>
      LoginBloc(
        loginUseCase,
        registerUseCase,
        forgotPasswordUseCase,
        resetPasswordUseCase,
        logoutUseCase,
        authManager,
        userRepository,
      );

  @injectable
  ProfileBloc profileBloc(
    GetProfileUseCase getProfileUseCase,
    UpdateProfileUseCase updateProfileUseCase,
    GetBadgesUseCase getBadgesUseCase,
    GetCreditScoreHistoryUseCase getCreditScoreHistoryUseCase,
    UpdateLocationUseCase updateLocationUseCase,
    DeleteAccountUseCase deleteAccountUseCase,
  ) =>
      ProfileBloc(
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
  ) =>
      AdminDashboardBloc(
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
  ) =>
      ExpenseSharingBloc(
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
  ) =>
      JobMarketBloc(
        listJobsUseCase: listJobsUseCase,
        getJobDetailUseCase: getJobDetailUseCase,
        addJobToCartUseCase: addJobToCartUseCase,
        listCartItemsUseCase: listCartItemsUseCase,
        removeJobFromCartUseCase: removeJobFromCartUseCase,
        createJobReviewUseCase: createJobReviewUseCase,
        listApplicationsUseCase: listApplicationsUseCase,
      );

  @injectable
  MissionTaskBloc missionTaskBloc(
    ListAvailableMissionsUseCase listAvailableMissionsUseCase,
    GetMissionDetailUseCase getMissionDetailUseCase,
    SubmitMissionProofUseCase submitMissionProofUseCase,
    ToggleTaskUseCase toggleTaskUseCase,
  ) =>
      MissionTaskBloc(
        listAvailableMissionsUseCase,
        getMissionDetailUseCase,
        submitMissionProofUseCase,
        toggleTaskUseCase,
      );

  @injectable
  CreateMissionBloc createMissionBloc(
    CreateMissionUseCase createMissionUseCase,
  ) =>
      CreateMissionBloc(createMissionUseCase);

  @injectable
  JourneyGamificationBloc journeyGamificationBloc(
    ListJourneyPhasesUseCase listJourneyPhasesUseCase,
    AdvancePhaseUseCase advancePhaseUseCase,
    GetJourneyHistoryUseCase getJourneyHistoryUseCase,
    GetLeaderboardUseCase getLeaderboardUseCase,
  ) =>
      JourneyGamificationBloc(
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
  ) =>
      SocialRadarBloc(
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
  ) =>
      NotificationsBloc(
        listNotificationsUseCase,
        markNotificationReadUseCase,
        markAllNotificationsReadUseCase,
        deleteNotificationUseCase,
      );
}
