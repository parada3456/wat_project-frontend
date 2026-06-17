import 'package:wat_project_frontend/domain/models/user_profile.dart';
import 'package:wat_project_frontend/domain/models/badge.dart';
import 'package:wat_project_frontend/domain/models/credit_record.dart';

abstract class ProfileState {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileSuccess extends ProfileState {
  final UserProfile profile;
  final List<Badge> badges;
  final List<CreditRecord> creditHistory;

  const ProfileSuccess({
    required this.profile,
    required this.badges,
    required this.creditHistory,
  });
}

class ProfileFailure extends ProfileState {
  final String errorMessage;
  const ProfileFailure(this.errorMessage);
}

class DeleteAccountSuccess extends ProfileState {
  const DeleteAccountSuccess();
}
