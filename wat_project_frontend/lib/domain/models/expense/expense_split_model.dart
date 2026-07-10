import 'package:json_annotation/json_annotation.dart';

part 'expense_split_model.g.dart';

enum PaymentStatus {
  @JsonValue('Pending')
  pending,
  @JsonValue('Submitted')
  submitted,
  @JsonValue('Approved')
  approved,
  @JsonValue('Overdue')
  overdue,
}

enum ApprovalStatus {
  @JsonValue('Pending_Approval')
  pendingApproval,
  @JsonValue('Approved')
  approved,
  @JsonValue('Rejected')
  rejected,
}

@JsonSerializable()
class ExpenseSplitModel {
  final String splitId;
  final String transactionId;
  final String userId;
  final double oweAmount;
  final PaymentStatus paymentStatus;
  final String? paymentMethod;
  final String? payslipUrl;
  final ApprovalStatus approvalStatus;
  final DateTime? settledAt;
  final DateTime updatedAt;

  const ExpenseSplitModel({
    required this.splitId,
    required this.transactionId,
    required this.userId,
    required this.oweAmount,
    this.paymentStatus = PaymentStatus.pending,
    this.paymentMethod,
    this.payslipUrl,
    this.approvalStatus = ApprovalStatus.pendingApproval,
    this.settledAt,
    required this.updatedAt,
  });

  factory ExpenseSplitModel.fromJson(Map<String, dynamic> json) =>
      _$ExpenseSplitModelFromJson(json);
  Map<String, dynamic> toJson() => _$ExpenseSplitModelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseSplitModel &&
          runtimeType == other.runtimeType &&
          splitId == other.splitId &&
          transactionId == other.transactionId &&
          userId == other.userId &&
          oweAmount == other.oweAmount &&
          paymentStatus == other.paymentStatus &&
          paymentMethod == other.paymentMethod &&
          payslipUrl == other.payslipUrl &&
          approvalStatus == other.approvalStatus &&
          settledAt == other.settledAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode => Object.hash(
    splitId,
    transactionId,
    userId,
    oweAmount,
    paymentStatus,
    paymentMethod,
    payslipUrl,
    approvalStatus,
    settledAt,
    updatedAt,
  );
}
