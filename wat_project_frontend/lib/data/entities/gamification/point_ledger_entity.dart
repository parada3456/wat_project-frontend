import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/domain/models/point_ledger_model.dart';

part 'point_ledger_entity.g.dart';

@JsonSerializable()
class PointLedgerEntity {
  @JsonKey(name: 'ledger_id')
  final String ledgerId;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'source_type')
  final PointSourceType sourceType;
  @JsonKey(name: 'source_id')
  final String sourceId;
  final int delta;
  @JsonKey(name: 'lifetime_balance_after')
  final int lifetimeBalanceAfter;
  @JsonKey(name: 'phase_balance_after')
  final int phaseBalanceAfter;
  final String? note;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  PointLedgerEntity({
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

  factory PointLedgerEntity.fromJson(Map<String, dynamic> json) => _$PointLedgerEntityFromJson(json);
  Map<String, dynamic> toJson() => _$PointLedgerEntityToJson(this);

  PointLedgerModel toModel() => PointLedgerModel(
        ledgerId: ledgerId,
        userId: userId,
        sourceType: sourceType,
        sourceId: sourceId,
        delta: delta,
        lifetimeBalanceAfter: lifetimeBalanceAfter,
        phaseBalanceAfter: phaseBalanceAfter,
        note: note,
        createdAt: createdAt,
      );
}
