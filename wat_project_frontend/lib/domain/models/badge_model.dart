import 'package:json_annotation/json_annotation.dart';

part 'badge_model.g.dart';

enum BadgeTriggerType {
  @JsonValue('speed')
  speed,
  @JsonValue('streak')
  streak,
  @JsonValue('first_completer')
  firstCompleter,
  @JsonValue('phase_complete')
  phaseComplete,
  @JsonValue('manual')
  manual,
}

@JsonSerializable()
class BadgeModel {
  final String badgeId;
  final String title;
  final String? description;
  final BadgeTriggerType triggerType;
  final String? iconUrl;
  final DateTime createdAt;

  const BadgeModel({
    required this.badgeId,
    required this.title,
    this.description,
    required this.triggerType,
    this.iconUrl,
    required this.createdAt,
  });

  factory BadgeModel.fromJson(Map<String, dynamic> json) => _$BadgeModelFromJson(json);
  Map<String, dynamic> toJson() => _$BadgeModelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BadgeModel &&
          runtimeType == other.runtimeType &&
          badgeId == other.badgeId &&
          title == other.title &&
          description == other.description &&
          triggerType == other.triggerType &&
          iconUrl == other.iconUrl &&
          createdAt == other.createdAt;

  @override
  int get hashCode => Object.hash(
        badgeId,
        title,
        description,
        triggerType,
        iconUrl,
        createdAt,
      );
}
