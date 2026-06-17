import 'package:wat_project_frontend/domain/models/user_model.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/user_profile_response.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/update_profile_request.dart';
import 'package:wat_project_frontend/domain/models/badge_model.dart';
import 'package:wat_project_frontend/domain/models/point_ledger_model.dart';

abstract class UserRepository {
  Future<UserModel> getMe();
  Future<UserProfileResponse> getProfile();
  Future<void> updateProfile(UpdateProfileRequest request);
  Future<void> updateSettings(Map<String, dynamic> settings);
  Future<void> deleteAccount(String currentPassword);
  Future<List<BadgeModel>> getBadges();
  Future<List<PointLedgerModel>> getCreditScoreHistory();
  Future<void> updateLocation(double latitude, double longitude);
}
