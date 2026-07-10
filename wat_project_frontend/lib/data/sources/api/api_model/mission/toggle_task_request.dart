import 'package:json_annotation/json_annotation.dart';

part 'toggle_task_request.g.dart';

@JsonSerializable()
class ToggleTaskRequest {
  final bool completed;
  // @JsonKey(name: 'isCompleted')
  // final bool isCompleted;

  ToggleTaskRequest({
    required this.completed,
    // required this.isCompleted,
  });

  factory ToggleTaskRequest.fromJson(Map<String, dynamic> json) =>
      _$ToggleTaskRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ToggleTaskRequestToJson(this);
}
