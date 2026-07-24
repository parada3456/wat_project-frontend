import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/domain/models/expense_models.dart';

part 'expense_split_entity.g.dart';

@JsonSerializable()
class ExpenseSplitEntity {
  @JsonKey(name: 'split_id')
  final String splitId;
  @JsonKey(name: 'transaction_id')
  final String transactionId;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'owe_amount')
  final double oweAmount;
  @JsonKey(name: 'payment_status')
  final PaymentStatus paymentStatus;
  @JsonKey(name: 'payment_method')
  final String? paymentMethod;
  @JsonKey(name: 'payslip_url')
  final String? payslipUrl;
  @JsonKey(name: 'approval_status')
  final ApprovalStatus approvalStatus;
  @JsonKey(name: 'settled_at')
  final DateTime? settledAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  ExpenseSplitEntity({
    required this.splitId,
    required this.transactionId,
    required this.userId,
    required this.oweAmount,
    required this.paymentStatus,
    this.paymentMethod,
    this.payslipUrl,
    required this.approvalStatus,
    this.settledAt,
    required this.updatedAt,
  });

  factory ExpenseSplitEntity.fromJson(Map<String, dynamic> json) =>
      _$ExpenseSplitEntityFromJson(json);
  Map<String, dynamic> toJson() => _$ExpenseSplitEntityToJson(this);

  ExpenseSplitModel toModel() => ExpenseSplitModel(
    splitId: splitId,
    transactionId: transactionId,
    userId: userId,
    oweAmount: oweAmount,
    paymentStatus: paymentStatus,
    paymentMethod: paymentMethod,
    payslipUrl: payslipUrl,
    approvalStatus: approvalStatus,
    settledAt: settledAt,
    updatedAt: updatedAt,
  );
}
