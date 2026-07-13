import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wat_project_frontend/domain/models/notification_models.dart';

part 'notifications_state.freezed.dart';

@freezed
class NotificationsState with _$NotificationsState {
  const factory NotificationsState.initial() = NotificationsInitial;
  const factory NotificationsState.loading() = NotificationsLoading;
  const factory NotificationsState.success(List<NotificationModel> notifications) = NotificationsSuccess;
  const factory NotificationsState.failure(String errorMessage) = NotificationsFailure;
}
