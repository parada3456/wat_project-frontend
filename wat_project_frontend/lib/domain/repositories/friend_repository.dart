import 'package:wat_project_frontend/domain/models/friendship_model.dart';import 'package:wat_project_frontend/data/sources/api/api_model/radar_entry.dart';

abstract class FriendRepository {
  Future<void> sendRequest(String targetUserId);
  Future<List<FriendshipModel>> listPendingRequests();
  Future<void> respondToRequest(String friendshipId, bool accept);
  Future<List<FriendshipModel>> listFriends();
  Future<void> removeFriend(String friendshipId);
  Future<List<RadarEntry>> getRadar();
}
