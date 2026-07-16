import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:wat_project_frontend/core/widgets/pixel_border_container.dart';
import 'package:wat_project_frontend/data/entities/job_review/job/job_detail_response.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class JobStatsGrid extends StatelessWidget {
  final JobDetailResponse jobDetail;

  const JobStatsGrid({
    super.key,
    required this.jobDetail,
  });

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return DateFormat.yMMMd().format(date);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: AppDimension.space8,
      mainAxisSpacing: AppDimension.space8,
      childAspectRatio: 1.6,
      children: [
        _buildStatCard(
          context: context,
          icon: AppAssets.iconSalary,
          label: 'SALARY (MIN)',
          value: '\$${jobDetail.job.salaryRangeMin.toStringAsFixed(2)}/HR',
        ),
        _buildStatCard(
          context: context,
          icon: AppAssets.iconSalary,
          label: 'SALARY (MAX)',
          value: '\$${jobDetail.job.salaryRangeMax.toStringAsFixed(2)}/HR',
        ),
        _buildStatCard(
          context: context,
          icon: AppAssets.iconJobs,
          label: 'POSITION TYPE',
          value: (jobDetail.job.positionType ?? 'N/A').toUpperCase(),
        ),
        _buildStatCard(
          context: context,
          icon: AppAssets.iconSlots,
          label: 'SLOTS',
          value: '${jobDetail.job.availableSlots} SLOTS',
        ),
        _buildStatCard(
          context: context,
          icon: AppAssets.iconSponsor,
          label: 'SPONSOR',
          value: jobDetail.job.usSponsor ? 'SPONSOR' : 'NO SPONSOR',
          valueColor: jobDetail.job.usSponsor ? AppColors.success : AppColors.error,
        ),
        _buildStatCard(
          context: context,
          icon: AppAssets.iconCalendar,
          label: 'POSTED',
          value: _formatDate(jobDetail.job.postedAt).toUpperCase(),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required BuildContext context,
    required String icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    final textColor = valueColor ?? AppColors.text(context);
    final subtextColor = AppColors.textSub(context);

    return PixelBorderContainer(
      padding: const EdgeInsets.all(AppDimension.space8),
      child: Row(
        children: [
          AppAssets.img(icon, color: AppColors.primary, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: GoogleFonts.notoSansThai(
                    fontSize: 5,
                    color: subtextColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: GoogleFonts.notoSansThai(
                    fontSize: 6,
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
