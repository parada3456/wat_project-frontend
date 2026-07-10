import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/domain/repositories/media_repository.dart';
import 'package:wat_project_frontend/data/sources/api/media_api_client.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/upload_media_response.dart';

@injectable
class MediaRepoImpl implements MediaRepository {
  final MediaApiService _api;

  MediaRepoImpl(this._api);

  @override
  Future<UploadMediaResponse> uploadMedia(
    File file, {
    String? bucket,
    String? key,
  }) {
    return _api.uploadMedia(file, bucket: bucket, key: key);
  }

  @override
  Future<void> deleteMedia(String key, {String? bucket}) {
    return _api.deleteMedia(key, bucket: bucket);
  }
}
