import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/domain/models/user_cart_model.dart';

part 'user_cart_entity.g.dart';

@JsonSerializable()
class UserCartEntity {
  @JsonKey(name: 'cart_id')
  final String cartId;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'job_id')
  final String jobId;
  final CartStatus status;
  @JsonKey(name: 'added_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  UserCartEntity({
    required this.cartId,
    required this.userId,
    required this.jobId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserCartEntity.fromJson(Map<String, dynamic> json) => _$UserCartEntityFromJson(json);
  Map<String, dynamic> toJson() => _$UserCartEntityToJson(this);

  UserCartModel toModel() => UserCartModel(
        cartId: cartId,
        userId: userId,
        jobId: jobId,
        status: status,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
