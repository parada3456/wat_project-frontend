import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/data/entities/expense/credit_score_entity.dart';
import 'package:wat_project_frontend/data/entities/job_review/job/assigned_job_entity.dart';
import 'package:wat_project_frontend/data/entities/user/user_account_entity.dart';
import 'package:wat_project_frontend/domain/models/job_models.dart';
import 'package:wat_project_frontend/domain/models/user_models.dart';
import 'package:wat_project_frontend/domain/models/user_models.dart';
import 'package:wat_project_frontend/domain/models/user_models.dart';

part 'user_profile_entity.g.dart';

@JsonSerializable()
class UserProfileEntity {
  @JsonKey(name: 'user')
  final UserAccountEntity userAccount;
  @JsonKey(name: 'credit_score')
  final CreditScoreEntity creditScore;
  @JsonKey(name: 'user_jobs')
  final List<AssignedJobEntity> userJobs;

  UserProfileEntity({
    required this.userAccount,
    required this.creditScore,
    required this.userJobs,
  });

  factory UserProfileEntity.fromJson(Map<String, dynamic> json) => _$UserProfileEntityFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileEntityToJson(this);

  UserProfileModel toModel() => UserProfileModel(
    user: userAccount.toModel(),
    profile: userAccount.toProfileModel(),
    creditScore: creditScore.toModel(),
    userJobs: userJobs.map((job) => job.toModel()).toList()
  );

}
