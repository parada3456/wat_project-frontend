import 'package:flutter/material.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';
class MissionCalendar extends StatelessWidget {
  const MissionCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    // Placeholder for a proper calendar implementation (e.g., table_calendar)
    return Container(
      padding: const EdgeInsets.all(AppDimension.space16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'June 2026',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppDimension.space16),
          // Simple Grid Placeholder
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: 30,
            itemBuilder: (context, index) {
              final day = index + 1;
              final isDeadline = day == 20 || day == 25;
              return Container(
                decoration: BoxDecoration(
                  color: isDeadline ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
                  shape: BoxShape.circle,
                  border: isDeadline ? Border.all(color: AppColors.primary) : null,
                ),
                child: Center(
                  child: Text(
                    '$day',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isDeadline ? FontWeight.w700 : FontWeight.w400,
                      color: isDeadline ? AppColors.primary : AppColors.textPrimary,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
