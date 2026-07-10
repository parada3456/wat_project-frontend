import 'package:json_annotation/json_annotation.dart';

part 'pagination_info.g.dart';

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

  factory PaginationInfo.fromJson(Map<String, dynamic> json) {
    return PaginationInfo(
      page: json['page'] as int? ?? 1,
      pageSize: (json['page_size'] ?? json['pageSize'] ?? 10) as int,
      totalItems: (json['total_items'] ?? json['totalItems'] ?? 0) as int,
      totalPages: (json['total_pages'] ?? json['totalPages'] ?? 1) as int,
    );
  }
  Map<String, dynamic> toJson() => _$PaginationInfoToJson(this);
}
