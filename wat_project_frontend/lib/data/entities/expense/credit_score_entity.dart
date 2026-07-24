import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/domain/models/user_models.dart';

part 'credit_score_entity.g.dart';

@JsonSerializable()
class CreditScoreEntity {
  @JsonKey(name: 'credit_id')
  final String creditId;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'current_score')
  final int currentScore;
  @JsonKey(name: 'last_updated')
  final DateTime lastUpdated;

  CreditScoreEntity({
    required this.creditId,
    required this.userId,
    required this.currentScore,
    required this.lastUpdated,
  });

  factory CreditScoreEntity.fromJson(Map<String, dynamic> json) =>
      _$CreditScoreEntityFromJson(json);
  Map<String, dynamic> toJson() => _$CreditScoreEntityToJson(this);

  CreditScoreModel toModel() => CreditScoreModel(
    creditId: creditId,
    userId: userId,
    currentScore: currentScore,
    lastUpdated: lastUpdated,
  );
}
