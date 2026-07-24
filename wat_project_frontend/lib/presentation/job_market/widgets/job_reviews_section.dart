import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wat_project_frontend/data/entities/job_review/review/job_review_entity.dart';
import 'package:wat_project_frontend/presentation/job_market/widgets/job_review_comment_card.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

enum ReviewSortOption { newest, highestRating, lowestRating }

class JobReviewsSection extends StatefulWidget {
  final List<JobReviewEntity> reviews;
  final bool isLoading;
  final VoidCallback? onWriteReview;

  const JobReviewsSection({
    super.key,
    required this.reviews,
    required this.isLoading,
    this.onWriteReview,
  });

  @override
  State<JobReviewsSection> createState() => _JobReviewsSectionState();
}

class _JobReviewsSectionState extends State<JobReviewsSection> {
  ReviewSortOption _sortOption = ReviewSortOption.newest;

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return DateFormat.yMMMd().format(date);
  }

  @override
  Widget build(BuildContext context) {
    final sortedReviews = List<JobReviewEntity>.from(widget.reviews);
    if (_sortOption == ReviewSortOption.newest) {
      sortedReviews.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } else if (_sortOption == ReviewSortOption.highestRating) {
      sortedReviews.sort((a, b) => b.ratingStars.compareTo(a.ratingStars));
    } else if (_sortOption == ReviewSortOption.lowestRating) {
      sortedReviews.sort((a, b) => a.ratingStars.compareTo(b.ratingStars));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Reviews',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            Row(
              children: [
                const Icon(
                  Icons.sort_outlined,
                  size: 18,
                  color: AppColors.primary,
                ),
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
        if (widget.onWriteReview != null) ...[
          const SizedBox(height: AppDimension.space16),
          WatButton(label: 'Write a Review', onPressed: widget.onWriteReview),
        ],
        const SizedBox(height: AppDimension.space16),
        if (widget.isLoading && widget.reviews.isEmpty)
          const Center(child: CircularProgressIndicator())
        else if (widget.reviews.isEmpty)
          const Text(
            'No reviews yet. Be the first!',
            style: TextStyle(color: AppColors.textSecondary),
          )
        else
          ...sortedReviews.map(
            (r) => Padding(
              padding: const EdgeInsets.only(bottom: AppDimension.space16),
              child: JobReviewCommentCard(
                author: r.userId,
                date: _formatDate(r.createdAt),
                rating: r.ratingStars.toDouble(),
                comment: r.reviewText ?? '',
              ),
            ),
          ),
      ],
    );
  }
}
