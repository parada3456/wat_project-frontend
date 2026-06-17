import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wat_project_frontend/data/entities/friendship_entity.dart';import 'package:wat_project_frontend/data/sources/api/api_model/radar_entry.dart';
part 'friend_api_client.g.dart';

@RestApi()
abstract class FriendApiService {
  factory FriendApiService(Dio dio, {String baseUrl}) = _FriendApiService;

  @POST('/friends/request')
  Future<void> sendRequest(@Body() Map<String, dynamic> body);

  @GET('/friends/requests/pending')
  Future<List<FriendshipEntity>> listPendingRequests();

  @PATCH('/friends/respond')
  Future<void> respondToRequest(@Body() Map<String, dynamic> body);

  @GET('/friends')
  Future<List<FriendshipEntity>> listFriends();

  @DELETE('/friends/{id}')
  Future<void> removeFriend(@Path('id') String id);

  @GET('/radar')
  Future<List<RadarEntry>> getRadar();
}
