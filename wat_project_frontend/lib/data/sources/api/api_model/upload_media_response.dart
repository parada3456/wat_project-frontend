import 'package:json_annotation/json_annotation.dart';

part 'upload_media_response.g.dart';

@JsonSerializable()
class UploadMediaResponse {
  final String url;
  final String key;

  UploadMediaResponse({required this.url, required this.key});

  factory UploadMediaResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadMediaResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UploadMediaResponseToJson(this);
}
