import 'package:json_annotation/json_annotation.dart';

part 'user_badge_model.g.dart';

@JsonSerializable()
class UserBadgeModel {
  final String userBadgeId;
  final String userId;
  final String badgeId;
  final String? sourceId;
  final DateTime earnedAt;

  const UserBadgeModel({
    required this.userBadgeId,
    required this.userId,
    required this.badgeId,
    this.sourceId,
    required this.earnedAt,
  });

  factory UserBadgeModel.fromJson(Map<String, dynamic> json) =>
      _$UserBadgeModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserBadgeModelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserBadgeModel &&
          runtimeType == other.runtimeType &&
          userBadgeId == other.userBadgeId &&
          userId == other.userId &&
          badgeId == other.badgeId &&
          sourceId == other.sourceId &&
          earnedAt == other.earnedAt;

  @override
  int get hashCode => Object.hash(
        userBadgeId,
        userId,
        badgeId,
        sourceId,
        earnedAt,
      );
}
