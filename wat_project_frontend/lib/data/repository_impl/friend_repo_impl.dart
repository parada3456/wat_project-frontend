import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/domain/models/friendship_model.dart';
import 'package:wat_project_frontend/domain/repositories/friend_repository.dart';
import 'package:wat_project_frontend/data/sources/api/friend_api_client.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/radar_entry.dart';


@injectable
class FriendRepoImpl implements FriendRepository {
  final FriendApiService _api;

  FriendRepoImpl(this._api);

  @override
  Future<void> sendRequest(String targetUserId) async {
    return _api.sendRequest({'target_user_id': targetUserId});
  }

  @override
  Future<List<FriendshipModel>> listPendingRequests() async {
    final response = await _api.listPendingRequests();
    return response.map((e) => e.toModel()).toList();
  }

  @override
  Future<void> respondToRequest(String friendshipId, bool accept) async {
    return _api.respondToRequest({'friendship_id': friendshipId, 'accept': accept});
  }

  @override
  Future<List<FriendshipModel>> listFriends() async {
    final response = await _api.listFriends();
    return response.map((e) => e.toModel()).toList();
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
