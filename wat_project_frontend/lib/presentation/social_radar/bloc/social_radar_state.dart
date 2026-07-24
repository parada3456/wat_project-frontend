import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/friend_radar/radar_entry.dart';
import 'package:wat_project_frontend/domain/models/friend_models.dart';

part 'social_radar_state.freezed.dart';

@freezed
class SocialRadarState with _$SocialRadarState {
  const factory SocialRadarState.initial() = SocialRadarInitial;
  const factory SocialRadarState.loading() = SocialRadarLoading;
  const factory SocialRadarState.failure(String message) = SocialRadarFailure;
  const factory SocialRadarState.loadSuccess({
    required List<RadarEntry> radarUsers,
    required List<FriendshipModel> friends,
    required List<FriendshipModel> pendingRequests,
  }) = SocialRadarLoadSuccess;
  const factory SocialRadarState.radarUsersLoadSuccess(
    List<RadarEntry> radarUsers,
  ) = RadarUsersLoadSuccess;
  const factory SocialRadarState.pendingRequestsLoadSuccess(
    List<FriendshipModel> pendingRequests,
  ) = PendingRequestsLoadSuccess;
  const factory SocialRadarState.friendsLoadSuccess(
    List<FriendshipModel> friends,
  ) = FriendsLoadSuccess;
  const factory SocialRadarState.sendFriendRequestSuccess() =
      SendFriendRequestSuccess;
  const factory SocialRadarState.respondToFriendRequestSuccess() =
      RespondToFriendRequestSuccess;
  const factory SocialRadarState.removeFriendSuccess() = RemoveFriendSuccess;
}
