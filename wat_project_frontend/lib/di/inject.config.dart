// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:go_router/go_router.dart' as _i583;
import 'package:injectable/injectable.dart' as _i526;
import 'package:wat_project_frontend/data/repository_impl/admin_repo_impl.dart'
    as _i789;
import 'package:wat_project_frontend/data/repository_impl/auth_repo_impl.dart'
    as _i643;
import 'package:wat_project_frontend/data/repository_impl/expense_repo_impl.dart'
    as _i377;
import 'package:wat_project_frontend/data/repository_impl/friend_repo_impl.dart'
    as _i337;
import 'package:wat_project_frontend/data/repository_impl/job_repo_impl.dart'
    as _i451;
import 'package:wat_project_frontend/data/repository_impl/journey_repo_impl.dart'
    as _i864;
import 'package:wat_project_frontend/data/repository_impl/media_repo_impl.dart'
    as _i825;
import 'package:wat_project_frontend/data/repository_impl/mission_repo_impl.dart'
    as _i1043;
import 'package:wat_project_frontend/data/repository_impl/notification_repo_impl.dart'
    as _i590;
import 'package:wat_project_frontend/data/repository_impl/user_repo_impl.dart'
    as _i399;
import 'package:wat_project_frontend/data/sources/api/admin_api_client.dart'
    as _i389;
import 'package:wat_project_frontend/data/sources/api/auth_api_client.dart'
    as _i599;
import 'package:wat_project_frontend/data/sources/api/expense_api_client.dart'
    as _i701;
import 'package:wat_project_frontend/data/sources/api/friend_api_client.dart'
    as _i913;
import 'package:wat_project_frontend/data/sources/api/job_api_client.dart'
    as _i388;
import 'package:wat_project_frontend/data/sources/api/journey_api_client.dart'
    as _i491;
import 'package:wat_project_frontend/data/sources/api/media_api_client.dart'
    as _i1013;
import 'package:wat_project_frontend/data/sources/api/mission_api_client.dart'
    as _i21;
import 'package:wat_project_frontend/data/sources/api/notification_api_client.dart'
    as _i465;
import 'package:wat_project_frontend/data/sources/api/user_api_client.dart'
    as _i165;
import 'package:wat_project_frontend/di/api_module.dart' as _i788;
import 'package:wat_project_frontend/di/auth_module.dart' as _i406;
import 'package:wat_project_frontend/di/bloc_module.dart' as _i784;
import 'package:wat_project_frontend/di/dio_module.dart' as _i193;
import 'package:wat_project_frontend/di/local_module.dart' as _i6;
import 'package:wat_project_frontend/di/repository_module.dart' as _i317;
import 'package:wat_project_frontend/di/router_module.dart' as _i671;
import 'package:wat_project_frontend/domain/providers/locale_provider.dart'
    as _i455;
import 'package:wat_project_frontend/domain/providers/theme_provider.dart'
    as _i634;
import 'package:wat_project_frontend/domain/repositories/admin_repository.dart'
    as _i244;
import 'package:wat_project_frontend/domain/repositories/auth_repository.dart'
    as _i416;
import 'package:wat_project_frontend/domain/repositories/expense_repository.dart'
    as _i1052;
import 'package:wat_project_frontend/domain/repositories/friend_repository.dart'
    as _i1013;
import 'package:wat_project_frontend/domain/repositories/job_repository.dart'
    as _i39;
import 'package:wat_project_frontend/domain/repositories/journey_repository.dart'
    as _i381;
import 'package:wat_project_frontend/domain/repositories/media_repository.dart'
    as _i907;
import 'package:wat_project_frontend/domain/repositories/mission_repository.dart'
    as _i448;
import 'package:wat_project_frontend/domain/repositories/notification_repository.dart'
    as _i187;
import 'package:wat_project_frontend/domain/repositories/user_repository.dart'
    as _i455;
import 'package:wat_project_frontend/domain/services/auth_manager.dart'
    as _i349;
import 'package:wat_project_frontend/domain/usecases/add_job_to_cart_usecase.dart'
    as _i1040;
import 'package:wat_project_frontend/domain/usecases/adjust_points_usecase.dart'
    as _i639;
import 'package:wat_project_frontend/domain/usecases/advance_phase_usecase.dart'
    as _i1015;
import 'package:wat_project_frontend/domain/usecases/approve_expense_split_payment_usecase.dart'
    as _i135;
import 'package:wat_project_frontend/domain/usecases/create_expense_usecase.dart'
    as _i323;
import 'package:wat_project_frontend/domain/usecases/create_job_review_usecase.dart'
    as _i250;
import 'package:wat_project_frontend/domain/usecases/create_mission_usecase.dart'
    as _i238;
import 'package:wat_project_frontend/domain/usecases/delete_account_usecase.dart'
    as _i257;
import 'package:wat_project_frontend/domain/usecases/delete_expense_usecase.dart'
    as _i308;
import 'package:wat_project_frontend/domain/usecases/delete_notification_usecase.dart'
    as _i301;
import 'package:wat_project_frontend/domain/usecases/forgot_password_usecase.dart'
    as _i997;
import 'package:wat_project_frontend/domain/usecases/get_admin_stats_usecase.dart'
    as _i931;
import 'package:wat_project_frontend/domain/usecases/get_admin_user_detail_usecase.dart'
    as _i495;
import 'package:wat_project_frontend/domain/usecases/get_admin_users_usecase.dart'
    as _i81;
import 'package:wat_project_frontend/domain/usecases/get_badges_usecase.dart'
    as _i914;
import 'package:wat_project_frontend/domain/usecases/get_credit_score_history_usecase.dart'
    as _i822;
import 'package:wat_project_frontend/domain/usecases/get_expense_detail_usecase.dart'
    as _i739;
import 'package:wat_project_frontend/domain/usecases/get_home_data_usecase.dart'
    as _i921;
import 'package:wat_project_frontend/domain/usecases/get_job_detail_usecase.dart'
    as _i636;
import 'package:wat_project_frontend/domain/usecases/get_journey_history_usecase.dart'
    as _i672;
import 'package:wat_project_frontend/domain/usecases/get_leaderboard_usecase.dart'
    as _i260;
import 'package:wat_project_frontend/domain/usecases/get_login_usecase.dart'
    as _i937;
import 'package:wat_project_frontend/domain/usecases/get_mission_detail_usecase.dart'
    as _i213;
import 'package:wat_project_frontend/domain/usecases/get_posts_usecase.dart'
    as _i374;
import 'package:wat_project_frontend/domain/usecases/get_profile_usecase.dart'
    as _i835;
import 'package:wat_project_frontend/domain/usecases/get_radar_users_usecase.dart'
    as _i853;
import 'package:wat_project_frontend/domain/usecases/get_user_usecase.dart'
    as _i283;
import 'package:wat_project_frontend/domain/usecases/list_applications_usecase.dart'
    as _i59;
import 'package:wat_project_frontend/domain/usecases/list_available_missions_usecase.dart'
    as _i749;
import 'package:wat_project_frontend/domain/usecases/list_cart_items_usecase.dart'
    as _i1027;
import 'package:wat_project_frontend/domain/usecases/list_expenses_usecase.dart'
    as _i886;
import 'package:wat_project_frontend/domain/usecases/list_friends_usecase.dart'
    as _i145;
import 'package:wat_project_frontend/domain/usecases/list_jobs_usecase.dart'
    as _i776;
import 'package:wat_project_frontend/domain/usecases/list_journey_phases_usecase.dart'
    as _i882;
import 'package:wat_project_frontend/domain/usecases/list_notifications_usecase.dart'
    as _i347;
import 'package:wat_project_frontend/domain/usecases/list_pending_requests_usecase.dart'
    as _i25;
import 'package:wat_project_frontend/domain/usecases/list_pending_splits_usecase.dart'
    as _i349;
import 'package:wat_project_frontend/domain/usecases/list_pending_verifications_usecase.dart'
    as _i578;
import 'package:wat_project_frontend/domain/usecases/login_usecase.dart'
    as _i717;
import 'package:wat_project_frontend/domain/usecases/logout_usecase.dart'
    as _i581;
import 'package:wat_project_frontend/domain/usecases/mark_all_notifications_read_usecase.dart'
    as _i158;
import 'package:wat_project_frontend/domain/usecases/mark_notification_read_usecase.dart'
    as _i160;
import 'package:wat_project_frontend/domain/usecases/pay_expense_split_usecase.dart'
    as _i424;
import 'package:wat_project_frontend/domain/usecases/refresh_token_usecase.dart'
    as _i743;
import 'package:wat_project_frontend/domain/usecases/register_usecase.dart'
    as _i179;
import 'package:wat_project_frontend/domain/usecases/remove_friend_usecase.dart'
    as _i873;
import 'package:wat_project_frontend/domain/usecases/remove_job_from_cart_usecase.dart'
    as _i28;
import 'package:wat_project_frontend/domain/usecases/reset_password_usecase.dart'
    as _i212;
import 'package:wat_project_frontend/domain/usecases/respond_to_friend_request_usecase.dart'
    as _i699;
import 'package:wat_project_frontend/domain/usecases/send_friend_request_usecase.dart'
    as _i92;
import 'package:wat_project_frontend/domain/usecases/submit_mission_proof_usecase.dart'
    as _i150;
import 'package:wat_project_frontend/domain/usecases/toggle_task_usecase.dart'
    as _i192;
import 'package:wat_project_frontend/domain/usecases/update_location_usecase.dart'
    as _i745;
import 'package:wat_project_frontend/domain/usecases/update_profile_usecase.dart'
    as _i549;
import 'package:wat_project_frontend/domain/usecases/verify_admin_mission_usecase.dart'
    as _i516;
import 'package:wat_project_frontend/presentation/admin_dashboard/bloc/admin_dashboard_bloc.dart'
    as _i280;
import 'package:wat_project_frontend/presentation/auth_profile/login/bloc/login_bloc.dart'
    as _i1031;
import 'package:wat_project_frontend/presentation/auth_profile/profile/bloc/profile_bloc.dart'
    as _i384;
import 'package:wat_project_frontend/presentation/expense_sharing/bloc/expense_sharing_bloc.dart'
    as _i384;
import 'package:wat_project_frontend/presentation/home/bloc/home_bloc.dart'
    as _i906;
import 'package:wat_project_frontend/presentation/job_market/bloc/job_market_bloc.dart'
    as _i533;
import 'package:wat_project_frontend/presentation/journey_gamification/bloc/journey_gamification_bloc.dart'
    as _i1054;
import 'package:wat_project_frontend/presentation/missions_tasks/bloc/create_mission_bloc.dart'
    as _i282;
import 'package:wat_project_frontend/presentation/missions_tasks/bloc/mission_task_bloc.dart'
    as _i928;
import 'package:wat_project_frontend/presentation/notifications/bloc/notifications_bloc.dart'
    as _i392;
import 'package:wat_project_frontend/presentation/social_radar/bloc/social_radar_bloc.dart'
    as _i459;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final localModule = _$LocalModule();
    final dioModule = _$DioModule();
    final apiModule = _$ApiModule();
    final authModule = _$AuthModule();
    final repositoryModule = _$RepositoryModule();
    final routerModule = _$RouterModule();
    final blocModule = _$BlocModule();
    gh.factory<_i374.GetPostsUseCase>(() => _i374.GetPostsUseCase());
    gh.lazySingleton<_i558.FlutterSecureStorage>(() => localModule.storage);
    gh.lazySingleton<_i455.LocaleProvider>(() => _i455.LocaleProvider());
    gh.lazySingleton<_i634.ThemeProvider>(() => _i634.ThemeProvider());
    gh.lazySingleton<_i361.Dio>(
      () => dioModule.authDio(),
      instanceName: 'authDio',
    );
    gh.lazySingleton<_i599.AuthApiService>(
      () => apiModule.authApi(gh<_i361.Dio>(instanceName: 'authDio')),
    );
    gh.singleton<_i349.AuthSessionManager>(
      () => authModule.authSessionManager(
        gh<_i558.FlutterSecureStorage>(),
        gh<_i599.AuthApiService>(),
      ),
    );
    gh.lazySingleton<_i361.Dio>(
      () => dioModule.mainDio(
        gh<_i361.Dio>(instanceName: 'authDio'),
        gh<_i349.AuthSessionManager>(),
      ),
      instanceName: 'mainDio',
    );
    gh.lazySingleton<_i165.UserApiService>(
      () => apiModule.userApi(gh<_i361.Dio>(instanceName: 'mainDio')),
    );
    gh.lazySingleton<_i21.MissionApiService>(
      () => apiModule.missionApi(gh<_i361.Dio>(instanceName: 'mainDio')),
    );
    gh.lazySingleton<_i491.JourneyApiService>(
      () => apiModule.journeyApi(gh<_i361.Dio>(instanceName: 'mainDio')),
    );
    gh.lazySingleton<_i913.FriendApiService>(
      () => apiModule.friendApi(gh<_i361.Dio>(instanceName: 'mainDio')),
    );
    gh.lazySingleton<_i701.ExpenseApiService>(
      () => apiModule.expenseApi(gh<_i361.Dio>(instanceName: 'mainDio')),
    );
    gh.lazySingleton<_i465.NotificationApiService>(
      () => apiModule.notificationApi(gh<_i361.Dio>(instanceName: 'mainDio')),
    );
    gh.lazySingleton<_i388.JobApiService>(
      () => apiModule.jobApi(gh<_i361.Dio>(instanceName: 'mainDio')),
    );
    gh.lazySingleton<_i389.AdminApiService>(
      () => apiModule.adminApi(gh<_i361.Dio>(instanceName: 'mainDio')),
    );
    gh.lazySingleton<_i1013.MediaApiService>(
      () => apiModule.mediaApi(gh<_i361.Dio>(instanceName: 'mainDio')),
    );
    gh.factory<_i337.FriendRepoImpl>(
      () => _i337.FriendRepoImpl(gh<_i913.FriendApiService>()),
    );
    gh.factory<_i864.JourneyRepoImpl>(
      () => _i864.JourneyRepoImpl(gh<_i491.JourneyApiService>()),
    );
    gh.factory<_i643.AuthRepoImpl>(
      () => _i643.AuthRepoImpl(gh<_i599.AuthApiService>()),
    );
    gh.factory<_i1043.MissionRepoImpl>(
      () => _i1043.MissionRepoImpl(gh<_i21.MissionApiService>()),
    );
    gh.factory<_i416.AuthRepository>(
      () => repositoryModule.authRepository(gh<_i643.AuthRepoImpl>()),
    );
    gh.factory<_i825.MediaRepoImpl>(
      () => _i825.MediaRepoImpl(gh<_i1013.MediaApiService>()),
    );
    gh.factory<_i377.ExpenseRepoImpl>(
      () => _i377.ExpenseRepoImpl(gh<_i701.ExpenseApiService>()),
    );
    gh.factory<_i1052.ExpenseRepository>(
      () => repositoryModule.expenseRepository(gh<_i377.ExpenseRepoImpl>()),
    );
    gh.factory<_i997.ForgotPasswordUseCase>(
      () => _i997.ForgotPasswordUseCase(gh<_i416.AuthRepository>()),
    );
    gh.factory<_i717.LoginUseCase>(
      () => _i717.LoginUseCase(gh<_i416.AuthRepository>()),
    );
    gh.factory<_i581.LogoutUseCase>(
      () => _i581.LogoutUseCase(gh<_i416.AuthRepository>()),
    );
    gh.factory<_i743.RefreshTokenUseCase>(
      () => _i743.RefreshTokenUseCase(gh<_i416.AuthRepository>()),
    );
    gh.factory<_i179.RegisterUseCase>(
      () => _i179.RegisterUseCase(gh<_i416.AuthRepository>()),
    );
    gh.factory<_i212.ResetPasswordUseCase>(
      () => _i212.ResetPasswordUseCase(gh<_i416.AuthRepository>()),
    );
    gh.factory<_i907.MediaRepository>(
      () => repositoryModule.mediaRepository(gh<_i825.MediaRepoImpl>()),
    );
    gh.singleton<_i583.GoRouter>(
      () => routerModule.router(gh<_i349.AuthSessionManager>()),
    );
    gh.factory<_i451.JobRepoImpl>(
      () => _i451.JobRepoImpl(gh<_i388.JobApiService>()),
    );
    gh.factory<_i399.UserRepoImpl>(
      () => _i399.UserRepoImpl(gh<_i165.UserApiService>()),
    );
    gh.factory<_i590.NotificationRepoImpl>(
      () => _i590.NotificationRepoImpl(gh<_i465.NotificationApiService>()),
    );
    gh.factory<_i187.NotificationRepository>(
      () => repositoryModule.notificationRepository(
        gh<_i590.NotificationRepoImpl>(),
      ),
    );
    gh.factory<_i448.MissionRepository>(
      () => repositoryModule.missionRepository(gh<_i1043.MissionRepoImpl>()),
    );
    gh.factory<_i789.AdminRepoImpl>(
      () => _i789.AdminRepoImpl(gh<_i389.AdminApiService>()),
    );
    gh.factory<_i381.JourneyRepository>(
      () => repositoryModule.journeyRepository(gh<_i864.JourneyRepoImpl>()),
    );
    gh.factory<_i1013.FriendRepository>(
      () => repositoryModule.friendRepository(gh<_i337.FriendRepoImpl>()),
    );
    gh.factory<_i301.DeleteNotificationUseCase>(
      () => _i301.DeleteNotificationUseCase(gh<_i187.NotificationRepository>()),
    );
    gh.factory<_i347.ListNotificationsUseCase>(
      () => _i347.ListNotificationsUseCase(gh<_i187.NotificationRepository>()),
    );
    gh.factory<_i158.MarkAllNotificationsReadUseCase>(
      () => _i158.MarkAllNotificationsReadUseCase(
        gh<_i187.NotificationRepository>(),
      ),
    );
    gh.factory<_i160.MarkNotificationReadUseCase>(
      () =>
          _i160.MarkNotificationReadUseCase(gh<_i187.NotificationRepository>()),
    );
    gh.factory<_i135.ApproveExpenseSplitPaymentUseCase>(
      () => _i135.ApproveExpenseSplitPaymentUseCase(
        gh<_i1052.ExpenseRepository>(),
      ),
    );
    gh.factory<_i323.CreateExpenseUseCase>(
      () => _i323.CreateExpenseUseCase(gh<_i1052.ExpenseRepository>()),
    );
    gh.factory<_i308.DeleteExpenseUseCase>(
      () => _i308.DeleteExpenseUseCase(gh<_i1052.ExpenseRepository>()),
    );
    gh.factory<_i739.GetExpenseDetailUseCase>(
      () => _i739.GetExpenseDetailUseCase(gh<_i1052.ExpenseRepository>()),
    );
    gh.factory<_i886.ListExpensesUseCase>(
      () => _i886.ListExpensesUseCase(gh<_i1052.ExpenseRepository>()),
    );
    gh.factory<_i349.ListPendingSplitsUseCase>(
      () => _i349.ListPendingSplitsUseCase(gh<_i1052.ExpenseRepository>()),
    );
    gh.factory<_i424.PayExpenseSplitUseCase>(
      () => _i424.PayExpenseSplitUseCase(gh<_i1052.ExpenseRepository>()),
    );
    gh.factory<_i1015.AdvancePhaseUseCase>(
      () => _i1015.AdvancePhaseUseCase(gh<_i381.JourneyRepository>()),
    );
    gh.factory<_i672.GetJourneyHistoryUseCase>(
      () => _i672.GetJourneyHistoryUseCase(gh<_i381.JourneyRepository>()),
    );
    gh.factory<_i260.GetLeaderboardUseCase>(
      () => _i260.GetLeaderboardUseCase(gh<_i381.JourneyRepository>()),
    );
    gh.factory<_i882.ListJourneyPhasesUseCase>(
      () => _i882.ListJourneyPhasesUseCase(gh<_i381.JourneyRepository>()),
    );
    gh.factory<_i238.CreateMissionUseCase>(
      () => _i238.CreateMissionUseCase(gh<_i448.MissionRepository>()),
    );
    gh.factory<_i213.GetMissionDetailUseCase>(
      () => _i213.GetMissionDetailUseCase(gh<_i448.MissionRepository>()),
    );
    gh.factory<_i749.ListAvailableMissionsUseCase>(
      () => _i749.ListAvailableMissionsUseCase(gh<_i448.MissionRepository>()),
    );
    gh.factory<_i150.SubmitMissionProofUseCase>(
      () => _i150.SubmitMissionProofUseCase(gh<_i448.MissionRepository>()),
    );
    gh.factory<_i192.ToggleTaskUseCase>(
      () => _i192.ToggleTaskUseCase(gh<_i448.MissionRepository>()),
    );
    gh.factory<_i244.AdminRepository>(
      () => repositoryModule.adminRepository(gh<_i789.AdminRepoImpl>()),
    );
    gh.factory<_i392.NotificationsBloc>(
      () => blocModule.notificationsBloc(
        gh<_i347.ListNotificationsUseCase>(),
        gh<_i160.MarkNotificationReadUseCase>(),
        gh<_i158.MarkAllNotificationsReadUseCase>(),
        gh<_i301.DeleteNotificationUseCase>(),
      ),
    );
    gh.factory<_i639.AdjustPointsUseCase>(
      () => _i639.AdjustPointsUseCase(gh<_i244.AdminRepository>()),
    );
    gh.factory<_i931.GetAdminStatsUseCase>(
      () => _i931.GetAdminStatsUseCase(gh<_i244.AdminRepository>()),
    );
    gh.factory<_i495.GetAdminUserDetailUseCase>(
      () => _i495.GetAdminUserDetailUseCase(gh<_i244.AdminRepository>()),
    );
    gh.factory<_i81.GetAdminUsersUseCase>(
      () => _i81.GetAdminUsersUseCase(gh<_i244.AdminRepository>()),
    );
    gh.factory<_i578.ListPendingVerificationsUseCase>(
      () => _i578.ListPendingVerificationsUseCase(gh<_i244.AdminRepository>()),
    );
    gh.factory<_i516.VerifyAdminMissionUseCase>(
      () => _i516.VerifyAdminMissionUseCase(gh<_i244.AdminRepository>()),
    );
    gh.factory<_i384.ExpenseSharingBloc>(
      () => blocModule.expenseSharingBloc(
        gh<_i886.ListExpensesUseCase>(),
        gh<_i323.CreateExpenseUseCase>(),
        gh<_i739.GetExpenseDetailUseCase>(),
        gh<_i308.DeleteExpenseUseCase>(),
        gh<_i349.ListPendingSplitsUseCase>(),
        gh<_i424.PayExpenseSplitUseCase>(),
        gh<_i135.ApproveExpenseSplitPaymentUseCase>(),
      ),
    );
    gh.factory<_i455.UserRepository>(
      () => repositoryModule.userRepository(gh<_i399.UserRepoImpl>()),
    );
    gh.factory<_i928.MissionTaskBloc>(
      () => blocModule.missionTaskBloc(
        gh<_i749.ListAvailableMissionsUseCase>(),
        gh<_i213.GetMissionDetailUseCase>(),
        gh<_i150.SubmitMissionProofUseCase>(),
        gh<_i192.ToggleTaskUseCase>(),
      ),
    );
    gh.factory<_i280.AdminDashboardBloc>(
      () => blocModule.adminDashboardBloc(
        gh<_i931.GetAdminStatsUseCase>(),
        gh<_i578.ListPendingVerificationsUseCase>(),
        gh<_i516.VerifyAdminMissionUseCase>(),
        gh<_i81.GetAdminUsersUseCase>(),
        gh<_i495.GetAdminUserDetailUseCase>(),
        gh<_i639.AdjustPointsUseCase>(),
      ),
    );
    gh.factory<_i1054.JourneyGamificationBloc>(
      () => blocModule.journeyGamificationBloc(
        gh<_i882.ListJourneyPhasesUseCase>(),
        gh<_i1015.AdvancePhaseUseCase>(),
        gh<_i672.GetJourneyHistoryUseCase>(),
        gh<_i260.GetLeaderboardUseCase>(),
      ),
    );
    gh.factory<_i39.JobRepository>(
      () => repositoryModule.jobRepository(gh<_i451.JobRepoImpl>()),
    );
    gh.factory<_i282.CreateMissionBloc>(
      () => blocModule.createMissionBloc(gh<_i238.CreateMissionUseCase>()),
    );
    gh.factory<_i1031.LoginBloc>(
      () => blocModule.loginBloc(
        gh<_i717.LoginUseCase>(),
        gh<_i179.RegisterUseCase>(),
        gh<_i997.ForgotPasswordUseCase>(),
        gh<_i212.ResetPasswordUseCase>(),
        gh<_i581.LogoutUseCase>(),
        gh<_i349.AuthSessionManager>(),
        gh<_i455.UserRepository>(),
      ),
    );
    gh.factory<_i921.GetHomeDataUseCase>(
      () => _i921.GetHomeDataUseCase(
        gh<_i455.UserRepository>(),
        gh<_i381.JourneyRepository>(),
        gh<_i448.MissionRepository>(),
      ),
    );
    gh.factory<_i257.DeleteAccountUseCase>(
      () => _i257.DeleteAccountUseCase(gh<_i455.UserRepository>()),
    );
    gh.factory<_i914.GetBadgesUseCase>(
      () => _i914.GetBadgesUseCase(gh<_i455.UserRepository>()),
    );
    gh.factory<_i822.GetCreditScoreHistoryUseCase>(
      () => _i822.GetCreditScoreHistoryUseCase(gh<_i455.UserRepository>()),
    );
    gh.factory<_i835.GetProfileUseCase>(
      () => _i835.GetProfileUseCase(gh<_i455.UserRepository>()),
    );
    gh.factory<_i283.GetUserUseCase>(
      () => _i283.GetUserUseCase(gh<_i455.UserRepository>()),
    );
    gh.factory<_i59.ListApplicationsUseCase>(
      () => _i59.ListApplicationsUseCase(gh<_i455.UserRepository>()),
    );
    gh.factory<_i745.UpdateLocationUseCase>(
      () => _i745.UpdateLocationUseCase(gh<_i455.UserRepository>()),
    );
    gh.factory<_i549.UpdateProfileUseCase>(
      () => _i549.UpdateProfileUseCase(gh<_i455.UserRepository>()),
    );
    gh.factory<_i937.GetLoginUseCase>(
      () => _i937.GetLoginUseCase(
        gh<_i416.AuthRepository>(),
        gh<_i455.UserRepository>(),
        gh<_i349.AuthSessionManager>(),
      ),
    );
    gh.factory<_i1040.AddJobToCartUseCase>(
      () => _i1040.AddJobToCartUseCase(gh<_i39.JobRepository>()),
    );
    gh.factory<_i250.CreateJobReviewUseCase>(
      () => _i250.CreateJobReviewUseCase(gh<_i39.JobRepository>()),
    );
    gh.factory<_i636.GetJobDetailUseCase>(
      () => _i636.GetJobDetailUseCase(gh<_i39.JobRepository>()),
    );
    gh.factory<_i1027.ListCartItemsUseCase>(
      () => _i1027.ListCartItemsUseCase(gh<_i39.JobRepository>()),
    );
    gh.factory<_i776.ListJobsUseCase>(
      () => _i776.ListJobsUseCase(gh<_i39.JobRepository>()),
    );
    gh.factory<_i28.RemoveJobFromCartUseCase>(
      () => _i28.RemoveJobFromCartUseCase(gh<_i39.JobRepository>()),
    );
    gh.factory<_i853.GetRadarUsersUseCase>(
      () => _i853.GetRadarUsersUseCase(gh<_i1013.FriendRepository>()),
    );
    gh.factory<_i145.ListFriendsUseCase>(
      () => _i145.ListFriendsUseCase(gh<_i1013.FriendRepository>()),
    );
    gh.factory<_i25.ListPendingRequestsUseCase>(
      () => _i25.ListPendingRequestsUseCase(gh<_i1013.FriendRepository>()),
    );
    gh.factory<_i873.RemoveFriendUseCase>(
      () => _i873.RemoveFriendUseCase(gh<_i1013.FriendRepository>()),
    );
    gh.factory<_i699.RespondToFriendRequestUseCase>(
      () => _i699.RespondToFriendRequestUseCase(gh<_i1013.FriendRepository>()),
    );
    gh.factory<_i92.SendFriendRequestUseCase>(
      () => _i92.SendFriendRequestUseCase(gh<_i1013.FriendRepository>()),
    );
    gh.factory<_i384.ProfileBloc>(
      () => blocModule.profileBloc(
        gh<_i835.GetProfileUseCase>(),
        gh<_i549.UpdateProfileUseCase>(),
        gh<_i914.GetBadgesUseCase>(),
        gh<_i822.GetCreditScoreHistoryUseCase>(),
        gh<_i745.UpdateLocationUseCase>(),
        gh<_i257.DeleteAccountUseCase>(),
      ),
    );
    gh.factory<_i906.HomeBloc>(
      () => blocModule.homeBloc(gh<_i921.GetHomeDataUseCase>()),
    );
    gh.factory<_i459.SocialRadarBloc>(
      () => blocModule.socialRadarBloc(
        gh<_i92.SendFriendRequestUseCase>(),
        gh<_i25.ListPendingRequestsUseCase>(),
        gh<_i699.RespondToFriendRequestUseCase>(),
        gh<_i145.ListFriendsUseCase>(),
        gh<_i873.RemoveFriendUseCase>(),
        gh<_i853.GetRadarUsersUseCase>(),
      ),
    );
    gh.factory<_i533.JobMarketBloc>(
      () => blocModule.jobMarketBloc(
        gh<_i776.ListJobsUseCase>(),
        gh<_i636.GetJobDetailUseCase>(),
        gh<_i1040.AddJobToCartUseCase>(),
        gh<_i1027.ListCartItemsUseCase>(),
        gh<_i28.RemoveJobFromCartUseCase>(),
        gh<_i250.CreateJobReviewUseCase>(),
        gh<_i59.ListApplicationsUseCase>(),
      ),
    );
    return this;
  }
}

class _$LocalModule extends _i6.LocalModule {}

class _$DioModule extends _i193.DioModule {}

class _$ApiModule extends _i788.ApiModule {}

class _$AuthModule extends _i406.AuthModule {}

class _$RepositoryModule extends _i317.RepositoryModule {}

class _$RouterModule extends _i671.RouterModule {}

class _$BlocModule extends _i784.BlocModule {}
