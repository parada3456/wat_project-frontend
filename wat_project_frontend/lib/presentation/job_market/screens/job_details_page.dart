import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wat_project_frontend/domain/models/job_models.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/data/entities/job_review/review/job_review_entity.dart';
import 'package:wat_project_frontend/presentation/job_market/bloc/job_market_bloc.dart';
import 'package:wat_project_frontend/presentation/job_market/widgets/job_review_comment_card.dart';
import 'package:wat_project_frontend/presentation/job_market/widgets/review_stars_row.dart';
import 'package:wat_project_frontend/core/widgets/app_popup.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

enum ReviewSortOption { newest, highestRating, lowestRating }

class JobDetailsPage extends StatefulWidget {
  final String jobId;
  const JobDetailsPage({super.key, required this.jobId});

  @override
  State<JobDetailsPage> createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {
  late final JobMarketBloc _bloc;
  ReviewSortOption _sortOption = ReviewSortOption.newest;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.instance<JobMarketBloc>();
    _bloc.add(JobMarketEvent.getJobDetail(jobId: widget.jobId));
    _bloc.add(JobMarketEvent.listJobReviews(jobId: widget.jobId));
    _bloc.add(const JobMarketEvent.listCartItems());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<JobMarketBloc, JobMarketState>(
        listenWhen: (previous, current) =>
            previous.status != current.status ||
            previous.addToCartStatus != current.addToCartStatus ||
            previous.removeFromCartStatus != current.removeFromCartStatus,
        listener: (context, state) {
          // 1. Check for global/detail load failures
          if (state.status is UILoadFailed) {
            final msg = (state.status as UILoadFailed).message ?? 'An error occurred fetching details.';
            _showPopup(context, AppPopupType.error, 'Error', msg);
          }

          // 2. Check for targeted action successes/failures (Add to Cart)
          if (state.addToCartStatus is UILoadSuccess) {
            _showCartSuccessPopup(context);
            _bloc.add(const JobMarketEvent.listCartItems());
          } else if (state.addToCartStatus is UILoadFailed) {
            final msg = (state.addToCartStatus as UILoadFailed).message ?? 'Failed to save job to cart.';
            _showPopup(context, AppPopupType.error, 'Error', msg);
          }

          // 3. Check for targeted action successes/failures (Remove from Cart)
          if (state.removeFromCartStatus is UILoadSuccess) {
            _showPopup(context, AppPopupType.success, 'Removed from Cart', 'Job removed from cart.');
            _bloc.add(const JobMarketEvent.listCartItems());
          } else if (state.removeFromCartStatus is UILoadFailed) {
            final msg = (state.removeFromCartStatus as UILoadFailed).message ?? 'Failed to remove job from cart.';
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
            actions: [
              BlocBuilder<JobMarketBloc, JobMarketState>(
                builder: (context, state) {
                  final jobDetail = state.jobDetail;
                  final sourceUrl = jobDetail?.job.sourceUrl;
                  if (sourceUrl == null || sourceUrl.isEmpty || Uri.tryParse(sourceUrl) == null) {
                    return const SizedBox.shrink();
                  }
                  return IconButton(
                    onPressed: () => launchUrl(Uri.parse(sourceUrl)),
                    icon: const Icon(Icons.ios_share),
                  );
                },
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => context.push('/jobs/${widget.jobId}/reviews/new'),
            backgroundColor: AppColors.primary,
            icon: const Icon(Icons.rate_review_outlined, color: Colors.white),
            label: const Text('Write Review', style: TextStyle(color: Colors.white)),
          ),
          body: BlocBuilder<JobMarketBloc, JobMarketState>(
            builder: (context, state) {
              if (state.status is UILoading && state.jobDetail == null) {
                return const Center(child: CircularProgressIndicator());
              }

              final jobDetail = state.jobDetail;
              if (jobDetail == null) {
                return const Center(child: Text('Job not found.'));
              }

              // Determine if the job is already in the cart
              UserCartModel? cartItem;
              for (final item in state.cartItems) {
                if (item.jobId == widget.jobId && item.status != CartStatus.removed) {
                  cartItem = item;
                  break;
                }
              }
              final isInCart = cartItem != null;

              // Check if sourceUrl is present and valid
              final sourceUrl = jobDetail.job.sourceUrl;
              final isUrlValid = sourceUrl != null && sourceUrl.isNotEmpty && Uri.tryParse(sourceUrl) != null;

              // Format date helper
              String formatDate(DateTime? date) {
                if (date == null) return 'N/A';
                return DateFormat.yMMMd().format(date);
              }

              // Sort reviews
              final sortedReviews = List<JobReviewEntity>.from(state.reviews);
              if (_sortOption == ReviewSortOption.newest) {
                sortedReviews.sort((a, b) => b.createdAt.compareTo(a.createdAt));
              } else if (_sortOption == ReviewSortOption.highestRating) {
                sortedReviews.sort((a, b) => b.ratingStars.compareTo(a.ratingStars));
              } else if (_sortOption == ReviewSortOption.lowestRating) {
                sortedReviews.sort((a, b) => a.ratingStars.compareTo(b.ratingStars));
              }

              return SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimension.space16,
                    vertical: AppDimension.space32,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Section
                      Text(
                        jobDetail.job.position ?? 'Unknown Position',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: AppDimension.space4),
                      Text(
                        jobDetail.job.employerTitle ?? 'Unknown Employer',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      if (jobDetail.job.agencyName != null && jobDetail.job.agencyName!.isNotEmpty) ...[
                        const SizedBox(height: AppDimension.space4),
                        Text(
                          'Agency: ${jobDetail.job.agencyName}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                      const SizedBox(height: AppDimension.space16),

                      // Rating Row
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
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: AppDimension.space32),

                      // Salary & Key Stats Grid
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: AppDimension.space12,
                        mainAxisSpacing: AppDimension.space12,
                        childAspectRatio: 2.2,
                        children: [
                          _buildStatCard(
                            icon: Icons.monetization_on_outlined,
                            label: 'Salary (Min)',
                            value: '\$${jobDetail.job.salaryRangeMin.toStringAsFixed(2)}/hr',
                          ),
                          _buildStatCard(
                            icon: Icons.monetization_on,
                            label: 'Salary (Max)',
                            value: '\$${jobDetail.job.salaryRangeMax.toStringAsFixed(2)}/hr',
                          ),
                          _buildStatCard(
                            icon: Icons.work_outline,
                            label: 'Position Type',
                            value: jobDetail.job.positionType ?? 'N/A',
                          ),
                          _buildStatCard(
                            icon: Icons.people_outline,
                            label: 'Available Slots',
                            value: '${jobDetail.job.availableSlots} slots',
                          ),
                          _buildStatCard(
                            icon: Icons.assignment_ind_outlined,
                            label: 'Visa Sponsor',
                            value: jobDetail.job.usSponsor ? 'Sponsor' : 'No Sponsor',
                            valueColor: jobDetail.job.usSponsor ? Colors.green : Colors.red,
                          ),
                          _buildStatCard(
                            icon: Icons.calendar_today_outlined,
                            label: 'Posted Date',
                            value: formatDate(jobDetail.job.postedAt),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimension.space32),

                      // Location Card
                      const Text(
                        'Location Details',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: AppDimension.space8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppDimension.space16),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundAlt,
                          borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.location_on_outlined, color: AppColors.primary),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    '${jobDetail.job.locationCity ?? 'N/A'}, ${jobDetail.job.locationState ?? 'N/A'}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (jobDetail.job.groupLocation != null && jobDetail.job.groupLocation!.isNotEmpty) ...[
                              const SizedBox(height: AppDimension.space8),
                              Text(
                                'Group Location: ${jobDetail.job.groupLocation}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: AppDimension.space32),

                      // Housing Card
                      if (jobDetail.housing != null) ...[
                        const Text(
                          'Housing',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: AppDimension.space8),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(AppDimension.space16),
                          decoration: BoxDecoration(
                            color: AppColors.backgroundAlt,
                            borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(Icons.home_outlined, color: AppColors.primary),
                                  SizedBox(width: 8),
                                  Text(
                                    'Housing Provided',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: AppDimension.space8),
                              Text(
                                'Cost: \$${jobDetail.housing!.weeklyRate.toStringAsFixed(2)}/week',
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                  height: 1.5,
                                ),
                              ),
                              if (jobDetail.housing!.deposit > 0)
                                Text(
                                  'Deposit: \$${jobDetail.housing!.deposit.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    color: AppColors.textSecondary,
                                    height: 1.5,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppDimension.space32),
                      ],

                      // Description
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

                      // Meta details
                      Text(
                        'Scraped At: ${formatDate(jobDetail.job.scrapeAt)} | Last Updated: ${formatDate(jobDetail.job.updatedAt)}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: AppDimension.space32),

                      // Reviews Header with Sorting & Filtering
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Reviews',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.sort_outlined, size: 18, color: AppColors.primary),
                              const SizedBox(width: 4),
                              PopupMenuButton<ReviewSortOption>(
                                initialValue: _sortOption,
                                onSelected: (option) {
                                  setState(() {
                                    _sortOption = option;
                                  });
                                },
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    value: ReviewSortOption.newest,
                                    child: Text('Newest First'),
                                  ),
                                  const PopupMenuItem(
                                    value: ReviewSortOption.highestRating,
                                    child: Text('Highest Rating'),
                                  ),
                                  const PopupMenuItem(
                                    value: ReviewSortOption.lowestRating,
                                    child: Text('Lowest Rating'),
                                  ),
                                ],
                                child: Text(
                                  _sortOption == ReviewSortOption.newest
                                      ? 'Newest'
                                      : _sortOption == ReviewSortOption.highestRating
                                          ? 'Highest'
                                          : 'Lowest',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimension.space16),

                      // Reviews List
                      if (state.status is UILoading && state.reviews.isEmpty)
                        const Center(child: CircularProgressIndicator())
                      else if (state.reviews.isEmpty)
                        const Text(
                          'No reviews yet. Be the first!',
                          style: TextStyle(color: AppColors.textSecondary),
                        )
                      else
                        ...sortedReviews.map(
                          (r) => Padding(
                            padding: const EdgeInsets.only(
                              bottom: AppDimension.space16,
                            ),
                            child: JobReviewCommentCard(
                              author: r.userId,
                              date: formatDate(r.createdAt),
                              rating: r.ratingStars.toDouble(),
                              comment: r.reviewText ?? '',
                            ),
                          ),
                        ),
                      const SizedBox(height: AppDimension.space50),

                      // Reserve button
                      if (isUrlValid) ...[
                        WatButton(
                          label: 'Reserve',
                          onPressed: () => launchUrl(Uri.parse(sourceUrl)),
                        ),
                        const SizedBox(height: AppDimension.space12),
                      ],

                      // Save to Cart/Remove from Cart action button
                      if (isInCart)
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.error,
                            side: const BorderSide(color: AppColors.error, width: 1.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
                            ),
                            minimumSize: const Size(double.infinity, 51),
                          ),
                          onPressed: () => _bloc.add(
                            JobMarketEvent.removeJobFromCart(cartItemId: cartItem!.cartId),
                          ),
                          child: const Text(
                            'Remove from Cart',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                      else
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

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppDimension.space8),
      decoration: BoxDecoration(
        color: AppColors.backgroundAlt,
        borderRadius: BorderRadius.circular(AppDimension.radiusSmall),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 12,
                    color: valueColor ?? AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showPopup(BuildContext context, AppPopupType type, String title, String message) {
    AppPopup.show<void>(
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

  void _showCartSuccessPopup(BuildContext context) {
    AppPopup.show<void>(
      context: context,
      type: AppPopupType.success,
      title: 'Added to Cart',
      message: 'Job saved to cart.',
      buttons: [
        AppPopupButton(
          label: 'OK',
          onPressed: () => Navigator.pop(context),
        ),
        AppPopupButton(
          label: 'Go to Cart',
          isPrimary: true,
          onPressed: () {
            Navigator.pop(context); // Close the popup first
            context.push('/jobs/cart'); // Navigate to the cart
          },
        ),
      ],
    );
  }
}