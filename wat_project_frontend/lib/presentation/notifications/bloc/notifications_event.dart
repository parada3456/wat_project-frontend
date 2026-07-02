abstract class NotificationsEvent {
  const NotificationsEvent();
}

class LoadNotificationsEvent extends NotificationsEvent {
  const LoadNotificationsEvent();
}

class MarkNotificationReadEvent extends NotificationsEvent {
  final String notificationId;
  const MarkNotificationReadEvent(this.notificationId);
}

class MarkAllNotificationsReadEvent extends NotificationsEvent {
  const MarkAllNotificationsReadEvent();
}

class DeleteNotificationEvent extends NotificationsEvent {
  final String notificationId;
  const DeleteNotificationEvent(this.notificationId);
}
