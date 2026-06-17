import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel {
  final String id;
  final String title;
  final String content;

  const PostModel({
    required this.id,
    required this.title,
    required this.content,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => _$PostModelFromJson(json);
  Map<String, dynamic> toJson() => _$PostModelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          content == other.content;

  @override
  int get hashCode => Object.hash(id, title, content);
}
