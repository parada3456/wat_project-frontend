// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_split_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseSplitEntity _$ExpenseSplitEntityFromJson(
  Map<String, dynamic> json,
) => ExpenseSplitEntity(
  splitId: json['split_id'] as String,
  transactionId: json['transaction_id'] as String,
  userId: json['user_id'] as String,
  oweAmount: (json['owe_amount'] as num).toDouble(),
  paymentStatus: $enumDecode(_$PaymentStatusEnumMap, json['payment_status']),
  paymentMethod: json['payment_method'] as String?,
  payslipUrl: json['payslip_url'] as String?,
  approvalStatus: $enumDecode(_$ApprovalStatusEnumMap, json['approval_status']),
  settledAt: json['settled_at'] as String?,
  updatedAt: json['updated_at'] as String,
);

Map<String, dynamic> _$ExpenseSplitEntityToJson(ExpenseSplitEntity instance) =>
    <String, dynamic>{
      'split_id': instance.splitId,
      'transaction_id': instance.transactionId,
      'user_id': instance.userId,
      'owe_amount': instance.oweAmount,
      'payment_status': _$PaymentStatusEnumMap[instance.paymentStatus]!,
      'payment_method': instance.paymentMethod,
      'payslip_url': instance.payslipUrl,
      'approval_status': _$ApprovalStatusEnumMap[instance.approvalStatus]!,
      'settled_at': instance.settledAt,
      'updated_at': instance.updatedAt,
    };

const _$PaymentStatusEnumMap = {
  PaymentStatus.pending: 'Pending',
  PaymentStatus.submitted: 'Submitted',
  PaymentStatus.approved: 'Approved',
  PaymentStatus.overdue: 'Overdue',
};

const _$ApprovalStatusEnumMap = {
  ApprovalStatus.pendingApproval: 'Pending_Approval',
  ApprovalStatus.approved: 'Approved',
  ApprovalStatus.rejected: 'Rejected',
};
