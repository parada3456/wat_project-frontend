import 'package:json_annotation/json_annotation.dart';

part 'respond_friend_request.g.dart';

@JsonSerializable()
class RespondFriendRequest {
  final bool accept;
  final String status;

  RespondFriendRequest({required this.accept, required this.status});

  factory RespondFriendRequest.fromJson(Map<String, dynamic> json) =>
      _$RespondFriendRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RespondFriendRequestToJson(this);
}
