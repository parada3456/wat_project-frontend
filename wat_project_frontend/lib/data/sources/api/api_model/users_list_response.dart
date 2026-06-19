import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/data/entities/user_entity.dart';

part 'users_list_response.g.dart';

@JsonSerializable()
class UsersListResponse {
  final List<UserEntity> data;

  UsersListResponse({required this.data});

  factory UsersListResponse.fromJson(Map<String, dynamic> json) =>
      _$UsersListResponseFromJson(json);
}
