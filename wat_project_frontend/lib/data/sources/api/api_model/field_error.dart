
import 'package:json_annotation/json_annotation.dart';

part 'field_error.g.dart';

@JsonSerializable()
class FieldError {
  final String field;
  final String reason;

  const FieldError({
    required this.field,
    required this.reason,
  });

  factory FieldError.fromJson(Map<String, dynamic> json) => _$FieldErrorFromJson(json);
  Map<String, dynamic> toJson() => _$FieldErrorToJson(this);
}
