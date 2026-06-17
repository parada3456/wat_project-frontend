import 'package:flutter/material.dart';
import 'package:wat_project_frontend/presentation/journey_gamification/widgets/phase_node_widget.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class JourneyTimelinePage extends StatelessWidget {
  const JourneyTimelinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Your Journey',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimension.space32),
          child: Column(
            children: [
              const PhaseNodeWidget(
                phaseNumber: 1,
                title: 'Application & Documents',
                isCompleted: true,
              ),
              const PhaseNodeWidget(
                phaseNumber: 2,
                title: 'Interview & Visa',
                isActive: true,
              ),
              const PhaseNodeWidget(
                phaseNumber: 3,
                title: 'Pre-Departure',
              ),
              const PhaseNodeWidget(
                phaseNumber: 4,
                title: 'On-Site Experience',
              ),
              const PhaseNodeWidget(
                phaseNumber: 5,
                title: 'Completion & Evaluation',
                isLast: true,
              ),
              const SizedBox(height: AppDimension.space50),
            ],
          ),
        ),
      ),
    );
  }
}
