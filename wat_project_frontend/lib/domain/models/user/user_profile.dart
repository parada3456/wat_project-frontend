import 'package:wat_project_frontend/domain/models/user_models.dart';
import 'package:wat_project_frontend/domain/models/user_models.dart';
import 'package:wat_project_frontend/domain/models/user_models.dart';
import 'package:wat_project_frontend/domain/models/job_models.dart';

class UserProfileModel {
  final UserModel user;
  final ProfileModel profile;
  final CreditScoreModel creditScore;
  final List<UserJobModel> userJobs;

  const UserProfileModel({
    required this.user,
    required this.profile,
    required this.creditScore,
    required this.userJobs,
  });
}
