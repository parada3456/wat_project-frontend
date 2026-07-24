import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/core/widgets/pixel_border_container.dart';
import 'package:wat_project_frontend/domain/models/job_models.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

class JobCard extends StatelessWidget {
  final JobPostingModel job;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;
  final double? rating;
  final int? reviewCount;

  const JobCard({
    super.key,
    required this.job,
    this.onTap,
    this.onAddToCart,
    this.rating,
    this.reviewCount,
  });

  String _getEmojiForJob(String? position) {
    if (position == null) return '💼';
    final pos = position.toLowerCase();
    if (pos.contains('food') ||
        pos.contains('restaurant') ||
        pos.contains('runner') ||
        pos.contains('server')) {
      return '🍔🥤';
    }
    if (pos.contains('donuts') ||
        pos.contains('dunkin') ||
        pos.contains('baker')) {
      return '🍩☕';
    }
    if (pos.contains('hotel') ||
        pos.contains('house') ||
        pos.contains('room')) {
      return '🏨🧹';
    }
    if (pos.contains('lifeguard') ||
        pos.contains('pool') ||
        pos.contains('swim')) {
      return '🏊‍♂️🌊';
    }
    return '💼';
  }

  @override
  Widget build(BuildContext context) {
    final salary = job.salaryRangeMin;
    final location = '${job.locationCity ?? ''}, ${job.locationState ?? ''}'
        .trim();

    // Deterministic mock ratings for jobs without explicit ratings
    final double displayRating =
        rating ?? (4.0 + (job.jobId.hashCode % 10) / 10.0);
    final int displayReviewCount =
        reviewCount ?? (5 + (job.jobId.hashCode % 50));

    return PixelBorderContainer(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppDimension.space16),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left: rounded logo container (mocked)
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD), // light blue
                borderRadius: BorderRadius.circular(AppDimension.radiusSmall),
              ),
              child: const Icon(
                Icons.business,
                color: AppColors.primary,
                size: 28,
              ),
            ),
            const SizedBox(width: AppDimension.space16),

            // Middle: Job details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Employer Title + Emoji
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          job.employerTitle ?? 'Unknown Employer',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _getEmojiForJob(job.position),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),

                  // Position
                  Text(
                    job.position ?? 'Unknown Position',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  // Location Row
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          location.isNotEmpty ? location : 'N/A',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Rating details row
                  Row(
                    children: [
                      const Icon(Icons.star, size: 14, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        displayRating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        '•',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '$displayReviewCount reviews',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // Right: Salary Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFE0F2F1), // light teal
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: const Color(0xFFB2DFDB)),
              ),
              child: Text(
                '\$${salary.toStringAsFixed(2)} +tips',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF00796B), // dark teal
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
