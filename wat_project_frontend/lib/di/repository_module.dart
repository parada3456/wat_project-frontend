import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/data/repository_impl/auth_repo_impl.dart';
import 'package:wat_project_frontend/data/repository_impl/expense_repo_impl.dart';
import 'package:wat_project_frontend/data/repository_impl/friend_repo_impl.dart';
import 'package:wat_project_frontend/data/repository_impl/job_repo_impl.dart';
import 'package:wat_project_frontend/data/repository_impl/journey_repo_impl.dart';
import 'package:wat_project_frontend/data/repository_impl/mission_repo_impl.dart';
import 'package:wat_project_frontend/data/repository_impl/notification_repo_impl.dart';
import 'package:wat_project_frontend/data/repository_impl/user_repo_impl.dart';
import 'package:wat_project_frontend/data/repository_impl/admin_repo_impl.dart';
import 'package:wat_project_frontend/data/repository_impl/media_repo_impl.dart';
import 'package:wat_project_frontend/domain/repositories/auth_repository.dart';
import 'package:wat_project_frontend/domain/repositories/expense_repository.dart';
import 'package:wat_project_frontend/domain/repositories/friend_repository.dart';
import 'package:wat_project_frontend/domain/repositories/job_repository.dart';
import 'package:wat_project_frontend/domain/repositories/journey_repository.dart';
import 'package:wat_project_frontend/domain/repositories/mission_repository.dart';
import 'package:wat_project_frontend/domain/repositories/notification_repository.dart';
import 'package:wat_project_frontend/domain/repositories/user_repository.dart';
import 'package:wat_project_frontend/domain/repositories/admin_repository.dart';
import 'package:wat_project_frontend/domain/repositories/media_repository.dart';

@module
abstract class RepositoryModule {
  @injectable
  AuthRepository authRepository(AuthRepoImpl impl) => impl;

  @injectable
  ExpenseRepository expenseRepository(ExpenseRepoImpl impl) => impl;

  @injectable
  FriendRepository friendRepository(FriendRepoImpl impl) => impl;

  @injectable
  JobRepository jobRepository(JobRepoImpl impl) => impl;

  @injectable
  JourneyRepository journeyRepository(JourneyRepoImpl impl) => impl;

  @injectable
  MissionRepository missionRepository(MissionRepoImpl impl) => impl;

  @injectable
  NotificationRepository notificationRepository(NotificationRepoImpl impl) =>
      impl;

  @injectable
  UserRepository userRepository(UserRepoImpl impl) => impl;

  @injectable
  AdminRepository adminRepository(AdminRepoImpl impl) => impl;

  @injectable
  MediaRepository mediaRepository(MediaRepoImpl impl) => impl;
}
