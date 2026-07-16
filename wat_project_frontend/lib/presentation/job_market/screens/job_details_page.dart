import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wat_project_frontend/core/widgets/pixel_border_container.dart';
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
import 'package:wat_project_frontend/domain/services/auth_manager.dart';
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

  void _showPopup(BuildContext context, AppPopupType type, String title, String msg, {VoidCallback? onConfirm}) {
    AppPopup.show<void>(
      context: context,
      type: type,
      title: title,
      message: msg,
      buttons: [
        AppPopupButton(
          label: 'OK',
          onPressed: onConfirm ?? () => context.pop(),
        ),
      ],
    );
  }

  void _confirmDelete(BuildContext context) {
    AppPopup.show<void>(
      context: context,
      type: AppPopupType.warning,
      title: 'Delete Job',
      message: 'Are you sure? This action is permanent.',
      buttons: [
        const AppPopupButton(label: 'Cancel'),
        AppPopupButton(
          label: 'Delete',
          isPrimary: true,
          color: AppColors.error,
          onPressed: () {
            context.pop();
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
      title: 'Success',
      message: 'Saved to cart.',
      buttons: [
        AppPopupButton(label: 'OK', onPressed: () => context.pop()),
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

  @override
  Widget build(BuildContext context) {
    final bgColor = AppColors.bg(context);
    final textColor = AppColors.text(context);
    final subtextColor = AppColors.textSub(context);
    final borderColor = AppColors.border(context);

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
            _showPopup(context, AppPopupType.error, 'Error', (state.status as UILoadFailed).message ?? 'An error occurred.');
          }
          if (state.addToCartStatus is UILoadSuccess) {
            _showCartSuccessPopup(context);
            _bloc.add(const JobMarketEvent.listCartItems());
          } else if (state.addToCartStatus is UILoadFailed) {
            _showPopup(context, AppPopupType.error, 'Error', (state.addToCartStatus as UILoadFailed).message ?? 'Failed to save job.');
          }
          if (state.removeFromCartStatus is UILoadSuccess) {
            _showPopup(context, AppPopupType.success, 'Removed', 'Job removed from cart.');
            _bloc.add(const JobMarketEvent.listCartItems());
          } else if (state.removeFromCartStatus is UILoadFailed) {
            _showPopup(context, AppPopupType.error, 'Error', (state.removeFromCartStatus as UILoadFailed).message ?? 'Failed to remove job.');
          }
          if (state.deleteJobStatus is UILoadSuccess) {
            _showPopup(context, AppPopupType.success, 'Deleted', 'The job posting was successfully deleted.', onConfirm: () {
              context.pop();
              context.pop();
            });
          } else if (state.deleteJobStatus is UILoadFailed) {
            _showPopup(context, AppPopupType.error, 'Error', (state.deleteJobStatus as UILoadFailed).message ?? 'Failed to delete job.');
          }
        },
        child: Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            leading: IconButton(
              icon: AppAssets.img(AppAssets.iconBack, size: 20, color: textColor),
              onPressed: () => context.pop(),
            ),
            actions: [
              if (GetIt.instance<AuthSessionManager>().isAdmin) ...[
                IconButton(
                  icon: AppAssets.img(AppAssets.iconEdit, size: 20, color: textColor),
                  onPressed: () => context.push('/jobs/${widget.jobId}/edit'),
                ),
                IconButton(
                  icon: AppAssets.img(AppAssets.iconDelete, size: 20, color: AppColors.error),
                  onPressed: () => _confirmDelete(context),
                ),
              ],
              BlocBuilder<JobMarketBloc, JobMarketState>(
                builder: (context, state) {
                  final url = state.jobDetail?.job.sourceUrl;
                  if (url == null || url.isEmpty || Uri.tryParse(url) == null) return const SizedBox.shrink();
                  return IconButton(
                    onPressed: () => launchUrl(Uri.parse(url)),
                    icon: AppAssets.img(AppAssets.iconShare, size: 20, color: textColor),
                  );
                },
              ),
              BlocBuilder<JobMarketBloc, JobMarketState>(
                builder: (context, state) {
                  final cartItems = state.cartItems.where((item) => item.jobId == widget.jobId && item.status != CartStatus.removed);
                  final isInCart = cartItems.isNotEmpty;
                  final cartItem = isInCart ? cartItems.first : null;

                  if (isInCart && cartItem != null) {
                    return IconButton(
                      onPressed: () => _bloc.add(JobMarketEvent.removeJobFromCart(cartItemId: cartItem.cartId)),
                      icon: AppAssets.img(AppAssets.iconCart, size: 20, color: AppColors.primary),
                    );
                  } else {
                    return IconButton(
                      onPressed: () => _bloc.add(JobMarketEvent.addJobToCart(jobId: widget.jobId)),
                      icon: AppAssets.img(AppAssets.iconCart, size: 20, color: textColor),
                    );
                  }
                },
              ),
            ],
          ),
          floatingActionButton: GestureDetector(
            onTap: () => context.push('/jobs/${widget.jobId}/reviews/new'),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.primary,
                border: Border.all(
                  color: borderColor,
                  width: AppDimension.pixelBorderWidth,
                ),
                boxShadow: [
                  BoxShadow(
                    color: borderColor.withValues(alpha: 0.8),
                    offset: const Offset(4, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppAssets.img(AppAssets.iconReview, size: 16, color: AppColors.black),
                  const SizedBox(width: 8),
                  Text(
                    'WRITE REVIEW',
                    style: GoogleFonts.notoSansThai(
                      fontSize: 11,
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: BlocBuilder<JobMarketBloc, JobMarketState>(
            builder: (context, state) {
              if (state.status is UILoading && state.jobDetail == null) {
                return const Center(child: PixelLoadingDots(color: AppColors.primary));
              }
              final jobDetail = state.jobDetail;
              if (jobDetail == null) {
                return Center(
                  child: Text(
                    'JOB NOT FOUND.',
                    style: GoogleFonts.notoSansThai(fontSize: 12, color: textColor),
                  ),
                );
              }

              final sourceUrl = jobDetail.job.sourceUrl;
              final isUrlValid = sourceUrl != null && sourceUrl.isNotEmpty && Uri.tryParse(sourceUrl) != null;
              final scrapeStr = jobDetail.job.scrapeAt != null ? DateFormat.yMMMd().format(jobDetail.job.scrapeAt!) : 'N/A';
              final updateStr = DateFormat.yMMMd().format(jobDetail.job.updatedAt);

              return SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimension.space16,
                    vertical: AppDimension.space24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      JobHeaderSection(jobDetail: jobDetail),
                      const SizedBox(height: AppDimension.space24),
                      JobStatsGrid(jobDetail: jobDetail),
                      const SizedBox(height: AppDimension.space24),
                      JobLocationCard(jobDetail: jobDetail),
                      const SizedBox(height: AppDimension.space24),
                      if (jobDetail.housing != null) ...[
                        JobHousingCard(housing: jobDetail.housing!),
                        const SizedBox(height: AppDimension.space24),
                      ],
                      PixelSectionHeader(label: 'DESCRIPTION'),
                      const SizedBox(height: AppDimension.space12),
                      PixelBorderContainer(
                        width: double.infinity,
                        child: Text(
                          jobDetail.job.description ?? 'No description provided.',
                          style: GoogleFonts.notoSansThai(
                            fontSize: 11,
                            color: textColor,
                            height: 1.8,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppDimension.space16),
                      Text(
                        'SCRAPED: $scrapeStr | UPDATED: $updateStr'.toUpperCase(),
                        style: GoogleFonts.notoSansThai(
                          fontSize: 5,
                          color: subtextColor,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: AppDimension.space24),
                      JobReviewsSection(reviews: state.reviews, isLoading: state.status is UILoading),
                      const SizedBox(height: AppDimension.space32),
                      if (isUrlValid) ...[
                        WatButton(label: 'RESERVE JOB', onPressed: () => launchUrl(Uri.parse(sourceUrl))),
                        const SizedBox(height: AppDimension.space12),
                      ],
                      // if (isInCart && cartItem != null)
                      //   WatButton.outlined(
                      //     label: 'REMOVE FROM CART',
                      //     borderColor: AppColors.error,
                      //     textColor: AppColors.error,
                      //     onPressed: () => _bloc.add(JobMarketEvent.removeJobFromCart(cartItemId: cartItem.cartId)),
                      //   )
                      // else
                      //   WatButton(
                      //     label: 'SAVE TO CART',
                      //     onPressed: () => _bloc.add(JobMarketEvent.addJobToCart(jobId: widget.jobId)),
                      //   ),
                      // const SizedBox(height: AppDimension.space48),
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