import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/presentation/journey_gamification/bloc/journey_gamification_bloc.dart';
import 'package:wat_project_frontend/presentation/journey_gamification/widgets/leaderboard_row.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<JourneyGamificationBloc>(
      create: (context) => getIt<JourneyGamificationBloc>()
        ..add(const LeaderboardRequested()),
      child: Scaffold(
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
          child: BlocBuilder<JourneyGamificationBloc, JourneyGamificationState>(
            builder: (context, state) {
              if (state is JourneyGamificationLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              }

              if (state is JourneyGamificationFailure) {
                return Center(
                  child: Text(
                    'Failed to load leaderboard: ${state.message}',
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                );
              }

              if (state is LeaderboardLoadSuccess) {
                final leaderboard = state.leaderboard;
                if (leaderboard.isEmpty) {
                  return const Center(
                    child: Text(
                      'No leaderboard data available',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(AppDimension.space16),
                  itemCount: leaderboard.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: AppDimension.space8),
                  itemBuilder: (context, index) {
                    final entry = leaderboard[index];
                    final name = entry.user.name.isNotEmpty
                        ? entry.user.name
                        : 'User ${entry.user.userId}';

                    return LeaderboardRow(
                      rank: entry.rank > 0 ? entry.rank : index + 1,
                      name: name,
                      points: entry.points,
                      isCurrentUser: false,
                    );
                  },
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

