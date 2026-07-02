// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationResponse<T> _$PaginationResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => PaginationResponse<T>(
  data: (json['data'] as List<dynamic>).map(fromJsonT).toList(),
  pagination: json['pagination'] == null
      ? null
      : PaginationInfo.fromJson(json['pagination'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PaginationResponseToJson<T>(
  PaginationResponse<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'data': instance.data.map(toJsonT).toList(),
  'pagination': instance.pagination,
};
