import 'package:json_annotation/json_annotation.dart';

part 'point_ledger_model.g.dart';

enum PointSourceType {
  @JsonValue('Mission_Base')
  missionBase,
  @JsonValue('Speed_Bonus')
  speedBonus,
  @JsonValue('Streak_Bonus')
  streakBonus,
  @JsonValue('First_Completer')
  firstCompleter,
  @JsonValue('Expense_Penalty')
  expensePenalty,
  @JsonValue('Admin_Adjust')
  adminAdjust,
}

@JsonSerializable()
class PointLedgerModel {
  final String ledgerId;
  final String userId;
  final PointSourceType sourceType;
  final String sourceId;
  final int delta;
  final int lifetimeBalanceAfter;
  final int phaseBalanceAfter;
  final String? note;
  final DateTime createdAt;

  const PointLedgerModel({
    required this.ledgerId,
    required this.userId,
    required this.sourceType,
    required this.sourceId,
    required this.delta,
    required this.lifetimeBalanceAfter,
    required this.phaseBalanceAfter,
    this.note,
    required this.createdAt,
  });

  factory PointLedgerModel.fromJson(Map<String, dynamic> json) =>
      _$PointLedgerModelFromJson(json);

  Map<String, dynamic> toJson() => _$PointLedgerModelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PointLedgerModel &&
          runtimeType == other.runtimeType &&
          ledgerId == other.ledgerId &&
          userId == other.userId &&
          sourceType == other.sourceType &&
          sourceId == other.sourceId &&
          delta == other.delta &&
          lifetimeBalanceAfter == other.lifetimeBalanceAfter &&
          phaseBalanceAfter == other.phaseBalanceAfter &&
          note == other.note &&
          createdAt == other.createdAt;

  @override
  int get hashCode => Object.hash(
        ledgerId,
        userId,
        sourceType,
        sourceId,
        delta,
        lifetimeBalanceAfter,
        phaseBalanceAfter,
        note,
        createdAt,
      );
}
