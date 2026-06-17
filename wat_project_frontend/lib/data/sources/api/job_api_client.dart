import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wat_project_frontend/data/entities/job_posting_entity.dart';import 'package:wat_project_frontend/data/entities/user_cart_entity.dart';import 'package:wat_project_frontend/data/entities/job_review_entity.dart';import 'package:wat_project_frontend/data/sources/api/api_model/job_detail_response.dart';import 'package:wat_project_frontend/data/sources/api/api_model/create_review_request.dart';
part 'job_api_client.g.dart';

@RestApi()
abstract class JobApiService {
  factory JobApiService(Dio dio, {String baseUrl}) = _JobApiService;

  @GET('/jobs')
  Future<List<JobPostingEntity>> listJobs(@Queries() Map<String, dynamic> filters);

  @GET('/jobs/{id}')
  Future<JobDetailResponse> getJobDetail(@Path('id') String id);

  @POST('/cart')
  Future<void> addToCart(@Body() Map<String, dynamic> body);

  @GET('/cart')
  Future<List<UserCartEntity>> listCart();

  @DELETE('/cart/{id}')
  Future<void> removeFromCart(@Path('id') String id);

  @GET('/reviews')
  Future<List<JobReviewEntity>> getAllReviews(@Query('job_id') String? jobId);

  @POST('/reviews')
  Future<void> createReview(@Body() CreateReviewRequest request);
}
