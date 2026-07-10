import 'package:flutter/material.dart';
import 'package:wat_project_frontend/presentation/journey_gamification/widgets/leaderboard_row.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundAlt,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Leaderboard',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(AppDimension.space16),
          itemCount: 10,
          separatorBuilder: (context, index) =>
              const SizedBox(height: AppDimension.space8),
          itemBuilder: (context, index) {
            return LeaderboardRow(
              rank: index + 1,
              name: index == 2 ? 'You (John Doe)' : 'Student ${index + 1}',
              points: 5000 - (index * 200),
              isCurrentUser: index == 2,
            );
          },
        ),
      ),
    );
  }
}
