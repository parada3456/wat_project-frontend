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
import 'package:wat_project_frontend/domain/usecases/admin/adjust_points_usecase.dart'
    as _i391;
import 'package:wat_project_frontend/domain/usecases/admin/approve_expense_split_payment_usecase.dart'
    as _i161;
import 'package:wat_project_frontend/domain/usecases/admin/get_admin_stats_usecase.dart'
    as _i263;
import 'package:wat_project_frontend/domain/usecases/admin/get_admin_user_detail_usecase.dart'
    as _i130;
import 'package:wat_project_frontend/domain/usecases/admin/get_admin_users_usecase.dart'
    as _i385;
import 'package:wat_project_frontend/domain/usecases/admin/list_pending_verifications_usecase.dart'
    as _i722;
import 'package:wat_project_frontend/domain/usecases/admin/verify_admin_mission_usecase.dart'
    as _i1068;
import 'package:wat_project_frontend/domain/usecases/admin_usecases.dart'
    as _i826;
import 'package:wat_project_frontend/domain/usecases/auth/get_login_usecase.dart'
    as _i689;
import 'package:wat_project_frontend/domain/usecases/auth/google_login_usecase.dart'
    as _i592;
import 'package:wat_project_frontend/domain/usecases/auth/login_usecase.dart'
    as _i890;
import 'package:wat_project_frontend/domain/usecases/auth/logout_usecase.dart'
    as _i113;
import 'package:wat_project_frontend/domain/usecases/auth/refresh_token_usecase.dart'
    as _i568;
import 'package:wat_project_frontend/domain/usecases/auth/register_usecase.dart'
    as _i540;
import 'package:wat_project_frontend/domain/usecases/auth/reset_password_usecase.dart'
    as _i935;
import 'package:wat_project_frontend/domain/usecases/auth_usecases.dart'
    as _i421;
import 'package:wat_project_frontend/domain/usecases/expense/create_expense_usecase.dart'
    as _i31;
import 'package:wat_project_frontend/domain/usecases/expense/delete_expense_usecase.dart'
    as _i520;
import 'package:wat_project_frontend/domain/usecases/expense/get_expense_detail_usecase.dart'
    as _i600;
import 'package:wat_project_frontend/domain/usecases/expense/list_expenses_usecase.dart'
    as _i599;
import 'package:wat_project_frontend/domain/usecases/expense/list_pending_splits_usecase.dart'
    as _i128;
import 'package:wat_project_frontend/domain/usecases/expense/pay_expense_split_usecase.dart'
    as _i1069;
import 'package:wat_project_frontend/domain/usecases/expense_usecases.dart'
    as _i687;
import 'package:wat_project_frontend/domain/usecases/friend/get_radar_users_usecase.dart'
    as _i101;
import 'package:wat_project_frontend/domain/usecases/friend/list_friends_usecase.dart'
    as _i382;
import 'package:wat_project_frontend/domain/usecases/friend/list_pending_requests_usecase.dart'
    as _i1054;
import 'package:wat_project_frontend/domain/usecases/friend/remove_friend_usecase.dart'
    as _i660;
import 'package:wat_project_frontend/domain/usecases/friend/respond_to_friend_request_usecase.dart'
    as _i89;
import 'package:wat_project_frontend/domain/usecases/friend/send_friend_request_usecase.dart'
    as _i78;
import 'package:wat_project_frontend/domain/usecases/friend_usecases.dart'
    as _i807;
import 'package:wat_project_frontend/domain/usecases/gamification/get_badges_usecase.dart'
    as _i882;
import 'package:wat_project_frontend/domain/usecases/gamification/get_leaderboard_usecase.dart'
    as _i229;
import 'package:wat_project_frontend/domain/usecases/gamification_usecases.dart'
    as _i588;
import 'package:wat_project_frontend/domain/usecases/job/add_job_to_cart_usecase.dart'
    as _i234;
import 'package:wat_project_frontend/domain/usecases/job/create_job_review_usecase.dart'
    as _i517;
import 'package:wat_project_frontend/domain/usecases/job/create_job_usecase.dart'
    as _i238;
import 'package:wat_project_frontend/domain/usecases/job/delete_job_usecase.dart'
    as _i265;
import 'package:wat_project_frontend/domain/usecases/job/get_job_detail_usecase.dart'
    as _i57;
import 'package:wat_project_frontend/domain/usecases/job/get_jobs_by_ids_usecase.dart'
    as _i384;
import 'package:wat_project_frontend/domain/usecases/job/list_applications_usecase.dart'
    as _i871;
import 'package:wat_project_frontend/domain/usecases/job/list_cart_items_usecase.dart'
    as _i149;
import 'package:wat_project_frontend/domain/usecases/job/list_job_reviews_usecase.dart'
    as _i366;
import 'package:wat_project_frontend/domain/usecases/job/list_jobs_usecase.dart'
    as _i784;
import 'package:wat_project_frontend/domain/usecases/job/patch_job_usecase.dart'
    as _i84;
import 'package:wat_project_frontend/domain/usecases/job/remove_job_from_cart_usecase.dart'
    as _i481;
import 'package:wat_project_frontend/domain/usecases/job/update_cart_status_usecase.dart'
    as _i650;
import 'package:wat_project_frontend/domain/usecases/job/update_job_usecase.dart'
    as _i966;
import 'package:wat_project_frontend/domain/usecases/job_usecases.dart'
    as _i555;
import 'package:wat_project_frontend/domain/usecases/journey/advance_phase_usecase.dart'
    as _i853;
import 'package:wat_project_frontend/domain/usecases/journey/get_journey_history_usecase.dart'
    as _i792;
import 'package:wat_project_frontend/domain/usecases/journey/list_journey_phases_usecase.dart'
    as _i508;
import 'package:wat_project_frontend/domain/usecases/journey_usecases.dart'
    as _i655;
import 'package:wat_project_frontend/domain/usecases/mission/create_mission_usecase.dart'
    as _i796;
import 'package:wat_project_frontend/domain/usecases/mission/get_explore_mission_usecase.dart'
    as _i11;
import 'package:wat_project_frontend/domain/usecases/mission/get_mission_detail_usecase.dart'
    as _i350;
import 'package:wat_project_frontend/domain/usecases/mission/join_mission_usecase.dart'
    as _i985;
import 'package:wat_project_frontend/domain/usecases/mission/list_3_my_mission_usecase.dart'
    as _i625;
import 'package:wat_project_frontend/domain/usecases/mission/list_all_missions_usecase.dart'
    as _i749;
import 'package:wat_project_frontend/domain/usecases/mission/list_my_missions_usecase.dart'
    as _i640;
import 'package:wat_project_frontend/domain/usecases/mission/submit_mission_proof_usecase.dart'
    as _i166;
import 'package:wat_project_frontend/domain/usecases/mission/toggle_task_usecase.dart'
    as _i362;
import 'package:wat_project_frontend/domain/usecases/mission_usecases.dart'
    as _i936;
import 'package:wat_project_frontend/domain/usecases/notification/delete_notification_usecase.dart'
    as _i1;
import 'package:wat_project_frontend/domain/usecases/notification/list_notifications_usecase.dart'
    as _i322;
import 'package:wat_project_frontend/domain/usecases/notification/mark_all_notifications_read_usecase.dart'
    as _i264;
import 'package:wat_project_frontend/domain/usecases/notification/mark_notification_read_usecase.dart'
    as _i427;
import 'package:wat_project_frontend/domain/usecases/notification_usecases.dart'
    as _i433;
import 'package:wat_project_frontend/domain/usecases/user/delete_account_usecase.dart'
    as _i222;
import 'package:wat_project_frontend/domain/usecases/user/forgot_password_usecase.dart'
    as _i639;
import 'package:wat_project_frontend/domain/usecases/user/get_credit_score_history_usecase.dart'
    as _i297;
import 'package:wat_project_frontend/domain/usecases/user/get_home_data_usecase.dart'
    as _i535;
import 'package:wat_project_frontend/domain/usecases/user/get_profile_usecase.dart'
    as _i1044;
import 'package:wat_project_frontend/domain/usecases/user/get_user_usecase.dart'
    as _i107;
import 'package:wat_project_frontend/domain/usecases/user/update_location_usecase.dart'
    as _i420;
import 'package:wat_project_frontend/domain/usecases/user/update_profile_usecase.dart'
    as _i606;
import 'package:wat_project_frontend/domain/usecases/user_usecases.dart'
    as _i624;
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
    gh.factory<_i592.GoogleLoginUseCase>(
      () => _i592.GoogleLoginUseCase(gh<_i416.AuthRepository>()),
    );
    gh.factory<_i890.LoginUseCase>(
      () => _i890.LoginUseCase(gh<_i416.AuthRepository>()),
    );
    gh.factory<_i113.LogoutUseCase>(
      () => _i113.LogoutUseCase(gh<_i416.AuthRepository>()),
    );
    gh.factory<_i568.RefreshTokenUseCase>(
      () => _i568.RefreshTokenUseCase(gh<_i416.AuthRepository>()),
    );
    gh.factory<_i540.RegisterUseCase>(
      () => _i540.RegisterUseCase(gh<_i416.AuthRepository>()),
    );
    gh.factory<_i935.ResetPasswordUseCase>(
      () => _i935.ResetPasswordUseCase(gh<_i416.AuthRepository>()),
    );
    gh.factory<_i639.ForgotPasswordUseCase>(
      () => _i639.ForgotPasswordUseCase(gh<_i416.AuthRepository>()),
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
    gh.factory<_i1.DeleteNotificationUseCase>(
      () => _i1.DeleteNotificationUseCase(gh<_i187.NotificationRepository>()),
    );
    gh.factory<_i322.ListNotificationsUseCase>(
      () => _i322.ListNotificationsUseCase(gh<_i187.NotificationRepository>()),
    );
    gh.factory<_i264.MarkAllNotificationsReadUseCase>(
      () => _i264.MarkAllNotificationsReadUseCase(
        gh<_i187.NotificationRepository>(),
      ),
    );
    gh.factory<_i427.MarkNotificationReadUseCase>(
      () =>
          _i427.MarkNotificationReadUseCase(gh<_i187.NotificationRepository>()),
    );
    gh.factory<_i161.ApproveExpenseSplitPaymentUseCase>(
      () => _i161.ApproveExpenseSplitPaymentUseCase(
        gh<_i1052.ExpenseRepository>(),
      ),
    );
    gh.factory<_i31.CreateExpenseUseCase>(
      () => _i31.CreateExpenseUseCase(gh<_i1052.ExpenseRepository>()),
    );
    gh.factory<_i520.DeleteExpenseUseCase>(
      () => _i520.DeleteExpenseUseCase(gh<_i1052.ExpenseRepository>()),
    );
    gh.factory<_i600.GetExpenseDetailUseCase>(
      () => _i600.GetExpenseDetailUseCase(gh<_i1052.ExpenseRepository>()),
    );
    gh.factory<_i599.ListExpensesUseCase>(
      () => _i599.ListExpensesUseCase(gh<_i1052.ExpenseRepository>()),
    );
    gh.factory<_i128.ListPendingSplitsUseCase>(
      () => _i128.ListPendingSplitsUseCase(gh<_i1052.ExpenseRepository>()),
    );
    gh.factory<_i1069.PayExpenseSplitUseCase>(
      () => _i1069.PayExpenseSplitUseCase(gh<_i1052.ExpenseRepository>()),
    );
    gh.factory<_i229.GetLeaderboardUseCase>(
      () => _i229.GetLeaderboardUseCase(gh<_i381.JourneyRepository>()),
    );
    gh.factory<_i853.AdvancePhaseUseCase>(
      () => _i853.AdvancePhaseUseCase(gh<_i381.JourneyRepository>()),
    );
    gh.factory<_i792.GetJourneyHistoryUseCase>(
      () => _i792.GetJourneyHistoryUseCase(gh<_i381.JourneyRepository>()),
    );
    gh.factory<_i508.ListJourneyPhasesUseCase>(
      () => _i508.ListJourneyPhasesUseCase(gh<_i381.JourneyRepository>()),
    );
    gh.factory<_i796.CreateMissionUseCase>(
      () => _i796.CreateMissionUseCase(gh<_i448.MissionRepository>()),
    );
    gh.factory<_i11.GetExploreMissionUseCase>(
      () => _i11.GetExploreMissionUseCase(gh<_i448.MissionRepository>()),
    );
    gh.factory<_i350.GetMissionDetailUseCase>(
      () => _i350.GetMissionDetailUseCase(gh<_i448.MissionRepository>()),
    );
    gh.factory<_i985.JoinMissionUseCase>(
      () => _i985.JoinMissionUseCase(gh<_i448.MissionRepository>()),
    );
    gh.factory<_i625.ListMyMissionsUseCase>(
      () => _i625.ListMyMissionsUseCase(gh<_i448.MissionRepository>()),
    );
    gh.factory<_i749.ListAllMissionsUseCase>(
      () => _i749.ListAllMissionsUseCase(gh<_i448.MissionRepository>()),
    );
    gh.factory<_i640.ListMyMissionsUseCase>(
      () => _i640.ListMyMissionsUseCase(gh<_i448.MissionRepository>()),
    );
    gh.factory<_i166.SubmitMissionProofUseCase>(
      () => _i166.SubmitMissionProofUseCase(gh<_i448.MissionRepository>()),
    );
    gh.factory<_i362.ToggleTaskUseCase>(
      () => _i362.ToggleTaskUseCase(gh<_i448.MissionRepository>()),
    );
    gh.factory<_i384.ExpenseSharingBloc>(
      () => blocModule.expenseSharingBloc(
        gh<_i687.ListExpensesUseCase>(),
        gh<_i687.CreateExpenseUseCase>(),
        gh<_i687.GetExpenseDetailUseCase>(),
        gh<_i687.DeleteExpenseUseCase>(),
        gh<_i687.ListPendingSplitsUseCase>(),
        gh<_i687.PayExpenseSplitUseCase>(),
        gh<_i826.ApproveExpenseSplitPaymentUseCase>(),
      ),
    );
    gh.factory<_i244.AdminRepository>(
      () => repositoryModule.adminRepository(gh<_i789.AdminRepoImpl>()),
    );
    gh.factory<_i391.AdjustPointsUseCase>(
      () => _i391.AdjustPointsUseCase(gh<_i244.AdminRepository>()),
    );
    gh.factory<_i263.GetAdminStatsUseCase>(
      () => _i263.GetAdminStatsUseCase(gh<_i244.AdminRepository>()),
    );
    gh.factory<_i130.GetAdminUserDetailUseCase>(
      () => _i130.GetAdminUserDetailUseCase(gh<_i244.AdminRepository>()),
    );
    gh.factory<_i385.GetAdminUsersUseCase>(
      () => _i385.GetAdminUsersUseCase(gh<_i244.AdminRepository>()),
    );
    gh.factory<_i722.ListPendingVerificationsUseCase>(
      () => _i722.ListPendingVerificationsUseCase(gh<_i244.AdminRepository>()),
    );
    gh.factory<_i1068.VerifyAdminMissionUseCase>(
      () => _i1068.VerifyAdminMissionUseCase(gh<_i244.AdminRepository>()),
    );
    gh.factory<_i455.UserRepository>(
      () => repositoryModule.userRepository(gh<_i399.UserRepoImpl>()),
    );
    gh.factory<_i282.CreateMissionBloc>(
      () => blocModule.createMissionBloc(gh<_i936.CreateMissionUseCase>()),
    );
    gh.factory<_i392.NotificationsBloc>(
      () => blocModule.notificationsBloc(
        gh<_i433.ListNotificationsUseCase>(),
        gh<_i433.MarkNotificationReadUseCase>(),
        gh<_i433.MarkAllNotificationsReadUseCase>(),
        gh<_i433.DeleteNotificationUseCase>(),
      ),
    );
    gh.factory<_i39.JobRepository>(
      () => repositoryModule.jobRepository(gh<_i451.JobRepoImpl>()),
    );
    gh.factory<_i1054.JourneyGamificationBloc>(
      () => blocModule.journeyGamificationBloc(
        gh<_i655.ListJourneyPhasesUseCase>(),
        gh<_i655.AdvancePhaseUseCase>(),
        gh<_i655.GetJourneyHistoryUseCase>(),
        gh<_i588.GetLeaderboardUseCase>(),
      ),
    );
    gh.factory<_i535.GetHomeDataUseCase>(
      () => _i535.GetHomeDataUseCase(
        gh<_i455.UserRepository>(),
        gh<_i381.JourneyRepository>(),
        gh<_i448.MissionRepository>(),
      ),
    );
    gh.factory<_i882.GetBadgesUseCase>(
      () => _i882.GetBadgesUseCase(gh<_i455.UserRepository>()),
    );
    gh.factory<_i871.ListApplicationsUseCase>(
      () => _i871.ListApplicationsUseCase(gh<_i455.UserRepository>()),
    );
    gh.factory<_i222.DeleteAccountUseCase>(
      () => _i222.DeleteAccountUseCase(gh<_i455.UserRepository>()),
    );
    gh.factory<_i297.GetCreditScoreHistoryUseCase>(
      () => _i297.GetCreditScoreHistoryUseCase(gh<_i455.UserRepository>()),
    );
    gh.factory<_i1044.GetProfileUseCase>(
      () => _i1044.GetProfileUseCase(gh<_i455.UserRepository>()),
    );
    gh.factory<_i107.GetUserUseCase>(
      () => _i107.GetUserUseCase(gh<_i455.UserRepository>()),
    );
    gh.factory<_i420.UpdateLocationUseCase>(
      () => _i420.UpdateLocationUseCase(gh<_i455.UserRepository>()),
    );
    gh.factory<_i606.UpdateProfileUseCase>(
      () => _i606.UpdateProfileUseCase(gh<_i455.UserRepository>()),
    );
    gh.factory<_i689.GetLoginUseCase>(
      () => _i689.GetLoginUseCase(
        gh<_i416.AuthRepository>(),
        gh<_i455.UserRepository>(),
        gh<_i349.AuthSessionManager>(),
      ),
    );
    gh.factory<_i234.AddJobToCartUseCase>(
      () => _i234.AddJobToCartUseCase(gh<_i39.JobRepository>()),
    );
    gh.factory<_i517.CreateJobReviewUseCase>(
      () => _i517.CreateJobReviewUseCase(gh<_i39.JobRepository>()),
    );
    gh.factory<_i238.CreateJobUseCase>(
      () => _i238.CreateJobUseCase(gh<_i39.JobRepository>()),
    );
    gh.factory<_i265.DeleteJobUseCase>(
      () => _i265.DeleteJobUseCase(gh<_i39.JobRepository>()),
    );
    gh.factory<_i57.GetJobDetailUseCase>(
      () => _i57.GetJobDetailUseCase(gh<_i39.JobRepository>()),
    );
    gh.factory<_i384.GetJobsByIdsUseCase>(
      () => _i384.GetJobsByIdsUseCase(gh<_i39.JobRepository>()),
    );
    gh.factory<_i149.ListCartItemsUseCase>(
      () => _i149.ListCartItemsUseCase(gh<_i39.JobRepository>()),
    );
    gh.factory<_i366.ListJobReviewsUseCase>(
      () => _i366.ListJobReviewsUseCase(gh<_i39.JobRepository>()),
    );
    gh.factory<_i784.ListJobsUseCase>(
      () => _i784.ListJobsUseCase(gh<_i39.JobRepository>()),
    );
    gh.factory<_i84.PatchJobUseCase>(
      () => _i84.PatchJobUseCase(gh<_i39.JobRepository>()),
    );
    gh.factory<_i481.RemoveJobFromCartUseCase>(
      () => _i481.RemoveJobFromCartUseCase(gh<_i39.JobRepository>()),
    );
    gh.factory<_i650.UpdateCartStatusUseCase>(
      () => _i650.UpdateCartStatusUseCase(gh<_i39.JobRepository>()),
    );
    gh.factory<_i966.UpdateJobUseCase>(
      () => _i966.UpdateJobUseCase(gh<_i39.JobRepository>()),
    );
    gh.factory<_i101.GetRadarUsersUseCase>(
      () => _i101.GetRadarUsersUseCase(gh<_i1013.FriendRepository>()),
    );
    gh.factory<_i382.ListFriendsUseCase>(
      () => _i382.ListFriendsUseCase(gh<_i1013.FriendRepository>()),
    );
    gh.factory<_i1054.ListPendingRequestsUseCase>(
      () => _i1054.ListPendingRequestsUseCase(gh<_i1013.FriendRepository>()),
    );
    gh.factory<_i660.RemoveFriendUseCase>(
      () => _i660.RemoveFriendUseCase(gh<_i1013.FriendRepository>()),
    );
    gh.factory<_i89.RespondToFriendRequestUseCase>(
      () => _i89.RespondToFriendRequestUseCase(gh<_i1013.FriendRepository>()),
    );
    gh.factory<_i78.SendFriendRequestUseCase>(
      () => _i78.SendFriendRequestUseCase(gh<_i1013.FriendRepository>()),
    );
    gh.factory<_i280.AdminDashboardBloc>(
      () => blocModule.adminDashboardBloc(
        gh<_i826.GetAdminStatsUseCase>(),
        gh<_i826.ListPendingVerificationsUseCase>(),
        gh<_i826.VerifyAdminMissionUseCase>(),
        gh<_i826.GetAdminUsersUseCase>(),
        gh<_i826.GetAdminUserDetailUseCase>(),
        gh<_i826.AdjustPointsUseCase>(),
      ),
    );
    gh.factory<_i906.HomeBloc>(
      () => blocModule.homeBloc(gh<_i624.GetHomeDataUseCase>()),
    );
    gh.factory<_i928.MissionTaskBloc>(
      () => blocModule.missionTaskBloc(
        gh<_i936.ListMyMissionsUseCase>(),
        gh<_i936.GetMissionDetailUseCase>(),
        gh<_i936.SubmitMissionProofUseCase>(),
        gh<_i936.ToggleTaskUseCase>(),
        gh<_i936.GetExploreMissionUseCase>(),
        gh<_i936.JoinMissionUseCase>(),
        gh<_i624.GetProfileUseCase>(),
        gh<_i936.ListAllMissionsUseCase>(),
      ),
    );
    gh.factory<_i1031.LoginBloc>(
      () => blocModule.loginBloc(
        gh<_i421.LoginUseCase>(),
        gh<_i421.RegisterUseCase>(),
        gh<_i624.ForgotPasswordUseCase>(),
        gh<_i421.ResetPasswordUseCase>(),
        gh<_i421.LogoutUseCase>(),
        gh<_i349.AuthSessionManager>(),
        gh<_i455.UserRepository>(),
        gh<_i421.GoogleLoginUseCase>(),
      ),
    );
    gh.factory<_i459.SocialRadarBloc>(
      () => blocModule.socialRadarBloc(
        gh<_i807.SendFriendRequestUseCase>(),
        gh<_i807.ListPendingRequestsUseCase>(),
        gh<_i807.RespondToFriendRequestUseCase>(),
        gh<_i807.ListFriendsUseCase>(),
        gh<_i807.RemoveFriendUseCase>(),
        gh<_i807.GetRadarUsersUseCase>(),
      ),
    );
    gh.factory<_i533.JobMarketBloc>(
      () => blocModule.jobMarketBloc(
        gh<_i555.ListJobsUseCase>(),
        gh<_i555.GetJobDetailUseCase>(),
        gh<_i555.AddJobToCartUseCase>(),
        gh<_i555.ListCartItemsUseCase>(),
        gh<_i555.RemoveJobFromCartUseCase>(),
        gh<_i555.CreateJobReviewUseCase>(),
        gh<_i555.ListApplicationsUseCase>(),
        gh<_i555.ListJobReviewsUseCase>(),
        gh<_i555.UpdateCartStatusUseCase>(),
        gh<_i555.CreateJobUseCase>(),
        gh<_i555.UpdateJobUseCase>(),
        gh<_i555.DeleteJobUseCase>(),
      ),
    );
    gh.factory<_i384.ProfileBloc>(
      () => blocModule.profileBloc(
        gh<_i624.GetProfileUseCase>(),
        gh<_i624.UpdateProfileUseCase>(),
        gh<_i588.GetBadgesUseCase>(),
        gh<_i624.GetCreditScoreHistoryUseCase>(),
        gh<_i624.UpdateLocationUseCase>(),
        gh<_i624.DeleteAccountUseCase>(),
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
