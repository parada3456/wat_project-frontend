import 'package:flutter/material.dart';
import 'package:wat_project_frontend/data/entities/job_review/job/job_housing_entity.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

class JobHousingCard extends StatelessWidget {
  final JobHousingEntity housing;

  const JobHousingCard({super.key, required this.housing});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Housing',
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
              const Row(
                children: [
                  Icon(Icons.home_outlined, color: AppColors.primary),
                  SizedBox(width: 8),
                  Text(
                    'Housing Provided',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: AppDimension.space8),
              Text(
                'Cost: \$${housing.weeklyRate.toStringAsFixed(2)}/week',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              if (housing.deposit > 0)
                Text(
                  'Deposit: \$${housing.deposit.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
