import 'dart:io';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/upload_media_response.dart';

part 'media_api_client.g.dart';

@RestApi()
abstract class MediaApiService {
  factory MediaApiService(Dio dio, {String baseUrl}) = _MediaApiService;

  @POST('media/upload')
  @MultiPart()
  Future<UploadMediaResponse> uploadMedia(
    @Part(name: 'file') File file, {
    @Part(name: 'bucket') String? bucket,
    @Part(name: 'key') String? key,
  });

  @DELETE('media/{key}')
  Future<void> deleteMedia(
    @Path('key') String key, {
    @Query('bucket') String? bucket,
  });
}
