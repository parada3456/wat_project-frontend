import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/domain/models/gamification_models.dart';

part 'badge_entity.g.dart';

@JsonSerializable()
class BadgeEntity {
  @JsonKey(name: 'badge_id')
  final String badgeId;
  final String title;
  final String? description;
  @JsonKey(name: 'trigger_type')
  final BadgeTriggerType triggerType;
  @JsonKey(name: 'icon_url')
  final String? iconUrl;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  BadgeEntity({
    required this.badgeId,
    required this.title,
    this.description,
    required this.triggerType,
    this.iconUrl,
    required this.createdAt,
  });

  factory BadgeEntity.fromJson(Map<String, dynamic> json) =>
      _$BadgeEntityFromJson(json);
  Map<String, dynamic> toJson() => _$BadgeEntityToJson(this);

  BadgeModel toModel() => BadgeModel(
    badgeId: badgeId,
    title: title,
    description: description,
    triggerType: triggerType,
    iconUrl: iconUrl,
    createdAt: createdAt,
  );
}
