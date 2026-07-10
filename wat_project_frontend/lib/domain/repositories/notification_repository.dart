import 'package:wat_project_frontend/data/entities/notification/notification_entity.dart';
import 'package:wat_project_frontend/domain/models/notification_models.dart';

abstract class NotificationRepository {
  Future<List<NotificationEntity>> listNotifications();
  Future<void> markRead(String id);
  Future<void> markAllRead();
  Future<void> deleteNotification(String id);
}
