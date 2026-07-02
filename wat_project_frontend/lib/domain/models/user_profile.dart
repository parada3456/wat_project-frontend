import 'package:wat_project_frontend/domain/models/user_model.dart';
import 'package:wat_project_frontend/domain/models/profile_model.dart';
import 'package:wat_project_frontend/domain/models/credit_score_model.dart';
import 'package:wat_project_frontend/domain/models/user_job_model.dart';

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
