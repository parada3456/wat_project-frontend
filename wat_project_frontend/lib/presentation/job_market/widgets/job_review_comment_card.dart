import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/core/widgets/pixel_border_container.dart';
import 'package:wat_project_frontend/presentation/job_market/widgets/review_stars_row.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class JobReviewCommentCard extends StatelessWidget {
  final String author;
  final String date;
  final double rating;
  final String comment;

  const JobReviewCommentCard({
    super.key,
    required this.author,
    required this.date,
    required this.rating,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = AppColors.text(context);
    final subtextColor = AppColors.textSub(context);

    return PixelBorderContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                author.toUpperCase(),
                style: GoogleFonts.pressStart2p(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              Text(
                date,
                style: GoogleFonts.pressStart2p(
                  fontSize: 6,
                  color: subtextColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimension.space8),
          ReviewStarsRow(rating: rating, size: 12),
          const SizedBox(height: AppDimension.space12),
          Text(
            comment,
            style: GoogleFonts.pressStart2p(
              fontSize: 7,
              color: textColor,
              height: 1.8,
            ),
          ),
        ],
      ),
    );
  }
}
