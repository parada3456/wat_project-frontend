import 'package:wat_project_frontend/data/sources/api/api_model/friend_radar/radar_entry.dart';
import 'package:wat_project_frontend/domain/models/friend_models.dart';

abstract class SocialRadarState {
  const SocialRadarState();
}

class SocialRadarInitial extends SocialRadarState {
  const SocialRadarInitial();
}

class SocialRadarLoading extends SocialRadarState {
  const SocialRadarLoading();
}

class SocialRadarFailure extends SocialRadarState {
  final String message;
  const SocialRadarFailure(this.message);
}

class SocialRadarLoadSuccess extends SocialRadarState {
  final List<RadarEntry> radarUsers;
  final List<FriendshipModel> friends;
  final List<FriendshipModel> pendingRequests;

  const SocialRadarLoadSuccess({
    required this.radarUsers,
    required this.friends,
    required this.pendingRequests,
  });
}

class RadarUsersLoadSuccess extends SocialRadarState {
  final List<RadarEntry> radarUsers;
  const RadarUsersLoadSuccess(this.radarUsers);
}

class PendingRequestsLoadSuccess extends SocialRadarState {
  final List<FriendshipModel> pendingRequests;
  const PendingRequestsLoadSuccess(this.pendingRequests);
}

class FriendsLoadSuccess extends SocialRadarState {
  final List<FriendshipModel> friends;
  const FriendsLoadSuccess(this.friends);
}

class SendFriendRequestSuccess extends SocialRadarState {
  const SendFriendRequestSuccess();
}

class RespondToFriendRequestSuccess extends SocialRadarState {
  const RespondToFriendRequestSuccess();
}

class RemoveFriendSuccess extends SocialRadarState {
  const RemoveFriendSuccess();
}
