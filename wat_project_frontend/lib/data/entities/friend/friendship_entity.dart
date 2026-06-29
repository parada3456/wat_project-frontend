import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/domain/models/friendship_model.dart';

part 'friendship_entity.g.dart';

@JsonSerializable()
class FriendshipEntity {
  @JsonKey(name: 'friendship_id')
  final String friendshipId;
  @JsonKey(name: 'user_id_1')
  final String userId1;
  @JsonKey(name: 'user_id_2')
  final String userId2;
  final FriendshipStatus status;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  FriendshipEntity({
    required this.friendshipId,
    required this.userId1,
    required this.userId2,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FriendshipEntity.fromJson(Map<String, dynamic> json) => _$FriendshipEntityFromJson(json);
  Map<String, dynamic> toJson() => _$FriendshipEntityToJson(this);

  FriendshipModel toModel() => FriendshipModel(
    friendshipId: friendshipId,
    userId1: userId1,
    userId2: userId2,
    status: status,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
