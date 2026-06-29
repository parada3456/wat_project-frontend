import 'package:json_annotation/json_annotation.dart';

import 'field_error.dart';

part 'api_error.g.dart';

@JsonSerializable()
class ApiError {
  final String code;
  final String message;
  final List<FieldError> details;

  const ApiError({
    required this.code,
    required this.message,
    this.details = const [],
  });

  factory ApiError.fromJson(Map<String, dynamic> json) => _$ApiErrorFromJson(json);
  Map<String, dynamic> toJson() => _$ApiErrorToJson(this);

}
