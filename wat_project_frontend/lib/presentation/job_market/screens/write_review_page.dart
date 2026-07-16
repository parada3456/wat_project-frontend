import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/core/widgets/pixel_border_container.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/job_review/create_review_request.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/presentation/job_market/bloc/job_market_bloc.dart';
import 'package:wat_project_frontend/presentation/job_market/widgets/review_stars_row.dart';
import 'package:wat_project_frontend/core/widgets/app_popup.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class WriteReviewPage extends StatefulWidget {
  final String jobId;
  const WriteReviewPage({super.key, required this.jobId});

  @override
  State<WriteReviewPage> createState() => _WriteReviewPageState();
}

class _WriteReviewPageState extends State<WriteReviewPage> {
  final _reviewController = TextEditingController();
  double _rating = 5.0;
  late final JobMarketBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.instance<JobMarketBloc>();
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_reviewController.text.trim().isEmpty) {
      AppPopup.show<void>(
        context: context,
        type: AppPopupType.warning,
        title: 'Required',
        message: 'Please write your review before submitting.',
        buttons: [
          AppPopupButton(
            label: 'OK',
            onPressed: () => context.pop(),
          )
        ],
      );
      return;
    }

    _bloc.add(
      JobMarketEvent.createJobReview(
        request: CreateReviewRequest(
          jobId: widget.jobId,
          ratingStars: _rating,
          reviewText: _reviewController.text.trim(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textColor = AppColors.text(context);
    final subtextColor = AppColors.textSub(context);

    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<JobMarketBloc, JobMarketState>(
        listenWhen: (previous, current) =>
            previous.createReviewStatus != current.createReviewStatus,
        listener: (context, state) {
          if (state.createReviewStatus is UILoadSuccess) {
            context.pop();
          } else if (state.createReviewStatus is UILoadFailed) {
            final msg = (state.createReviewStatus as UILoadFailed).message ??
                'Failed to submit review.';
            AppPopup.show<void>(
              context: context,
              type: AppPopupType.error,
              title: 'Error',
              message: msg,
              buttons: [
                AppPopupButton(
                  label: 'OK',
                  onPressed: () => context.pop(),
                )
              ],
            );
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.bg(context),
          appBar: AppBar(
            leading: IconButton(
              icon: AppAssets.img(AppAssets.iconBack, size: 20, color: textColor),
              onPressed: () => context.pop(),
            ),
            title: const Text('WRITE REVIEW'),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimension.space24,
                vertical: AppDimension.space32,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'HOW WAS YOUR EXPERIENCE?',
                    style: GoogleFonts.pressStart2p(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: AppDimension.space16),
                  Center(
                    child: ReviewStarsRow(
                      rating: _rating,
                      size: 32,
                      isInteractive: true,
                      onRatingChanged: (val) => setState(() => _rating = val),
                    ),
                  ),
                  const SizedBox(height: AppDimension.space32),
                  Text(
                    'YOUR REVIEW',
                    style: GoogleFonts.pressStart2p(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: AppDimension.space8),
                  PixelBorderContainer(
                    child: TextField(
                      controller: _reviewController,
                      maxLines: 5,
                      style: GoogleFonts.pressStart2p(
                        fontSize: 8,
                        color: textColor,
                        height: 1.6,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Share your work experience, housing conditions, or tips...',
                        hintStyle: GoogleFonts.pressStart2p(
                          fontSize: 7,
                          color: subtextColor,
                          height: 1.6,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppDimension.space48),
                  BlocBuilder<JobMarketBloc, JobMarketState>(
                    buildWhen: (previous, current) =>
                        previous.createReviewStatus != current.createReviewStatus,
                    builder: (context, state) {
                      return WatButton(
                        label: 'Submit Review',
                        isLoading: state.createReviewStatus is UILoading,
                        onPressed: _submit,
                      );
                    },
                  ),
                  const SizedBox(height: AppDimension.space48),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}