import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:wat_project_frontend/data/entities/job_review/job/job_detail_response.dart';
import 'package:wat_project_frontend/data/entities/job_review/review/job_review_entity.dart';
import 'package:wat_project_frontend/presentation/job_market/bloc/job_market_bloc.dart';
import 'package:wat_project_frontend/presentation/job_market/bloc/job_market_event.dart';
import 'package:wat_project_frontend/presentation/job_market/bloc/job_market_state.dart';
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
  JobDetailResponse? _jobDetail;
  List<JobReviewEntity> _reviews = [];
  bool _loadingDetail = true;
  bool _loadingReviews = true;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.instance<JobMarketBloc>();
    _bloc.add(GetJobDetailEvent(widget.jobId));
    _bloc.add(ListJobReviewsEvent(jobId: widget.jobId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<JobMarketBloc, JobMarketState>(
        listener: (context, state) {
          if (state is GetJobDetailSuccess) {
            setState(() {
              _jobDetail = state.jobDetail;
              _loadingDetail = false;
            });
          } else if (state is ListJobReviewsSuccess) {
            setState(() {
              _reviews = state.reviews;
              _loadingReviews = false;
            });
          } else if (state is AddJobToCartSuccess) {
            AppPopup.show(
              context: context,
              type: AppPopupType.success,
              title: 'Added to Cart',
              message: 'Job saved to cart.',
              buttons: [AppPopupButton(label: 'OK', onPressed: () => Navigator.pop(context))],
            );
          } else if (state is JobMarketFailure) {
            setState(() {
              _loadingDetail = false;
              _loadingReviews = false;
            });
            AppPopup.show(
              context: context,
              type: AppPopupType.error,
              title: 'Error',
              message: state.message,
              buttons: [AppPopupButton(label: 'OK', onPressed: () => Navigator.pop(context))],
            );
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
          body: _loadingDetail
              ? const Center(child: CircularProgressIndicator())
              : _jobDetail == null
                  ? const Center(child: Text('Job not found.'))
                  : SafeArea(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(AppDimension.space32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _jobDetail!.job.position ?? 'Unknown Position',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              _jobDetail!.job.employerTitle ?? '',
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
                                      '\$${_jobDetail!.job.salaryRangeMin.toStringAsFixed(2)}/hr',
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ],
                                ),
                                if (_jobDetail!.rating != null)
                                  Row(
                                    children: [
                                      ReviewStarsRow(
                                        rating: _jobDetail!.rating!.overallRate.toDouble(),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        _jobDetail!.rating!.overallRate.toStringAsFixed(1),
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
                                  '${_jobDetail!.job.locationCity ?? ''}, ${_jobDetail!.job.locationState ?? ''}',
                                ),
                              ],
                            ),
                            if (_jobDetail!.housing.isNotEmpty) ...[
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
                                _jobDetail!.housing.first.description ?? 'Housing provided.',
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
                            if (_loadingReviews)
                              const Center(child: CircularProgressIndicator())
                            else if (_reviews.isEmpty)
                              const Text(
                                'No reviews yet. Be the first!',
                                style: TextStyle(color: AppColors.textSecondary),
                              )
                            else
                              ..._reviews.map(
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
                              onPressed: () =>
                                  _bloc.add(AddJobToCartEvent(widget.jobId)),
                            ),
                            const SizedBox(height: AppDimension.space50),
                          ],
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}
