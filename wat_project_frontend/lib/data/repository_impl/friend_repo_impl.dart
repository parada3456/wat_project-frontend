import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/data/entities/friend/friendship_entity.dart';
import 'package:wat_project_frontend/domain/repositories/friend_repository.dart';
import 'package:wat_project_frontend/data/sources/api/friend_api_client.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/friend_radar/radar_entry.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/friend/send_friend_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/friend/respond_friend_request.dart';

@injectable
class FriendRepoImpl implements FriendRepository {
  final FriendApiService _api;

  FriendRepoImpl(this._api);

  @override
  Future<void> sendRequest(String targetUserId) async {
    return _api.sendRequest(SendFriendRequest(targetUserId: targetUserId));
  }

  @override
  Future<List<FriendshipEntity>> listPendingRequests() async {
    final response = await _api.listPendingRequests();
    return response.data;
  }

  @override
  Future<void> respondToRequest(String friendshipId, bool accept) async {
    return _api.respondToRequest(
      friendshipId,
      RespondFriendRequest(
        accept: accept,
        status: accept ? 'Accepted' : 'Rejected',
      ),
    );
  }

  @override
  Future<List<FriendshipEntity>> listFriends() async {
    final response = await _api.listFriends();
    return response.data;
  }

  @override
  Future<void> removeFriend(String friendshipId) async {
    return _api.removeFriend(friendshipId);
  }

  @override
  Future<List<RadarEntry>> getRadar() async {
    return _api.getRadar();
  }
}
