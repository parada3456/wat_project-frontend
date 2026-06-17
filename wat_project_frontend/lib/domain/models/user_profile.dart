import 'package:wat_project_frontend/domain/models/user_model.dart';
import 'package:wat_project_frontend/domain/models/profile_model.dart';
import 'package:wat_project_frontend/domain/models/credit_score_model.dart';

class UserProfile {
  final UserModel user;
  final ProfileModel profile;
  final CreditScoreModel creditScore;

  const UserProfile({
    required this.user,
    required this.profile,
    required this.creditScore,
  });
}
