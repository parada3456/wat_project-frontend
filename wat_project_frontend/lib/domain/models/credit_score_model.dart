import 'package:json_annotation/json_annotation.dart';

part 'credit_score_model.g.dart';

@JsonSerializable()
class CreditScoreModel {
  final String creditId;
  final String userId;
  @JsonKey(defaultValue: 100)
  final int currentScore;
  final DateTime lastUpdated;

  const CreditScoreModel({
    required this.creditId,
    required this.userId,
    this.currentScore = 100,
    required this.lastUpdated,
  });

  factory CreditScoreModel.fromJson(Map<String, dynamic> json) =>
      _$CreditScoreModelFromJson(json);
  Map<String, dynamic> toJson() => _$CreditScoreModelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreditScoreModel &&
          runtimeType == other.runtimeType &&
          creditId == other.creditId &&
          userId == other.userId &&
          currentScore == other.currentScore &&
          lastUpdated == other.lastUpdated;

  @override
  int get hashCode => Object.hash(creditId, userId, currentScore, lastUpdated);
}
