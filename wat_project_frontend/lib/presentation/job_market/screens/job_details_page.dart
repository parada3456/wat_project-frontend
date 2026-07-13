import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:wat_project_frontend/data/entities/job_review/job/job_detail_response.dart';
import 'package:wat_project_frontend/data/entities/job_review/review/job_review_entity.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/presentation/job_market/bloc/job_market_bloc.dart';
import 'package:wat_project_frontend/presentation/job_market/widgets/job_review_comment_card.dart';
import 'package:wat_project_frontend/presentation/job_market/widgets/review_stars_row.dart';
import 'package:wat_project_frontend/core/widgets/app_popup.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class JobDetailsPage extends StatefulWidget {
  final String jobId;
  const JobDetailsPage({super.key, required this.jobId});

  @override
  State<JobDetailsPage> createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {
  late final JobMarketBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.instance<JobMarketBloc>();
    _bloc.add(JobMarketEvent.getJobDetail(jobId: widget.jobId));
    _bloc.add(JobMarketEvent.listJobReviews(jobId: widget.jobId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<JobMarketBloc, JobMarketState>(
        listenWhen: (previous, current) =>
            previous.status != current.status ||
            previous.addToCartStatus != current.addToCartStatus,
        listener: (context, state) {
          // 1. Check for global/detail load failures
          if (state.status is UILoadFailed) {
            final msg = (state.status as UILoadFailed).message ?? 'An error occurred fetching details.';
            _showPopup(context, AppPopupType.error, 'Error', msg);
          }

          // 2. Check for targeted action successes/failures (Add to Cart)
          if (state.addToCartStatus is UILoadSuccess) {
            _showPopup(context, AppPopupType.success, 'Added to Cart', 'Job saved to cart.');
          } else if (state.addToCartStatus is UILoadFailed) {
            final msg = (state.addToCartStatus as UILoadFailed).message ?? 'Failed to save job to cart.';
            _showPopup(context, AppPopupType.error, 'Error', msg);
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
              onPressed: () => context.pop(),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => context.go('/jobs/${widget.jobId}/reviews/new'),
            backgroundColor: AppColors.primary,
            icon: const Icon(Icons.rate_review_outlined, color: Colors.white),
            label: const Text('Write Review', style: TextStyle(color: Colors.white)),
          ),
          body: BlocBuilder<JobMarketBloc, JobMarketState>(
            builder: (context, state) {
              // Primary loading indicator for page setup
              if (state.status is UILoading && state.jobDetail == null) {
                return const Center(child: CircularProgressIndicator());
              }

              final jobDetail = state.jobDetail;
              if (jobDetail == null) {
                return const Center(child: Text('Job not found.'));
              }

              return SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppDimension.space32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        jobDetail.job.position ?? 'Unknown Position',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        jobDetail.job.employerTitle ?? '',
                        style: const TextStyle(
                          fontSize: 18,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: AppDimension.space32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Salary',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              Text(
                                '\$${jobDetail.job.salaryRangeMin.toStringAsFixed(2)}/hr',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                          if (jobDetail.rating != null)
                            Row(
                              children: [
                                ReviewStarsRow(
                                  rating: jobDetail.rating!.overallRate.toDouble(),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  jobDetail.rating!.overallRate.toStringAsFixed(1),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                      const SizedBox(height: AppDimension.space32),
                      const Text(
                        'Location',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: AppDimension.space8),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${jobDetail.job.locationCity ?? ''}, ${jobDetail.job.locationState ?? ''}',
                          ),
                        ],
                      ),
                      if (jobDetail.housing != null) ...[
                        const SizedBox(height: AppDimension.space32),
                        const Text(
                          'Housing',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: AppDimension.space8),
                        Text(
                          'Housing provided.',
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            height: 1.5,
                          ),
                        ),
                      ],
                      const SizedBox(height: AppDimension.space32),
                      const Text(
                        'Reviews',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: AppDimension.space16),
                      
                      // Secondary contextual check for fetching comments
                      if (state.status is UILoading && state.reviews.isEmpty)
                        const Center(child: CircularProgressIndicator())
                      else if (state.reviews.isEmpty)
                        const Text(
                          'No reviews yet. Be the first!',
                          style: TextStyle(color: AppColors.textSecondary),
                        )
                      else
                        ...state.reviews.map(
                          (r) => Padding(
                            padding: const EdgeInsets.only(
                              bottom: AppDimension.space16,
                            ),
                            child: JobReviewCommentCard(
                              author: r.userId,
                              date: r.createdAt.toLocal().toString().split(' ').first,
                              rating: r.ratingStars.toDouble(),
                              comment: r.reviewText ?? '',
                            ),
                          ),
                        ),
                      const SizedBox(height: AppDimension.space50),
                      WatButton(
                        label: 'Save to Cart',
                        onPressed: () => _bloc.add(
                          JobMarketEvent.addJobToCart(jobId: widget.jobId),
                        ),
                      ),
                      const SizedBox(height: AppDimension.space50),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showPopup(BuildContext context, AppPopupType type, String title, String message) {
    AppPopup.show(
      context: context,
      type: type,
      title: title,
      message: message,
      buttons: [
        AppPopupButton(
          label: 'OK', 
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}