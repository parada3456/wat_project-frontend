import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/domain/models/job_posting_model.dart';
import 'package:wat_project_frontend/domain/models/user_cart_model.dart';
import 'package:wat_project_frontend/domain/models/job_review_model.dart';
import 'package:wat_project_frontend/domain/repositories/job_repository.dart';
import 'package:wat_project_frontend/data/sources/api/job_api_client.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/job_detail_response.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/create_review_request.dart';


@injectable
class JobRepoImpl implements JobRepository {
  final JobApiService _api;

  JobRepoImpl(this._api);

  @override
  Future<List<JobPostingModel>> listJobs(Map<String, dynamic> filters) async {
    final response = await _api.listJobs(filters);
    return response.data.map((e) => e.toModel()).toList();
  }

  @override
  Future<JobDetailResponse> getJobDetail(String id) async {
    return _api.getJobDetail(id);
  }

  @override
  Future<void> addToCart(String jobId) async {
    return _api.addToCart({'job_id': jobId});
  }

  @override
  Future<List<UserCartModel>> listCart() async {
    final response = await _api.listCart();
    return response.data.map((e) => e.toModel()).toList();
  }

  @override
  Future<void> updateCartStatus(String cartId, String status) async {
    return _api.updateCartStatus(cartId, {'status': status});
  }

  @override
  Future<void> removeFromCart(String cartId) async {
    return _api.removeFromCart(cartId);
  }

  @override
  Future<List<JobReviewModel>> listReviews(String? jobId) async {
    final response = await _api.getJobReviews(jobId ?? '');
    return response.data.map((e) => e.toModel()).toList();
  }

  @override
  Future<void> createReview(CreateReviewRequest request) async {
    return _api.createReview(request.jobId, request);
  }
}
