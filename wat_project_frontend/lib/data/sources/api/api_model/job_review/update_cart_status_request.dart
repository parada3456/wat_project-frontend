import 'package:json_annotation/json_annotation.dart';

part 'update_cart_status_request.g.dart';

@JsonSerializable()
class UpdateCartStatusRequest {
  final String status;

  UpdateCartStatusRequest({
    required this.status,
  });

  factory UpdateCartStatusRequest.fromJson(Map<String, dynamic> json) => _$UpdateCartStatusRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateCartStatusRequestToJson(this);
}
