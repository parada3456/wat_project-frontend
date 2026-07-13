import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wat_project_frontend/domain/models/job_models.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/presentation/job_market/bloc/job_market_bloc.dart';
import 'package:wat_project_frontend/presentation/job_market/widgets/job_header_section.dart';
import 'package:wat_project_frontend/presentation/job_market/widgets/job_stats_grid.dart';
import 'package:wat_project_frontend/presentation/job_market/widgets/job_location_card.dart';
import 'package:wat_project_frontend/presentation/job_market/widgets/job_housing_card.dart';
import 'package:wat_project_frontend/presentation/job_market/widgets/job_reviews_section.dart';
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
  late final JobMarketBloc _bloc = GetIt.instance<JobMarketBloc>();

  @override
  void initState() {
    super.initState();
    _bloc.add(JobMarketEvent.getJobDetail(jobId: widget.jobId));
    _bloc.add(JobMarketEvent.listJobReviews(jobId: widget.jobId));
    _bloc.add(const JobMarketEvent.listCartItems());
  }

  void _showPopup(BuildContext ctx, AppPopupType type, String title, String msg) {
    AppPopup.show<void>(
      context: ctx,
      type: type,
      title: title,
      message: msg,
      buttons: [AppPopupButton(label: 'OK', onPressed: () => Navigator.pop(ctx))],
    );
  }

  void _showCartSuccessPopup(BuildContext ctx) {
    AppPopup.show<void>(
      context: ctx,
      type: AppPopupType.success,
      title: 'Added to Cart',
      message: 'Job saved to cart.',
      buttons: [
        AppPopupButton(label: 'OK', onPressed: () => Navigator.pop(ctx)),
        AppPopupButton(label: 'Go to Cart', isPrimary: true, onPressed: () {
          Navigator.pop(ctx);
          ctx.push('/jobs/cart');
        }),
      ],
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
            prev.removeFromCartStatus != curr.removeFromCartStatus,
        listener: (context, state) {
          if (state.status is UILoadFailed) {
            _showPopup(context, AppPopupType.error, 'Error', (state.status as UILoadFailed).message ?? 'An error occurred.');
          }
          if (state.addToCartStatus is UILoadSuccess) {
            _showCartSuccessPopup(context);
            _bloc.add(const JobMarketEvent.listCartItems());
          } else if (state.addToCartStatus is UILoadFailed) {
            _showPopup(context, AppPopupType.error, 'Error', (state.addToCartStatus as UILoadFailed).message ?? 'Failed to save job.');
          }
          if (state.removeFromCartStatus is UILoadSuccess) {
            _showPopup(context, AppPopupType.success, 'Removed from Cart', 'Job removed from cart.');
            _bloc.add(const JobMarketEvent.listCartItems());
          } else if (state.removeFromCartStatus is UILoadFailed) {
            _showPopup(context, AppPopupType.error, 'Error', (state.removeFromCartStatus as UILoadFailed).message ?? 'Failed to remove job.');
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
                  final url = state.jobDetail?.job.sourceUrl;
                  if (url == null || url.isEmpty || Uri.tryParse(url) == null) return const SizedBox.shrink();
                  return IconButton(onPressed: () => launchUrl(Uri.parse(url)), icon: const Icon(Icons.ios_share));
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
              if (jobDetail == null) return const Center(child: Text('Job not found.'));

              final cartItems = state.cartItems.where((item) => item.jobId == widget.jobId && item.status != CartStatus.removed);
              final isInCart = cartItems.isNotEmpty;
              final cartItem = isInCart ? cartItems.first : null;
              final sourceUrl = jobDetail.job.sourceUrl;
              final isUrlValid = sourceUrl != null && sourceUrl.isNotEmpty && Uri.tryParse(sourceUrl) != null;
              final scrapeStr = jobDetail.job.scrapeAt != null ? DateFormat.yMMMd().format(jobDetail.job.scrapeAt!) : 'N/A';
              final updateStr = DateFormat.yMMMd().format(jobDetail.job.updatedAt);

              return SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimension.space16, vertical: AppDimension.space32),
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
                      const Text('Description', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                      const SizedBox(height: AppDimension.space8),
                      Text(
                        jobDetail.job.description ?? 'No description provided.',
                        style: const TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.5),
                      ),
                      const SizedBox(height: AppDimension.space32),
                      Text(
                        'Scraped At: $scrapeStr | Last Updated: $updateStr',
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, fontStyle: FontStyle.italic),
                      ),
                      const SizedBox(height: AppDimension.space32),
                      JobReviewsSection(reviews: state.reviews, isLoading: state.status is UILoading),
                      const SizedBox(height: AppDimension.space50),
                      if (isUrlValid) ...[
                        WatButton(label: 'Reserve', onPressed: () => launchUrl(Uri.parse(sourceUrl))),
                        const SizedBox(height: AppDimension.space12),
                      ],
                      if (isInCart && cartItem != null)
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.error,
                            side: const BorderSide(color: AppColors.error, width: 1.5),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimension.radiusMedium)),
                            minimumSize: const Size(double.infinity, 51),
                          ),
                          onPressed: () => _bloc.add(JobMarketEvent.removeJobFromCart(cartItemId: cartItem.cartId)),
                          child: const Text('Remove from Cart', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                        )
                      else
                        WatButton(
                          label: 'Save to Cart',
                          onPressed: () => _bloc.add(JobMarketEvent.addJobToCart(jobId: widget.jobId)),
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