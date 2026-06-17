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
import 'package:wat_project_frontend/data/repository_impl/mission_repo_impl.dart'
    as _i1043;
import 'package:wat_project_frontend/data/repository_impl/notification_repo_impl.dart'
    as _i590;
import 'package:wat_project_frontend/data/repository_impl/user_repo_impl.dart'
    as _i399;
import 'package:wat_project_frontend/data/sources/api/api_client.dart' as _i904;
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
import 'package:wat_project_frontend/domain/repositories/mission_repository.dart'
    as _i448;
import 'package:wat_project_frontend/domain/repositories/notification_repository.dart'
    as _i187;
import 'package:wat_project_frontend/domain/repositories/user_repository.dart'
    as _i455;
import 'package:wat_project_frontend/domain/services/auth_manager.dart'
    as _i349;
import 'package:wat_project_frontend/domain/usecases/delete_account_usecase.dart'
    as _i257;
import 'package:wat_project_frontend/domain/usecases/forgot_password_usecase.dart'
    as _i997;
import 'package:wat_project_frontend/domain/usecases/get_badges_usecase.dart'
    as _i914;
import 'package:wat_project_frontend/domain/usecases/get_credit_score_history_usecase.dart'
    as _i822;
import 'package:wat_project_frontend/domain/usecases/get_login_usecase.dart'
    as _i937;
import 'package:wat_project_frontend/domain/usecases/get_posts_usecase.dart'
    as _i374;
import 'package:wat_project_frontend/domain/usecases/get_profile_usecase.dart'
    as _i835;
import 'package:wat_project_frontend/domain/usecases/get_user_usecase.dart'
    as _i283;
import 'package:wat_project_frontend/domain/usecases/login_usecase.dart'
    as _i717;
import 'package:wat_project_frontend/domain/usecases/logout_usecase.dart'
    as _i581;
import 'package:wat_project_frontend/domain/usecases/refresh_token_usecase.dart'
    as _i743;
import 'package:wat_project_frontend/domain/usecases/register_usecase.dart'
    as _i179;
import 'package:wat_project_frontend/domain/usecases/reset_password_usecase.dart'
    as _i212;
import 'package:wat_project_frontend/domain/usecases/update_location_usecase.dart'
    as _i745;
import 'package:wat_project_frontend/domain/usecases/update_profile_usecase.dart'
    as _i549;
import 'package:wat_project_frontend/presentation/auth_profile/login/bloc/login_bloc.dart'
    as _i1031;
import 'package:wat_project_frontend/presentation/auth_profile/profile/bloc/profile_bloc.dart'
    as _i384;
import 'package:wat_project_frontend/presentation/home/bloc/home_bloc.dart'
    as _i906;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final localModule = _$LocalModule();
    final dioModule = _$DioModule();
    final blocModule = _$BlocModule();
    final apiModule = _$ApiModule();
    final authModule = _$AuthModule();
    final repositoryModule = _$RepositoryModule();
    final routerModule = _$RouterModule();
    gh.factory<_i374.GetPostsUseCase>(() => _i374.GetPostsUseCase());
    gh.lazySingleton<_i558.FlutterSecureStorage>(() => localModule.storage);
    gh.lazySingleton<_i455.LocaleProvider>(() => _i455.LocaleProvider());
    gh.lazySingleton<_i634.ThemeProvider>(() => _i634.ThemeProvider());
    gh.lazySingleton<_i361.Dio>(
      () => dioModule.authDio(),
      instanceName: 'authDio',
    );
    gh.factory<_i906.HomeBloc>(
      () => blocModule.homeBloc(gh<_i374.GetPostsUseCase>()),
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
    gh.lazySingleton<_i904.ApiService>(
      () => apiModule.mainApi(gh<_i361.Dio>(instanceName: 'mainDio')),
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
    gh.singleton<_i583.GoRouter>(
      () => routerModule.router(gh<_i349.AuthSessionManager>()),
    );
    gh.factory<_i451.JobRepoImpl>(
      () => _i451.JobRepoImpl(gh<_i388.JobApiService>()),
    );
    gh.factory<_i399.UserRepoImpl>(
      () => _i399.UserRepoImpl(
        gh<_i904.ApiService>(),
        gh<_i165.UserApiService>(),
      ),
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
    gh.factory<_i381.JourneyRepository>(
      () => repositoryModule.journeyRepository(gh<_i864.JourneyRepoImpl>()),
    );
    gh.factory<_i1013.FriendRepository>(
      () => repositoryModule.friendRepository(gh<_i337.FriendRepoImpl>()),
    );
    gh.factory<_i455.UserRepository>(
      () => repositoryModule.userRepository(gh<_i399.UserRepoImpl>()),
    );
    gh.factory<_i39.JobRepository>(
      () => repositoryModule.jobRepository(gh<_i451.JobRepoImpl>()),
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
    return this;
  }
}

class _$LocalModule extends _i6.LocalModule {}

class _$DioModule extends _i193.DioModule {}

class _$BlocModule extends _i784.BlocModule {}

class _$ApiModule extends _i788.ApiModule {}

class _$AuthModule extends _i406.AuthModule {}

class _$RepositoryModule extends _i317.RepositoryModule {}

class _$RouterModule extends _i671.RouterModule {}
