import 'package:freezed_annotation/freezed_annotation.dart';

part 'notifications_event.freezed.dart';

@freezed
class NotificationsEvent with _$NotificationsEvent {
  const factory NotificationsEvent.loadNotifications() = LoadNotificationsEvent;
  const factory NotificationsEvent.markNotificationRead(String notificationId) =
      MarkNotificationReadEvent;
  const factory NotificationsEvent.markAllNotificationsRead() =
      MarkAllNotificationsReadEvent;
  const factory NotificationsEvent.deleteNotification(String notificationId) =
      DeleteNotificationEvent;
}
