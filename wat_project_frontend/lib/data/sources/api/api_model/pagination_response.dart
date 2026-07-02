import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/pagination_info.dart';

part 'pagination_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PaginationResponse<T> {
  final List<T> data;
  final PaginationInfo? pagination;

  PaginationResponse({required this.data, this.pagination});

  factory PaginationResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) => _$PaginationResponseFromJson(json, fromJsonT);
  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) => _$PaginationResponseToJson(this, toJsonT);
}
