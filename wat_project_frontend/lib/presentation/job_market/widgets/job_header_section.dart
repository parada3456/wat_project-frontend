import 'package:flutter/material.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          jobDetail.job.position ?? 'Unknown Position',
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppDimension.space4),
        Text(
          jobDetail.job.employerTitle ?? 'Unknown Employer',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
        if (jobDetail.job.agencyName != null && jobDetail.job.agencyName!.isNotEmpty) ...[
          const SizedBox(height: AppDimension.space4),
          Text(
            'Agency: ${jobDetail.job.agencyName}',
            style: const TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              color: AppColors.textSecondary,
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
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
