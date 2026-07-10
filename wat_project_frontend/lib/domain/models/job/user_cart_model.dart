import 'package:json_annotation/json_annotation.dart';

part 'user_cart_model.g.dart';

enum CartStatus {
  @JsonValue('Saved')
  saved,
  @JsonValue('Viewed')
  viewed,
  @JsonValue('Applied')
  applied,
  @JsonValue('Removed')
  removed,
}

@JsonSerializable()
class UserCartModel {
  final String cartId;
  final String userId;
  final String jobId;
  final CartStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserCartModel({
    required this.cartId,
    required this.userId,
    required this.jobId,
    this.status = CartStatus.saved,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserCartModel.fromJson(Map<String, dynamic> json) =>
      _$UserCartModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserCartModelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserCartModel &&
          runtimeType == other.runtimeType &&
          cartId == other.cartId &&
          userId == other.userId &&
          jobId == other.jobId &&
          status == other.status &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode =>
      Object.hash(cartId, userId, jobId, status, createdAt, updatedAt);
}
