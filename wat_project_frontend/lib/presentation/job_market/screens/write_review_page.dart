import 'package:flutter/material.dart';
import 'package:wat_project_frontend/presentation/job_market/widgets/review_stars_row.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_input_field.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class WriteReviewPage extends StatefulWidget {
  const WriteReviewPage({super.key});

  @override
  State<WriteReviewPage> createState() => _WriteReviewPageState();
}

class _WriteReviewPageState extends State<WriteReviewPage> {
  final _reviewController = TextEditingController();
  double _rating = 5.0;

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                'Lifeguard at Disney World',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppDimension.space32),
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
                  borderRadius: BorderRadius.circular(AppDimension.radiusSmall),
                ),
                padding: const EdgeInsets.symmetric(horizontal: AppDimension.space16),
                child: TextField(
                  controller: _reviewController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: 'Share details of your work, housing, and tips for others...',
                    hintStyle: TextStyle(fontSize: 14, color: AppColors.textSecondary),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: AppDimension.space50),
              WatButton(
                label: 'Submit Review',
                onPressed: () {
                  // TODO: Implement Submit Logic
                },
              ),
              const SizedBox(height: AppDimension.space50),
            ],
          ),
        ),
      ),
    );
  }
}
