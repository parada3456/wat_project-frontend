import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/domain/models/user_model.dart';
import 'package:wat_project_frontend/domain/repositories/user_repository.dart';
import 'package:wat_project_frontend/data/sources/api/api_client.dart';
import 'package:wat_project_frontend/data/sources/api/user_api_client.dart';
import 'package:wat_project_frontend/data/entities/auth_profile/profile/user_profile_response.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/user/update_profile_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/job_review/assign_job_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/user/update_password_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/user/update_settings_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/user/delete_account_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/user/update_location_request.dart';

import 'package:wat_project_frontend/domain/models/badge_model.dart';
import 'package:wat_project_frontend/domain/models/point_ledger_model.dart';
@injectable
class UserRepoImpl implements UserRepository {
  final ApiService _api;
  final UserApiService _userApi;

  UserRepoImpl(this._api, this._userApi);

  @override
  Future<UserModel> getMe() async {
    final response = await _userApi.getProfile();
    return response.user.toModel();
  }

  @override
  Future<UserProfileResponse> getProfile() async {
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
  Future<UserModel> getUserPublicProfile(String id) async {
    final response = await _userApi.getUserPublicProfile(id);
    return response.toModel();
  }

  @override
  Future<List<BadgeModel>> getBadges() async {
    final response = await _userApi.getBadges();
    return response.data.map((e) => e.toModel()).toList();
  }

  @override
  Future<List<PointLedgerModel>> getPointsLedger() async {
    final response = await _userApi.getPointsLedger();
    return response.data.map((e) => e.toModel()).toList();
  }

  @override
  Future<List<PointLedgerModel>> getCreditScoreHistory() async {
    final response = await _userApi.getCreditScoreHistory();
    return response.data.map((e) => e.toModel()).toList();
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
