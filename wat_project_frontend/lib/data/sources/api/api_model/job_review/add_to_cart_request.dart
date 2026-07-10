import 'package:json_annotation/json_annotation.dart';

part 'add_to_cart_request.g.dart';

@JsonSerializable()
class AddToCartRequest {
  @JsonKey(name: 'job_id')
  final String jobId;

  AddToCartRequest({required this.jobId});

  factory AddToCartRequest.fromJson(Map<String, dynamic> json) =>
      _$AddToCartRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AddToCartRequestToJson(this);
}
