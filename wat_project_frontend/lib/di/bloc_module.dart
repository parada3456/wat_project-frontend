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
}
