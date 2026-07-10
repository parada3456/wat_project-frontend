import 'package:json_annotation/json_annotation.dart';

part 'create_expense_request.g.dart';

@JsonSerializable()
class CreateExpenseRequest {
  final String title;
  @JsonKey(name: 'total_amount')
  final double totalAmount;
  final String currency;
  final String? memo;
  @JsonKey(name: 'due_date')
  final String dueDate;
  final List<ExpenseSplitRequest> splits;

  CreateExpenseRequest({
    required this.title,
    required this.totalAmount,
    required this.currency,
    this.memo,
    required this.dueDate,
    required this.splits,
  });

  factory CreateExpenseRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateExpenseRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateExpenseRequestToJson(this);
}

@JsonSerializable()
class ExpenseSplitRequest {
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'owe_amount')
  final double oweAmount;

  ExpenseSplitRequest({required this.userId, required this.oweAmount});

  factory ExpenseSplitRequest.fromJson(Map<String, dynamic> json) =>
      _$ExpenseSplitRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ExpenseSplitRequestToJson(this);
}
