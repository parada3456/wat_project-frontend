

part of 'job_market_bloc.dart';

@freezed
class JobMarketEvent with _$JobMarketEvent {
  const factory JobMarketEvent.listJobs({
    required Map<String, dynamic> filters,
  }) = ListJobsEvent;

  const factory JobMarketEvent.getJobDetail({
    required String jobId,
  }) = GetJobDetailEvent;

  const factory JobMarketEvent.addJobToCart({
    required String jobId,
  }) = AddJobToCartEvent;

  const factory JobMarketEvent.listCartItems() = ListCartItemsEvent;

  const factory JobMarketEvent.removeJobFromCart({
    required String cartItemId,
  }) = RemoveJobFromCartEvent;

  const factory JobMarketEvent.createJobReview({
    required CreateReviewRequest request,
  }) = CreateJobReviewEvent;

  const factory JobMarketEvent.listApplications() = ListApplicationsEvent;

  const factory JobMarketEvent.listJobReviews({
    String? jobId,
  }) = ListJobReviewsEvent;

  const factory JobMarketEvent.updateCartStatus({
    required String cartId,
    required String status,
  }) = UpdateCartStatusEvent;
}