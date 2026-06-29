import 'package:wat_project_frontend/data/entities/user/profile_entity.dart';
import 'package:wat_project_frontend/data/entities/user/user_account_entity.dart';
import 'package:wat_project_frontend/data/entities/user/user_profile_entity.dart';
import 'package:wat_project_frontend/domain/models/user_model.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/user/update_profile_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/job_review/assign_job_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/user/update_password_request.dart';
import 'package:wat_project_frontend/domain/models/badge_model.dart';
import 'package:wat_project_frontend/domain/models/point_ledger_model.dart';

abstract class UserRepository {
  Future<UserProfileEntity> getMe();
  Future<UserProfileEntity> getProfile();
  Future<void> updateProfile(UpdateProfileRequest request);
  Future<void> updateSettings(Map<String, dynamic> settings);
  Future<void> deleteAccount(String currentPassword);
  Future<ProfileEntity> getUserPublicProfile(String id);
  Future<List<BadgeModel>> getBadges();
  Future<List<PointLedgerModel>> getPointsLedger();
  Future<List<PointLedgerModel>> getCreditScoreHistory();
  Future<void> updateLocation(double latitude, double longitude);
  Future<void> assignJob(AssignJobRequest request);
  Future<void> updatePassword(UpdatePasswordRequest request);
}
