import 'package:wat_project_frontend/domain/models/job_posting_model.dart';import 'package:wat_project_frontend/domain/models/user_cart_model.dart';import 'package:wat_project_frontend/domain/models/job_review_model.dart';import 'package:wat_project_frontend/data/sources/api/api_model/job_detail_response.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/create_review_request.dart';

abstract class JobRepository {
  Future<List<JobPostingModel>> listJobs(Map<String, dynamic> filters);
  Future<JobDetailResponse> getJobDetail(String id);
  Future<void> addToCart(String jobId);
  Future<List<UserCartModel>> listCart();
  Future<void> updateCartStatus(String cartId, String status);
  Future<void> removeFromCart(String cartId);
  Future<List<JobReviewModel>> listReviews(String? jobId);
  Future<void> createReview(CreateReviewRequest request);
}
