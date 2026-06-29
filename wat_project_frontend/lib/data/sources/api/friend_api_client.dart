import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wat_project_frontend/data/entities/friend/friendship_entity.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/friend_radar/radar_entry.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/pagination_response.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/friend/send_friend_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/friend/respond_friend_request.dart';

part 'friend_api_client.g.dart';

@RestApi()
abstract class FriendApiService {
  factory FriendApiService(Dio dio, {String baseUrl}) = _FriendApiService;

  @POST('friend-requests')
  Future<void> sendRequest(@Body() SendFriendRequest request);

  @GET('friend-requests')
  Future<PaginationResponse<FriendshipEntity>> listPendingRequests();

  @PATCH('friend-requests/{id}')
  Future<void> respondToRequest(
    @Path('id') String id,
    @Body() RespondFriendRequest request,
  );

  @GET('friends')
  Future<PaginationResponse<FriendshipEntity>> listFriends();

  @DELETE('friends/{id}')
  Future<void> removeFriend(@Path('id') String id);

  @GET('radar')
  Future<List<RadarEntry>> getRadar();
}
