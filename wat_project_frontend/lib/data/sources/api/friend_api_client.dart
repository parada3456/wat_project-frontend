import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wat_project_frontend/data/entities/friendship_entity.dart';import 'package:wat_project_frontend/data/sources/api/api_model/radar_entry.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/list_response.dart';

part 'friend_api_client.g.dart';

@RestApi()
abstract class FriendApiService {
  factory FriendApiService(Dio dio, {String baseUrl}) = _FriendApiService;

  @POST('friend-requests')
  Future<void> sendRequest(@Body() Map<String, dynamic> body);

  @GET('friend-requests')
  Future<ListResponse<FriendshipEntity>> listPendingRequests();

  @PATCH('friend-requests/{id}')
  Future<void> respondToRequest(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );

  @GET('friends')
  Future<ListResponse<FriendshipEntity>> listFriends();

  @DELETE('friends/{id}')
  Future<void> removeFriend(@Path('id') String id);

  @GET('radar')
  Future<List<RadarEntry>> getRadar();
}
