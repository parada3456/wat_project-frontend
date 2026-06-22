import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wat_project_frontend/data/entities/notification_entity.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/list_response.dart';

part 'notification_api_client.g.dart';

@RestApi()
abstract class NotificationApiService {
  factory NotificationApiService(Dio dio, {String baseUrl}) = _NotificationApiService;

  @GET('notifications')
  Future<ListResponse<NotificationEntity>> listNotifications();

  @PATCH('notifications/{id}')
  Future<void> markRead(@Path('id') String id);

  @PATCH('notifications')
  Future<void> markAllRead();

  @DELETE('notifications/{id}')
  Future<void> deleteNotification(@Path('id') String id);
}
