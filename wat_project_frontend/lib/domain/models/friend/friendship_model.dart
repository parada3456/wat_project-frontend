import 'package:json_annotation/json_annotation.dart';

enum FriendshipStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('accepted')
  accepted,
  @JsonValue('rejected')
  rejected,
}

class FriendshipModel {
  final String friendshipId;
  final String userId1;
  final String userId2;
  final FriendshipStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const FriendshipModel({
    required this.friendshipId,
    required this.userId1,
    required this.userId2,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FriendshipModel &&
          runtimeType == other.runtimeType &&
          friendshipId == other.friendshipId &&
          userId1 == other.userId1 &&
          userId2 == other.userId2 &&
          status == other.status &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode =>
      Object.hash(friendshipId, userId1, userId2, status, createdAt, updatedAt);
}
