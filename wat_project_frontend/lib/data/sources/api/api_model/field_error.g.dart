// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FieldError _$FieldErrorFromJson(Map<String, dynamic> json) => FieldError(
  field: json['field'] as String,
  reason: json['reason'] as String,
);

Map<String, dynamic> _$FieldErrorToJson(FieldError instance) =>
    <String, dynamic>{'field': instance.field, 'reason': instance.reason};
