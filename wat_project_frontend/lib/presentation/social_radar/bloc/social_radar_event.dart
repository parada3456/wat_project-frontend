import 'package:freezed_annotation/freezed_annotation.dart';

part 'social_radar_event.freezed.dart';

@freezed
class SocialRadarEvent with _$SocialRadarEvent {
  const factory SocialRadarEvent.loadSocialRadar() = LoadSocialRadar;
  const factory SocialRadarEvent.getRadarUsers() = GetRadarUsers;
  const factory SocialRadarEvent.listPendingRequests() = ListPendingRequests;
  const factory SocialRadarEvent.listFriends() = ListFriends;
  const factory SocialRadarEvent.sendFriendRequest(String targetUserId) =
      SendFriendRequest;
  const factory SocialRadarEvent.respondToFriendRequest({
    required String friendshipId,
    required bool accept,
  }) = RespondToFriendRequest;
  const factory SocialRadarEvent.removeFriend(String friendId) = RemoveFriend;
}
