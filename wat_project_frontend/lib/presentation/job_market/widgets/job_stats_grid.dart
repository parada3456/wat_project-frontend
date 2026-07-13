import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
      crossAxisSpacing: AppDimension.space12,
      mainAxisSpacing: AppDimension.space12,
      childAspectRatio: 2.2,
      children: [
        _buildStatCard(
          icon: Icons.monetization_on_outlined,
          label: 'Salary (Min)',
          value: '\$${jobDetail.job.salaryRangeMin.toStringAsFixed(2)}/hr',
        ),
        _buildStatCard(
          icon: Icons.monetization_on,
          label: 'Salary (Max)',
          value: '\$${jobDetail.job.salaryRangeMax.toStringAsFixed(2)}/hr',
        ),
        _buildStatCard(
          icon: Icons.work_outline,
          label: 'Position Type',
          value: jobDetail.job.positionType ?? 'N/A',
        ),
        _buildStatCard(
          icon: Icons.people_outline,
          label: 'Available Slots',
          value: '${jobDetail.job.availableSlots} slots',
        ),
        _buildStatCard(
          icon: Icons.assignment_ind_outlined,
          label: 'Visa Sponsor',
          value: jobDetail.job.usSponsor ? 'Sponsor' : 'No Sponsor',
          valueColor: jobDetail.job.usSponsor ? Colors.green : Colors.red,
        ),
        _buildStatCard(
          icon: Icons.calendar_today_outlined,
          label: 'Posted Date',
          value: _formatDate(jobDetail.job.postedAt),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppDimension.space8),
      decoration: BoxDecoration(
        color: AppColors.backgroundAlt,
        borderRadius: BorderRadius.circular(AppDimension.radiusSmall),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 12,
                    color: valueColor ?? AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
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
