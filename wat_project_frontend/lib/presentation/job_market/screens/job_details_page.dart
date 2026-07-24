import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wat_project_frontend/core/widgets/app_popup.dart';
import 'package:wat_project_frontend/domain/models/job_models.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/presentation/job_market/bloc/job_market_bloc.dart';
import 'package:wat_project_frontend/presentation/job_market/widgets/job_header_section.dart';
import 'package:wat_project_frontend/presentation/job_market/widgets/job_stats_grid.dart';
import 'package:wat_project_frontend/presentation/job_market/widgets/job_location_card.dart';
import 'package:wat_project_frontend/presentation/job_market/widgets/job_housing_card.dart';
import 'package:wat_project_frontend/presentation/job_market/widgets/job_reviews_section.dart';
import 'package:wat_project_frontend/domain/services/auth_manager.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

class JobDetailsPage extends StatefulWidget {
  final String jobId;
  const JobDetailsPage({super.key, required this.jobId});

  @override
  State<JobDetailsPage> createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {
  late final JobMarketBloc _bloc = GetIt.instance<JobMarketBloc>();

  @override
  void initState() {
    super.initState();
    _bloc.add(JobMarketEvent.getJobDetail(jobId: widget.jobId));
    _bloc.add(JobMarketEvent.listJobReviews(jobId: widget.jobId));
    _bloc.add(const JobMarketEvent.listCartItems());
  }

  void _showPopup(
    BuildContext context,
    AppPopupType type,
    String title,
    String msg, {
    VoidCallback? onConfirm,
  }) {
    AppPopup.show<void>(
      context: context,
      type: type,
      title: title,
      message: msg,
      buttons: [
        AppPopupButton(
          label: 'OK',
          onPressed: onConfirm ?? () => context.pop(context),
        ),
      ],
    );
  }

  void _confirmDelete(BuildContext context) {
    AppPopup.show<void>(
      context: context,
      type: AppPopupType.warning,
      title: 'Delete Job Posting',
      message:
          'Are you sure you want to delete this job posting? This action cannot be undone.',
      buttons: [
        AppPopupButton(label: 'Cancel', onPressed: () => context.pop(context)),
        AppPopupButton(
          label: 'Delete',
          isPrimary: true,
          onPressed: () {
            context.pop(context);
            _bloc.add(JobMarketEvent.deleteJob(id: widget.jobId));
          },
        ),
      ],
    );
  }

  void _showCartSuccessPopup(BuildContext context) {
    AppPopup.show<void>(
      context: context,
      type: AppPopupType.success,
      title: 'Added to Cart',
      message: 'Job saved to cart.',
      buttons: [
        AppPopupButton(label: 'OK', onPressed: () => context.pop(context)),
        AppPopupButton(
          label: 'Go to Cart',
          isPrimary: true,
          onPressed: () {
            context.push('/jobs/cart');
          },
        ),
      ],
    );
  }

  Widget _buildRatingsBreakdownCard(JobOverallRatingModel rating) {
    return Container(
      padding: const EdgeInsets.all(AppDimension.space16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
        border: Border.all(color: AppColors.surfaceAlt),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Employee Insights',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Based on ${rating.reviewCount} verified reviews',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    rating.overallRate.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: List.generate(5, (index) {
                      final starVal = index + 1;
                      if (rating.overallRate >= starVal) {
                        return const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        );
                      } else if (rating.overallRate >= starVal - 0.5) {
                        return const Icon(
                          Icons.star_half,
                          color: Colors.amber,
                          size: 16,
                        );
                      } else {
                        return const Icon(
                          Icons.star_border,
                          color: Colors.amber,
                          size: 16,
                        );
                      }
                    }),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppDimension.space16),
          _buildRatingProgressBar('Agency / Sponsor', rating.agencyRate),
          _buildRatingProgressBar('Job Position Tasks', rating.jobRate),
          _buildRatingProgressBar('Coworkers', rating.coworkersRate),
          _buildRatingProgressBar('Town / Location', rating.townRate),
          _buildRatingProgressBar('Hours Provided', rating.hoursRate),
          _buildRatingProgressBar('Housing Conditions', rating.housingRate),
          _buildRatingProgressBar(
            'Second Job Feasibility',
            rating.secondJobFeasibilityRate,
          ),
          _buildRatingProgressBar(
            'Overtime Availability',
            rating.overtimeAvailabilityRate,
          ),
        ],
      ),
    );
  }

  Widget _buildRatingProgressBar(String title, double score) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                score.toStringAsFixed(1),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
              value: score / 5.0,
              color: AppColors.primary,
              backgroundColor: AppColors.primary.withOpacity(0.1),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<JobMarketBloc, JobMarketState>(
        listenWhen: (prev, curr) =>
            prev.status != curr.status ||
            prev.addToCartStatus != curr.addToCartStatus ||
            prev.removeFromCartStatus != curr.removeFromCartStatus ||
            prev.deleteJobStatus != curr.deleteJobStatus,
        listener: (context, state) {
          if (state.status is UILoadFailed) {
            _showPopup(
              context,
              AppPopupType.error,
              'Error',
              (state.status as UILoadFailed).message ?? 'An error occurred.',
            );
          }
          if (state.addToCartStatus is UILoadSuccess) {
            _showCartSuccessPopup(context);
            _bloc.add(const JobMarketEvent.listCartItems());
          } else if (state.addToCartStatus is UILoadFailed) {
            _showPopup(
              context,
              AppPopupType.error,
              'Error',
              (state.addToCartStatus as UILoadFailed).message ??
                  'Failed to save job.',
            );
          }
          if (state.removeFromCartStatus is UILoadSuccess) {
            _showPopup(
              context,
              AppPopupType.success,
              'Removed from Cart',
              'Job removed from cart.',
            );
            _bloc.add(const JobMarketEvent.listCartItems());
          } else if (state.removeFromCartStatus is UILoadFailed) {
            _showPopup(
              context,
              AppPopupType.error,
              'Error',
              (state.removeFromCartStatus as UILoadFailed).message ??
                  'Failed to remove job.',
            );
          }
          if (state.deleteJobStatus is UILoadSuccess) {
            _showPopup(
              context,
              AppPopupType.success,
              'Job Deleted',
              'The job posting has been successfully deleted.',
              onConfirm: () {
                context.pop();
                context.pop(true);
              },
            );
          } else if (state.deleteJobStatus is UILoadFailed) {
            _showPopup(
              context,
              AppPopupType.error,
              'Error',
              (state.deleteJobStatus as UILoadFailed).message ??
                  'Failed to delete job.',
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
            actions: [
              if (GetIt.instance<AuthSessionManager>().isAdmin) ...[
                IconButton(
                  icon: const Icon(
                    Icons.edit_outlined,
                    color: AppColors.textPrimary,
                  ),
                  onPressed: () async {
                    final res = await context.push<bool>('/jobs/${widget.jobId}/edit');
                    if (res == true && context.mounted) {
                      _bloc.add(JobMarketEvent.getJobDetail(jobId: widget.jobId));
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    color: AppColors.error,
                  ),
                  onPressed: () => _confirmDelete(context),
                ),
              ],
              BlocBuilder<JobMarketBloc, JobMarketState>(
                builder: (context, state) {
                  final url = state.jobDetail?.job.sourceUrl;
                  if (url == null || url.isEmpty || Uri.tryParse(url) == null)
                    return const SizedBox.shrink();
                  return IconButton(
                    onPressed: () => launchUrl(Uri.parse(url)),
                    icon: const Icon(Icons.ios_share),
                  );
                },
              ),
              BlocBuilder<JobMarketBloc, JobMarketState>(
                builder: (context, state) {
                  final cartItems = state.cartItems.where(
                    (item) =>
                        item.jobId == widget.jobId &&
                        item.status != CartStatus.removed,
                  );
                  final isInCart = cartItems.isNotEmpty;
                  final cartItem = isInCart ? cartItems.first : null;

                  return IconButton(
                    icon: Icon(
                      isInCart ? Icons.bookmark : Icons.bookmark_border,
                      color: isInCart
                          ? AppColors.primary
                          : AppColors.textPrimary,
                    ),
                    onPressed: () {
                      if (isInCart && cartItem != null) {
                        _bloc.add(
                          JobMarketEvent.removeJobFromCart(
                            cartItemId: cartItem.cartId,
                          ),
                        );
                      } else {
                        _bloc.add(
                          JobMarketEvent.addJobToCart(jobId: widget.jobId),
                        );
                      }
                    },
                  );
                },
              ),
            ],
          ),
          floatingActionButton: BlocBuilder<JobMarketBloc, JobMarketState>(
            builder: (context, state) {
              final sourceUrl = state.jobDetail?.job.sourceUrl;
              final isUrlValid =
                  sourceUrl != null &&
                  sourceUrl.isNotEmpty &&
                  Uri.tryParse(sourceUrl) != null;
              if (!isUrlValid) return const SizedBox.shrink();
              return FloatingActionButton.extended(
                onPressed: () => launchUrl(Uri.parse(sourceUrl)),
                backgroundColor: AppColors.primary,
                label: const Text(
                  'Apply now 🚀',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              );
            },
          ),
          body: BlocBuilder<JobMarketBloc, JobMarketState>(
            builder: (context, state) {
              if (state.status is UILoading && state.jobDetail == null) {
                return const Center(child: CircularProgressIndicator());
              }
              final jobDetail = state.jobDetail;
              if (jobDetail == null)
                return const Center(child: Text('Job not found.'));

              final scrapeStr = jobDetail.job.scrapeAt != null
                  ? DateFormat.yMMMd().format(jobDetail.job.scrapeAt!)
                  : 'N/A';
              final updateStr = DateFormat.yMMMd().format(
                jobDetail.job.updatedAt,
              );

              return SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimension.space16,
                    vertical: AppDimension.space32,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      JobHeaderSection(jobDetail: jobDetail),
                      const SizedBox(height: AppDimension.space32),
                      JobStatsGrid(jobDetail: jobDetail),
                      const SizedBox(height: AppDimension.space32),
                      JobLocationCard(jobDetail: jobDetail),
                      const SizedBox(height: AppDimension.space32),
                      if (jobDetail.housing != null) ...[
                        JobHousingCard(housing: jobDetail.housing!),
                        const SizedBox(height: AppDimension.space32),
                      ],
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: AppDimension.space8),
                      Text(
                        jobDetail.job.description ?? 'No description provided.',
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: AppDimension.space32),
                      Text(
                        'Scraped At: $scrapeStr | Last Updated: $updateStr',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: AppDimension.space32),
                      if (jobDetail.rating != null &&
                          jobDetail.rating!.reviewCount > 0) ...[
                        _buildRatingsBreakdownCard(jobDetail.rating!.toModel()),
                        const SizedBox(height: AppDimension.space32),
                      ],
                      JobReviewsSection(
                        reviews: state.reviews,
                        isLoading: state.status is UILoading,
                        onWriteReview: () =>
                            context.push('/jobs/${widget.jobId}/reviews/new'),
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
}
