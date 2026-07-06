import 'package:wat_project_frontend/data/entities/friend/friendship_entity.dart';
import 'package:wat_project_frontend/domain/models/friend_models.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/friend_radar/radar_entry.dart';

abstract class FriendRepository {
  Future<void> sendRequest(String targetUserId);
  Future<List<FriendshipEntity>> listPendingRequests();
  Future<void> respondToRequest(String friendshipId, bool accept);
  Future<List<FriendshipEntity>> listFriends();
  Future<void> removeFriend(String friendshipId);
  Future<List<RadarEntry>> getRadar();
}
