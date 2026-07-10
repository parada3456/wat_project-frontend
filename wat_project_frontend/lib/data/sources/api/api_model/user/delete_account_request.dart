import 'package:json_annotation/json_annotation.dart';

part 'delete_account_request.g.dart';

@JsonSerializable()
class DeleteAccountRequest {
  @JsonKey(name: 'current_password')
  final String currentPassword;

  DeleteAccountRequest({required this.currentPassword});

  factory DeleteAccountRequest.fromJson(Map<String, dynamic> json) =>
      _$DeleteAccountRequestFromJson(json);
  Map<String, dynamic> toJson() => _$DeleteAccountRequestToJson(this);
}
