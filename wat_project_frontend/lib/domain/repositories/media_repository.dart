import 'dart:io';
import 'package:wat_project_frontend/data/sources/api/api_model/upload_media_response.dart';

abstract class MediaRepository {
  Future<UploadMediaResponse> uploadMedia(
    File file, {
    String? bucket,
    String? key,
  });
  Future<void> deleteMedia(String key, {String? bucket});
}
