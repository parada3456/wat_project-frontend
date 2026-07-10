import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/routes/app_router.dart';
import 'package:wat_project_frontend/domain/services/auth_manager.dart';

@module
abstract class RouterModule {
  @singleton
  GoRouter router(AuthSessionManager authManager) =>
      AppRouter(authManager).router;
}
