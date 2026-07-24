import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/domain/models/user/short_user_model.dart';
import 'package:wat_project_frontend/domain/models/user_models.dart';

part 'short_user_entity.g.dart';

@JsonSerializable()
class ShortUserEntity {
  @JsonKey(name: 'user_id')
  final String userId;
  final String name;
  @JsonKey(name: 'avatar_url')
  final String avatarUrl;

  ShortUserEntity({
    required this.userId,
    required this.name,
    required this.avatarUrl,
  });

  factory ShortUserEntity.fromJson(Map<String, dynamic> json) =>
      _$ShortUserEntityFromJson(json);
  Map<String, dynamic> toJson() => _$ShortUserEntityToJson(this);

  ShortUserModel toModel() => ShortUserModel(
    userId: userId,
    name: name,
    avatarUrl: avatarUrl,
  );
}
