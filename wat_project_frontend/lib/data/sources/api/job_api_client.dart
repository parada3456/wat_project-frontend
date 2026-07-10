import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wat_project_frontend/data/entities/job_review/job/job_posting_entity.dart';
import 'package:wat_project_frontend/data/entities/job_review/job/user_cart_entity.dart';
import 'package:wat_project_frontend/data/entities/job_review/review/job_review_entity.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/job_review/create_review_request.dart';
import 'package:wat_project_frontend/data/entities/job_review/job/job_detail_response.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/pagination_response.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/job_review/add_to_cart_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/job_review/update_cart_status_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/job_review/patch_job_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/job_review/create_review_alternative_request.dart';

part 'job_api_client.g.dart';

@RestApi()
abstract class JobApiService {
  factory JobApiService(Dio dio, {String baseUrl}) = _JobApiService;

  @GET('jobs')
  Future<PaginationResponse<JobPostingEntity>> listJobs(
    @Queries() Map<String, dynamic> filters,
  );

  @GET('jobs')
  Future<PaginationResponse<JobPostingEntity>> getJobsByIds(
    @Query('ids') String ids,
  );

  @GET('jobs/{id}')
  Future<JobDetailResponse> getJobDetail(@Path('id') String id);

  @POST('cart')
  Future<void> addToCart(@Body() AddToCartRequest request);

  @GET('cart')
  Future<PaginationResponse<UserCartEntity>> listCart();

  @PATCH('cart/{cartId}')
  Future<void> updateCartStatus(
    @Path('cartId') String cartId,
    @Body() UpdateCartStatusRequest request,
  );

  @DELETE('cart/{id}')
  Future<void> removeFromCart(@Path('id') String id);

  @GET('jobs/{id}/reviews')
  Future<PaginationResponse<JobReviewEntity>> getJobReviews(
    @Path('id') String jobId,
  );

  @POST('jobs/{id}/reviews')
  Future<void> createReview(
    @Path('id') String jobId,
    @Body() CreateReviewRequest request,
  );

  @POST('jobs')
  Future<JobPostingEntity> createJob(@Body() JobPostingEntity job);

  @PUT('jobs/{id}')
  Future<JobPostingEntity> updateJob(
    @Path('id') String id,
    @Body() JobPostingEntity job,
  );

  @PATCH('jobs/{id}')
  Future<void> patchJob(@Path('id') String id, @Body() PatchJobRequest request);

  @DELETE('jobs/{id}')
  Future<void> deleteJob(@Path('id') String id);

  @POST('reviews')
  Future<void> createReviewAlternative(
    @Body() CreateReviewAlternativeRequest request,
  );
}
