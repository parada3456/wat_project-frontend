import 'package:flutter/material.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/widgets/mission_calendar.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/widgets/mission_card.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class MissionCalendarPage extends StatelessWidget {
  const MissionCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundAlt,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Mission Calendar',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimension.space16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MissionCalendar(),
              const SizedBox(height: AppDimension.space32),
              const Text(
                'Deadlines this month',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
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
              const SizedBox(height: AppDimension.space50),
            ],
          ),
        ),
      ),
    );
  }
}
