import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/data/entities/job_review/job/job_posting_entity.dart';
import 'package:wat_project_frontend/domain/models/job_posting_model.dart';
import 'package:wat_project_frontend/domain/models/user_cart_model.dart';
import 'package:wat_project_frontend/domain/models/job_review_model.dart';
import 'package:wat_project_frontend/domain/repositories/job_repository.dart';
import 'package:wat_project_frontend/data/sources/api/job_api_client.dart';
import 'package:wat_project_frontend/data/entities/job_review/job/job_detail_response.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/job_review/create_review_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/job_review/add_to_cart_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/job_review/update_cart_status_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/job_review/patch_job_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/job_review/create_review_alternative_request.dart';


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
  Future<List<JobPostingEntity>> getJobsByIds(List<String> ids) async {
    if (ids.isEmpty) return [];
    final response = await _api.getJobsByIds(ids.join(','));
    return response.data;
  }

  @override
  Future<JobDetailResponse> getJobDetail(String id) async {
    return _api.getJobDetail(id);
  }

  @override
  Future<void> addToCart(String jobId) async {
    return _api.addToCart(AddToCartRequest(jobId: jobId));
  }

  @override
  Future<List<UserCartModel>> listCart() async {
    final response = await _api.listCart();
    return response.data.map((e) => e.toModel()).toList();
  }

  @override
  Future<void> updateCartStatus(String cartId, String status) async {
    return _api.updateCartStatus(cartId, UpdateCartStatusRequest(status: status));
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

  @override
  Future<JobPostingModel> createJob(JobPostingModel job) async {
    final entity = _fromModel(job);
    final response = await _api.createJob(entity);
    return response.toModel();
  }

  @override
  Future<JobPostingModel> updateJob(String id, JobPostingModel job) async {
    final entity = _fromModel(job);
    final response = await _api.updateJob(id, entity);
    return response.toModel();
  }

  @override
  Future<void> patchJob(String id, Map<String, dynamic> body) async {
    return _api.patchJob(id, PatchJobRequest.fromJson(body));
  }

  @override
  Future<void> deleteJob(String id) async {
    return _api.deleteJob(id);
  }

  @override
  Future<void> createReviewAlternative(Map<String, dynamic> body) async {
    return _api.createReviewAlternative(CreateReviewAlternativeRequest.fromJson(body));
  }

  JobPostingEntity _fromModel(JobPostingModel model) {
    return JobPostingEntity(
      jobId: model.jobId,
      agencyName: model.agencyName,
      employerTitle: model.employerTitle,
      position: model.position,
      positionType: model.positionType,
      locationCity: model.locationCity,
      locationState: model.locationState,
      groupLocation: model.groupLocation,
      usSponsor: model.usSponsor,
      salaryRangeMin: model.salaryRangeMin,
      salaryRangeMax: model.salaryRangeMax,
      availableSlots: model.availableSlots,
      description: model.description,
      sourceUrl: model.sourceUrl,
      scrapeAt: model.scrapeAt,
      postedAt: model.postedAt,
      updatedAt: model.updatedAt,
    );
  }
}
