import 'package:flutter/material.dart';
import 'package:wat_project_frontend/presentation/job_market/widgets/job_review_comment_card.dart';
import 'package:wat_project_frontend/presentation/job_market/widgets/review_stars_row.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class JobDetailsPage extends StatelessWidget {
  const JobDetailsPage({super.key});

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
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: AppColors.primary),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimension.space32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Lifeguard',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const Text(
                'Disney World Resort',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppDimension.space32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Salary',
                        style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
                      ),
                      Text(
                        '\$16.50/hr',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const ReviewStarsRow(rating: 4.8),
                      const SizedBox(width: 8),
                      const Text(
                        '4.8',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: AppDimension.space32),
              const Text(
                'Location',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: AppDimension.space8),
              const Row(
                children: [
                  Icon(Icons.location_on_outlined, color: AppColors.primary),
                  SizedBox(width: 8),
                  Text('Orlando, Florida'),
                ],
              ),
              const SizedBox(height: AppDimension.space32),
              const Text(
                'Housing',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: AppDimension.space8),
              const Text(
                'On-site employee complex. \$150/week including transportation to parks.',
                style: TextStyle(color: AppColors.textSecondary, height: 1.5),
              ),
              const SizedBox(height: AppDimension.space32),
              const Text(
                'Reviews',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: AppDimension.space16),
              const JobReviewCommentCard(
                author: 'Jane Smith',
                date: 'May 20, 2026',
                rating: 5.0,
                comment: 'Amazing experience! The housing is great and the people are friendly.',
              ),
              const SizedBox(height: AppDimension.space16),
              const JobReviewCommentCard(
                author: 'Mike Johnson',
                date: 'May 15, 2026',
                rating: 4.0,
                comment: 'Good job but very hot in the summer. Make sure you stay hydrated.',
              ),
              const SizedBox(height: AppDimension.space50),
              WatButton(
                label: 'Save to Cart',
                onPressed: () {},
              ),
              const SizedBox(height: AppDimension.space50),
            ],
          ),
        ),
      ),
    );
  }
}
