abstract class SocialRadarEvent {
  const SocialRadarEvent();
}

class LoadSocialRadar extends SocialRadarEvent {
  const LoadSocialRadar();
}

class GetRadarUsers extends SocialRadarEvent {
  const GetRadarUsers();
}

class ListPendingRequests extends SocialRadarEvent {
  const ListPendingRequests();
}

class ListFriends extends SocialRadarEvent {
  const ListFriends();
}

class SendFriendRequest extends SocialRadarEvent {
  final String targetUserId;
  const SendFriendRequest(this.targetUserId);
}

class RespondToFriendRequest extends SocialRadarEvent {
  final String friendshipId;
  final bool accept;

  const RespondToFriendRequest({
    required this.friendshipId,
    required this.accept,
  });
}

class RemoveFriend extends SocialRadarEvent {
  final String friendId;
  const RemoveFriend(this.friendId);
}
