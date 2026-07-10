import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/domain/models/admin_models.dart';

part 'points_adjustment_result_entity.g.dart';

@JsonSerializable()
class PointsAdjustmentResultEntity {
  final String userId;
  final int lifetimeBalanceAfter;
  final int phaseBalanceAfter;
  final String ledgerId;

  PointsAdjustmentResultEntity({
    required this.userId,
    required this.lifetimeBalanceAfter,
    required this.phaseBalanceAfter,
    required this.ledgerId,
  });

  factory PointsAdjustmentResultEntity.fromJson(Map<String, dynamic> json) =>
      _$PointsAdjustmentResultEntityFromJson(json);
  Map<String, dynamic> toJson() => _$PointsAdjustmentResultEntityToJson(this);

  PointsAdjustmentResultModel toModel() => PointsAdjustmentResultModel(
    userId: userId,
    lifetimeBalanceAfter: lifetimeBalanceAfter,
    phaseBalanceAfter: phaseBalanceAfter,
    ledgerId: ledgerId,
  );
}
