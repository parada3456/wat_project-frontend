import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/core/widgets/pixel_border_container.dart';
import 'package:wat_project_frontend/data/entities/job_review/job/job_housing_entity.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class JobHousingCard extends StatelessWidget {
  final JobHousingEntity housing;

  const JobHousingCard({
    super.key,
    required this.housing,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = AppColors.text(context);
    final subtextColor = AppColors.textSub(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'HOUSING',
          style: GoogleFonts.pressStart2p(
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
                    AppAssets.iconHome,
                    size: 18,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'HOUSING PROVIDED',
                    style: GoogleFonts.pressStart2p(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimension.space12),
              Text(
                'COST: \$${housing.weeklyRate.toStringAsFixed(2)}/WEEK',
                style: GoogleFonts.pressStart2p(
                  fontSize: 7,
                  color: subtextColor,
                  height: 1.8,
                ),
              ),
              if (housing.deposit > 0) ...[
                const SizedBox(height: 4),
                Text(
                  'DEPOSIT: \$${housing.deposit.toStringAsFixed(2)}',
                  style: GoogleFonts.pressStart2p(
                    fontSize: 7,
                    color: subtextColor,
                    height: 1.8,
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
