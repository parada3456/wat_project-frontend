import 'package:json_annotation/json_annotation.dart';

part 'send_friend_request.g.dart';

@JsonSerializable()
class SendFriendRequest {
  @JsonKey(name: 'target_user_id')
  final String targetUserId;

  SendFriendRequest({
    required this.targetUserId,
  });

  factory SendFriendRequest.fromJson(Map<String, dynamic> json) => _$SendFriendRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SendFriendRequestToJson(this);
}
