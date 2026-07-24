import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/core/widgets/pixel_border_container.dart';
import 'package:wat_project_frontend/data/entities/job_review/job/job_detail_response.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

class JobLocationCard extends StatelessWidget {
  final JobDetailResponse jobDetail;

  const JobLocationCard({super.key, required this.jobDetail});

  @override
  Widget build(BuildContext context) {
    final textColor = AppColors.text(context);
    final subtextColor = AppColors.textSub(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'LOCATION DETAILS',
          style: GoogleFonts.notoSansThai(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: AppDimension.space8),
        PixelBorderContainer(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AppAssets.img(
                    AppAssets.iconLocation,
                    size: 18,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${jobDetail.job.locationCity ?? 'N/A'}, ${jobDetail.job.locationState ?? 'N/A'}'.toUpperCase(),
                      style: GoogleFonts.notoSansThai(
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
              if (jobDetail.job.groupLocation != null && jobDetail.job.groupLocation!.isNotEmpty) ...[
                const SizedBox(height: AppDimension.space12),
                Text(
                  'GROUP LOCATION: ${jobDetail.job.groupLocation!.toUpperCase()}',
                  style: GoogleFonts.notoSansThai(
                    fontSize: 7,
                    color: subtextColor,
                    height: 1.5,
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
