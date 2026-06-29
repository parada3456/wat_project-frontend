import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/domain/models/user_badge_model.dart';

part 'user_badge_entity.g.dart';

@JsonSerializable()
class UserBadgeEntity {
  @JsonKey(name: 'user_badge_id')
  final String userBadgeId;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'badge_id')
  final String badgeId;
  @JsonKey(name: 'source_id')
  final String? sourceId;
  @JsonKey(name: 'earned_at')
  final DateTime earnedAt;

  UserBadgeEntity({
    required this.userBadgeId,
    required this.userId,
    required this.badgeId,
    this.sourceId,
    required this.earnedAt,
  });

  factory UserBadgeEntity.fromJson(Map<String, dynamic> json) => _$UserBadgeEntityFromJson(json);
  Map<String, dynamic> toJson() => _$UserBadgeEntityToJson(this);

  UserBadgeModel toModel() => UserBadgeModel(
        userBadgeId: userBadgeId,
        userId: userId,
        badgeId: badgeId,
        sourceId: sourceId,
        earnedAt: earnedAt,
      );
}
