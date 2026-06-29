
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

  factory PaginationInfo.fromJson(Map<String, dynamic> json) => _$PaginationInfoFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationInfoToJson(this);
}
