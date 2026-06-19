class PointsAdjustmentResultModel {
  final String userId;
  final int lifetimeBalanceAfter;
  final int phaseBalanceAfter;
  final String ledgerId;

  const PointsAdjustmentResultModel({
    required this.userId,
    required this.lifetimeBalanceAfter,
    required this.phaseBalanceAfter,
    required this.ledgerId,
  });
}
