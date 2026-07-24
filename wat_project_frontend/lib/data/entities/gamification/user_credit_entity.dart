import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/data/entities/user/short_user_entity.dart';
import 'package:wat_project_frontend/domain/models/gamification/user_credit_model.dart';

part 'user_credit_entity.g.dart';

@JsonSerializable()
class UserCreditEntity {
  final int rank;
  final ShortUserEntity user;
  @JsonKey(name: 'credit_score')
  final int creditScore;

  UserCreditEntity({
    required this.rank,
    required this.user,
    required this.creditScore,
  });

  factory UserCreditEntity.fromJson(Map<String, dynamic> json) =>
      _$UserCreditEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserCreditEntityToJson(this);

  UserCreditModel toModel() => UserCreditModel(
        rank: rank,
        userId: user.userId,
        name: user.name ?? '',
        avatarUrl: user.avatarUrl,
        creditScore: creditScore,
      );
}
