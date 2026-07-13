import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
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
      AppPopup.show(
        context: context,
        type: AppPopupType.warning,
        title: 'Required',
        message: 'Please write your review before submitting.',
        buttons: [
          AppPopupButton(
            label: 'OK', 
            onPressed: () => Navigator.pop(context),
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
    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<JobMarketBloc, JobMarketState>(
        listenWhen: (previous, current) =>
            previous.createReviewStatus != current.createReviewStatus,
        listener: (context, state) {
          if (state.createReviewStatus is UILoadSuccess) {
            // Dismiss current page upon successful post submission
            Navigator.pop(context);
          } else if (state.createReviewStatus is UILoadFailed) {
            final msg = (state.createReviewStatus as UILoadFailed).message ?? 
                'Failed to submit review.';
            AppPopup.show(
              context: context,
              type: AppPopupType.error,
              title: 'Error',
              message: msg,
              buttons: [
                AppPopupButton(
                  label: 'OK', 
                  onPressed: () => Navigator.pop(context),
                )
              ],
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
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              'Write a Review',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppDimension.space32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'How was your experience?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppDimension.space16),
                  Center(
                    child: ReviewStarsRow(
                      rating: _rating,
                      size: 40,
                      isInteractive: true,
                      onRatingChanged: (val) => setState(() => _rating = val),
                    ),
                  ),
                  const SizedBox(height: AppDimension.space32),
                  const Text(
                    'Your Review',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppDimension.space8),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.backgroundAlt,
                      borderRadius: BorderRadius.circular(
                        AppDimension.radiusSmall,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimension.space16,
                    ),
                    child: TextField(
                      controller: _reviewController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText:
                            'Share details of your work, housing, and tips for others...',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppDimension.space50),
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