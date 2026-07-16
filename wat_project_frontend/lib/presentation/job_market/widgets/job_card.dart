import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/core/widgets/pixel_border_container.dart';
import 'package:wat_project_frontend/domain/models/job_models.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class JobCard extends StatelessWidget {
  final JobPostingModel job;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;

  const JobCard({
    super.key,
    required this.job,
    this.onTap,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    final salary = job.salaryRangeMin;
    final location =
        '${job.locationCity ?? ''}, ${job.locationState ?? ''}'.trim();
    final textColor = AppColors.text(context);
    final subtextColor = AppColors.textSub(context);
    final borderColor = AppColors.border(context);

    return PixelBorderContainer(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  border: Border.all(
                    color: borderColor,
                    width: AppDimension.pixelBorderWidth,
                  ),
                ),
                alignment: Alignment.center,
                child: AppAssets.img(
                  AppAssets.iconJobs,
                  size: 24,
                  color: AppColors.primary,
                ),
              ),
              if (onAddToCart != null)
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: AppAssets.img(
                    AppAssets.iconStar,
                    size: 20,
                    color: AppColors.secondary,
                  ),
                  onPressed: onAddToCart,
                ),
            ],
          ),
          const SizedBox(height: AppDimension.space12),
          Text(
            (job.position ?? 'UNKNOWN POSITION').toUpperCase(),
            style: GoogleFonts.pressStart2p(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: textColor,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            (job.employerTitle ?? '').toUpperCase(),
            style: GoogleFonts.pressStart2p(
              fontSize: 7,
              color: subtextColor,
              height: 1.5,
            ),
          ),
          const SizedBox(height: AppDimension.space12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Row(
                  children: [
                    AppAssets.img(
                      AppAssets.iconLocation,
                      size: 14,
                      color: subtextColor,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        location.toUpperCase(),
                        style: GoogleFonts.pressStart2p(
                          fontSize: 6,
                          color: subtextColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${salary.toStringAsFixed(2)}/HR',
                    style: GoogleFonts.pressStart2p(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
