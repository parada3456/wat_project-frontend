import 'package:json_annotation/json_annotation.dart';

part 'list_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ListResponse<T> {
  final List<T> data;
  final PaginationInfo? pagination;

  ListResponse({required this.data, this.pagination});

  factory ListResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ListResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$ListResponseToJson(this, toJsonT);
}

@JsonSerializable()
class PaginationInfo {
  final int page;
  @JsonKey(name: 'pageSize')
  final int pageSize;
  @JsonKey(name: 'totalItems')
  final int totalItems;
  @JsonKey(name: 'totalPages')
  final int totalPages;

  PaginationInfo({
    required this.page,
    required this.pageSize,
    required this.totalItems,
    required this.totalPages,
  });

  factory PaginationInfo.fromJson(Map<String, dynamic> json) =>
      _$PaginationInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationInfoToJson(this);
}
