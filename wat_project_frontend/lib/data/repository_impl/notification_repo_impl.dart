import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/domain/models/notification_model.dart';
import 'package:wat_project_frontend/domain/repositories/notification_repository.dart';
import 'package:wat_project_frontend/data/sources/api/notification_api_client.dart';


@injectable
class NotificationRepoImpl implements NotificationRepository {
  final NotificationApiService _api;

  NotificationRepoImpl(this._api);

  @override
  Future<List<NotificationModel>> listNotifications() async {
    final response = await _api.listNotifications();
    return response.data.map((e) => e.toModel()).toList();
  }

  @override
  Future<void> markRead(String id) async {
    return _api.markRead(id);
  }

  @override
  Future<void> markAllRead() async {
    return _api.markAllRead();
  }

  @override
  Future<void> deleteNotification(String id) async {
    return _api.deleteNotification(id);
  }
}
