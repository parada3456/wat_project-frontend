import 'package:wat_project_frontend/domain/models/job_posting_model.dart';
import 'package:wat_project_frontend/domain/models/user_cart_model.dart';
import 'package:wat_project_frontend/domain/models/job_review_model.dart';
import 'package:wat_project_frontend/data/entities/job_review/job/job_detail_response.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/job_review/create_review_request.dart';

import 'package:wat_project_frontend/data/entities/job_review/job/job_posting_entity.dart';

abstract class JobRepository {
  Future<List<JobPostingModel>> listJobs(Map<String, dynamic> filters);
  Future<List<JobPostingEntity>> getJobsByIds(List<String> ids);
  Future<JobDetailResponse> getJobDetail(String id);
  Future<void> addToCart(String jobId);
  Future<List<UserCartModel>> listCart();
  Future<void> updateCartStatus(String cartId, String status);
  Future<void> removeFromCart(String cartId);
  Future<List<JobReviewModel>> listReviews(String? jobId);
  Future<void> createReview(CreateReviewRequest request);
  Future<JobPostingModel> createJob(JobPostingModel job);
  Future<JobPostingModel> updateJob(String id, JobPostingModel job);
  Future<void> patchJob(String id, Map<String, dynamic> body);
  Future<void> deleteJob(String id);
  Future<void> createReviewAlternative(Map<String, dynamic> body);
}
