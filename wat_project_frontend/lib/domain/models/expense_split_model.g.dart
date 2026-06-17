// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_split_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseSplitModel _$ExpenseSplitModelFromJson(Map<String, dynamic> json) =>
    ExpenseSplitModel(
      splitId: json['splitId'] as String,
      transactionId: json['transactionId'] as String,
      userId: json['userId'] as String,
      oweAmount: (json['oweAmount'] as num).toDouble(),
      paymentStatus:
          $enumDecodeNullable(_$PaymentStatusEnumMap, json['paymentStatus']) ??
          PaymentStatus.pending,
      paymentMethod: json['paymentMethod'] as String?,
      payslipUrl: json['payslipUrl'] as String?,
      approvalStatus:
          $enumDecodeNullable(
            _$ApprovalStatusEnumMap,
            json['approvalStatus'],
          ) ??
          ApprovalStatus.pendingApproval,
      settledAt: json['settledAt'] == null
          ? null
          : DateTime.parse(json['settledAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ExpenseSplitModelToJson(ExpenseSplitModel instance) =>
    <String, dynamic>{
      'splitId': instance.splitId,
      'transactionId': instance.transactionId,
      'userId': instance.userId,
      'oweAmount': instance.oweAmount,
      'paymentStatus': _$PaymentStatusEnumMap[instance.paymentStatus]!,
      'paymentMethod': instance.paymentMethod,
      'payslipUrl': instance.payslipUrl,
      'approvalStatus': _$ApprovalStatusEnumMap[instance.approvalStatus]!,
      'settledAt': instance.settledAt?.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
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
