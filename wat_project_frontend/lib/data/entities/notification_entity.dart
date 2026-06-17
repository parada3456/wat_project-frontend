import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/domain/models/notification_model.dart';

part 'notification_entity.g.dart';

@JsonSerializable()
class NotificationEntity {
  @JsonKey(name: 'notification_id')
  final String notificationId;
  @JsonKey(name: 'user_id')
  final String userId;
  final String title;
  final String body;
  @JsonKey(name: 'is_read')
  final bool isRead;
  @JsonKey(name: 'created_at')
  final String createdAt;

  NotificationEntity({
    required this.notificationId,
    required this.userId,
    required this.title,
    required this.body,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationEntity.fromJson(Map<String, dynamic> json) =>
      _$NotificationEntityFromJson(json);

  NotificationModel toModel() => NotificationModel(
        notificationId: notificationId,
        userId: userId,
        title: title,
        body: body,
        isRead: isRead,
        createdAt: DateTime.parse(createdAt),
      );
}
