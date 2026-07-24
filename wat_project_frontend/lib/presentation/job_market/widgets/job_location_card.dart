import 'package:flutter/material.dart';
import 'package:wat_project_frontend/data/entities/job_review/job/job_detail_response.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

class JobLocationCard extends StatelessWidget {
  final JobDetailResponse jobDetail;

  const JobLocationCard({super.key, required this.jobDetail});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Location Details',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: AppDimension.space8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppDimension.space16),
          decoration: BoxDecoration(
            color: AppColors.backgroundAlt,
            borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${jobDetail.job.locationCity ?? 'N/A'}, ${jobDetail.job.locationState ?? 'N/A'}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              if (jobDetail.job.groupLocation != null &&
                  jobDetail.job.groupLocation!.isNotEmpty) ...[
                const SizedBox(height: AppDimension.space8),
                Text(
                  'Group Location: ${jobDetail.job.groupLocation}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
