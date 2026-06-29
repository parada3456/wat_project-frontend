import 'package:wat_project_frontend/domain/models/notification_model.dart';

abstract class NotificationsState {
  const NotificationsState();
}

class NotificationsInitial extends NotificationsState {
  const NotificationsInitial();
}

class NotificationsLoading extends NotificationsState {
  const NotificationsLoading();
}

class NotificationsSuccess extends NotificationsState {
  final List<NotificationModel> notifications;
  const NotificationsSuccess(this.notifications);
}

class NotificationsFailure extends NotificationsState {
  final String errorMessage;
  const NotificationsFailure(this.errorMessage);
}
