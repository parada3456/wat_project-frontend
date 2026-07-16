import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:wat_project_frontend/data/entities/job_review/review/job_review_entity.dart';
import 'package:wat_project_frontend/presentation/job_market/widgets/job_review_comment_card.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

enum ReviewSortOption { newest, highestRating, lowestRating }

class JobReviewsSection extends StatefulWidget {
  final List<JobReviewEntity> reviews;
  final bool isLoading;

  const JobReviewsSection({
    super.key,
    required this.reviews,
    required this.isLoading,
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

    final textColor = AppColors.text(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'REVIEWS',
              style: GoogleFonts.notoSansThai(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            Row(
              children: [
                AppAssets.img(
                  AppAssets.iconBack,
                  size: 14,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 4),
                PopupMenuButton<ReviewSortOption>(
                  initialValue: _sortOption,
                  color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                  onSelected: (option) {
                    setState(() {
                      _sortOption = option;
                    });
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: ReviewSortOption.newest,
                      child: Text(
                        'NEWEST FIRST',
                        style: GoogleFonts.notoSansThai(fontSize: 7, color: textColor),
                      ),
                    ),
                    PopupMenuItem(
                      value: ReviewSortOption.highestRating,
                      child: Text(
                        'HIGHEST RATING',
                        style: GoogleFonts.notoSansThai(fontSize: 7, color: textColor),
                      ),
                    ),
                    PopupMenuItem(
                      value: ReviewSortOption.lowestRating,
                      child: Text(
                        'LOWEST RATING',
                        style: GoogleFonts.notoSansThai(fontSize: 7, color: textColor),
                      ),
                    ),
                  ],
                  child: Text(
                    _sortOption == ReviewSortOption.newest
                        ? 'NEWEST'
                        : _sortOption == ReviewSortOption.highestRating
                            ? 'HIGHEST'
                            : 'LOWEST',
                    style: GoogleFonts.notoSansThai(
                      fontSize: 8,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppDimension.space16),
        if (widget.isLoading && widget.reviews.isEmpty)
          const Center(child: PixelLoadingDots(color: AppColors.primary))
        else if (widget.reviews.isEmpty)
          Text(
            'NO REVIEWS YET. BE THE FIRST!',
            style: GoogleFonts.notoSansThai(
              fontSize: 7,
              color: AppColors.textSub(context),
            ),
          )
        else
          ...sortedReviews.map(
            (r) => Padding(
              padding: const EdgeInsets.only(
                bottom: AppDimension.space16,
              ),
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
