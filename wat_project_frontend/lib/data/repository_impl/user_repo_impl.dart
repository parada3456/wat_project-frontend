import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/data/entities/gamification/badge_entity.dart';
import 'package:wat_project_frontend/data/entities/gamification/user_badge_entity.dart';
import 'package:wat_project_frontend/data/entities/gamification/point_ledger_entity.dart';
import 'package:wat_project_frontend/data/entities/user/profile_entity.dart';
import 'package:wat_project_frontend/data/entities/user/user_account_entity.dart';
import 'package:wat_project_frontend/data/entities/user/user_profile_entity.dart';
import 'package:wat_project_frontend/domain/models/user_models.dart';
import 'package:wat_project_frontend/domain/repositories/user_repository.dart';
import 'package:wat_project_frontend/data/sources/api/user_api_client.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/user/update_profile_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/job_review/assign_job_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/user/update_password_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/user/update_settings_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/user/delete_account_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/user/update_location_request.dart';

import 'package:wat_project_frontend/domain/models/gamification_models.dart';
import 'package:wat_project_frontend/domain/models/gamification_models.dart';
@injectable
class UserRepoImpl implements UserRepository {
  final UserApiService _userApi;

  UserRepoImpl(this._userApi);

  @override
  Future<UserProfileEntity> getMe() async {
    return _userApi.getProfile();
  }

  @override
  Future<UserProfileEntity> getProfile() async {
    print("call api get profile");
    return _userApi.getProfile();
  }

  @override
  Future<void> updateProfile(UpdateProfileRequest request) async {
    return _userApi.updateProfile(request);
  }

  @override
  Future<void> updateSettings(Map<String, dynamic> settings) async {
    return _userApi.updateSettings(UpdateSettingsRequest.fromJson(settings));
  }

  @override
  Future<void> deleteAccount(String currentPassword) async {
    return _userApi.deleteAccount(DeleteAccountRequest(currentPassword: currentPassword));
  }

  @override
  Future<ProfileEntity> getUserPublicProfile(String id) async {
    final response = await _userApi.getUserPublicProfile(id);
    return response;
  }

  @override
  Future<List<BadgeEntity>> getBadges() async {
    final response = await _userApi.getBadges();
    return response.data.map((ub) => ub.badge).toList();
  }

  @override
  Future<List<PointLedgerEntity>> getPointsLedger() async {
    final response = await _userApi.getPointsLedger();
    return response.data;
  }

  @override
  Future<List<PointLedgerEntity>> getCreditScoreHistory() async {
    final response = await _userApi.getCreditScoreHistory();
    return response.data;
  }

  @override
  Future<void> updateLocation(double latitude, double longitude) async {
    return _userApi.updateLocation(UpdateLocationRequest(
      latitude: latitude,
      longitude: longitude,
    ));
  }

  @override
  Future<void> assignJob(AssignJobRequest request) async {
    return _userApi.assignJob(request);
  }

  @override
  Future<void> updatePassword(UpdatePasswordRequest request) async {
    return _userApi.updatePassword(request);
  }
}
