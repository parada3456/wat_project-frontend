import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/data/entities/job_review/job/job_detail_response.dart';
import 'package:wat_project_frontend/presentation/job_market/widgets/review_stars_row.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class JobHeaderSection extends StatelessWidget {
  final JobDetailResponse jobDetail;

  const JobHeaderSection({
    super.key,
    required this.jobDetail,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = AppColors.text(context);
    final subtextColor = AppColors.textSub(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          (jobDetail.job.position ?? 'UNKNOWN POSITION').toUpperCase(),
          style: GoogleFonts.pressStart2p(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: textColor,
            height: 1.5,
          ),
        ),
        const SizedBox(height: AppDimension.space8),
        Text(
          (jobDetail.job.employerTitle ?? 'UNKNOWN EMPLOYER').toUpperCase(),
          style: GoogleFonts.pressStart2p(
            fontSize: 9,
            fontWeight: FontWeight.bold,
            color: subtextColor,
            height: 1.5,
          ),
        ),
        if (jobDetail.job.agencyName != null && jobDetail.job.agencyName!.isNotEmpty) ...[
          const SizedBox(height: AppDimension.space8),
          Text(
            'AGENCY: ${jobDetail.job.agencyName!.toUpperCase()}',
            style: GoogleFonts.pressStart2p(
              fontSize: 7,
              color: subtextColor,
              height: 1.5,
            ),
          ),
        ],
        const SizedBox(height: AppDimension.space16),
        if (jobDetail.rating != null)
          Row(
            children: [
              ReviewStarsRow(
                rating: jobDetail.rating!.overallRate.toDouble(),
              ),
              const SizedBox(width: 8),
              Text(
                jobDetail.rating!.overallRate.toStringAsFixed(1),
                style: GoogleFonts.pressStart2p(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
