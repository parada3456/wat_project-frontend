

part of 'job_market_bloc.dart';

@freezed
abstract class JobMarketState with _$JobMarketState {
  const factory JobMarketState({
    @Default(UIStatus.initial()) UIStatus status,
    
    // Core data cache for the feature
    @Default([]) List<JobPostingModel> jobs,
    JobDetailResponse? jobDetail,
    @Default([]) List<JobReviewEntity> reviews,
    @Default([]) List<UserCartModel> cartItems,
    @Default([]) List<UserJobModel> applications,

    // Specific action statuses to handle one-off side effects (like showing popups)
    @Default(UIStatus.initial()) UIStatus addToCartStatus,
    @Default(UIStatus.initial()) UIStatus removeFromCartStatus,
    @Default(UIStatus.initial()) UIStatus createReviewStatus,
    @Default(UIStatus.initial()) UIStatus updateCartStatus,
    @Default(UIStatus.initial()) UIStatus createJobStatus,
    @Default(UIStatus.initial()) UIStatus updateJobStatus,
    @Default(UIStatus.initial()) UIStatus deleteJobStatus,
  }) = _JobMarketState;
}