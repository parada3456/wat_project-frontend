import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/domain/models/credit_score_model.dart';

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
  final String? lastUpdated;

  CreditScoreEntity({
    required this.creditId,
    required this.userId,
    required this.currentScore,
    this.lastUpdated,
  });

  factory CreditScoreEntity.fromJson(Map<String, dynamic> json) =>
      _$CreditScoreEntityFromJson(json);

  CreditScoreModel toModel() => CreditScoreModel(
        creditId: creditId,
        userId: userId,
        currentScore: currentScore,
        lastUpdated: lastUpdated != null ? DateTime.parse(lastUpdated!) : DateTime.now(),
      );
}
