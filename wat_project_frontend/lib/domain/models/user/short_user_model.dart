import 'package:wat_project_frontend/domain/models/user_models.dart';
import 'package:wat_project_frontend/domain/models/job_models.dart';

class ShortUserModel {
  final String userId;
  final String name;
  final String? avatarUrl;

  const ShortUserModel({
    required this.userId,
    required this.name,
    this.avatarUrl,
  });
}
