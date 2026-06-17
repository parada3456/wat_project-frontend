import 'package:flutter/material.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/widgets/mission_card.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class MissionsDashboardPage extends StatelessWidget {
  const MissionsDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundAlt,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Missions',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today_outlined, color: AppColors.textPrimary),
            onPressed: () {
              // TODO: Navigate to Calendar
            },
          ),
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.textPrimary),
            onPressed: () {
              // TODO: Navigate to Search
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimension.space16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Phase 1: Preparation',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppDimension.space16),
              const MissionCard(
                title: 'Visa Application Prep',
                deadline: 'June 20',
                bonusPoints: 500,
                isMandatory: true,
                progress: 0.6,
              ),
              const SizedBox(height: AppDimension.space16),
              const MissionCard(
                title: 'Flight Ticket Booking',
                deadline: 'June 25',
                bonusPoints: 300,
                progress: 0.2,
              ),
              const SizedBox(height: AppDimension.space32),
              const Text(
                'Explore Missions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppDimension.space16),
              const MissionCard(
                title: 'Learn Basic English',
                deadline: 'July 10',
                bonusPoints: 200,
                progress: 0.0,
              ),
              const SizedBox(height: AppDimension.space16),
              const MissionCard(
                title: 'US Culture Guide',
                deadline: 'July 15',
                bonusPoints: 150,
                progress: 0.1,
              ),
              const SizedBox(height: AppDimension.space50),
            ],
          ),
        ),
      ),
    );
  }
}
