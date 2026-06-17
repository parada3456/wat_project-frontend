import 'package:wat_project_frontend/domain/models/notification_model.dart';
abstract class NotificationRepository {
  Future<List<NotificationModel>> listNotifications();
  Future<void> markRead(String id);
  Future<void> markAllRead();
  Future<void> deleteNotification(String id);
}
