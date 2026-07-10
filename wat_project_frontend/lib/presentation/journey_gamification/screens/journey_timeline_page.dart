import 'package:flutter/material.dart';
import 'package:wat_project_frontend/presentation/journey_gamification/widgets/phase_node_widget.dart';
import 'package:wat_project_frontend/presentation/journey_gamification/widgets/leaderboard_row.dart';
import 'package:wat_project_frontend/presentation/journey_gamification/widgets/badge_grid_tile.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class JourneyTimelinePage extends StatelessWidget {
  const JourneyTimelinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
          bottom: const TabBar(
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            indicatorColor: AppColors.primary,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(text: 'Timeline'),
              Tab(text: 'Leaderboard'),
              Tab(text: 'Badges'),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              _buildTimelineTab(),
              _buildLeaderboardTab(),
              _buildBadgesTab(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimension.space32),
      child: Column(
        children: const [
          PhaseNodeWidget(
            phaseNumber: 1,
            title: 'Application & Documents',
            isCompleted: true,
          ),
          PhaseNodeWidget(
            phaseNumber: 2,
            title: 'Interview & Visa',
            isActive: true,
          ),
          PhaseNodeWidget(phaseNumber: 3, title: 'Pre-Departure'),
          PhaseNodeWidget(
            phaseNumber: 4,
            title: 'On-Site Experience',
          ),
          PhaseNodeWidget(
            phaseNumber: 5,
            title: 'Completion & Evaluation',
            isLast: true,
          ),
          SizedBox(height: AppDimension.space50),
        ],
      ),
    );
  }

  Widget _buildLeaderboardTab() {
    return ListView.separated(
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
    );
  }

  Widget _buildBadgesTab() {
    return GridView.builder(
      padding: const EdgeInsets.all(AppDimension.space16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: AppDimension.space16,
        crossAxisSpacing: AppDimension.space16,
        childAspectRatio: 1.0,
      ),
      itemCount: 8,
      itemBuilder: (context, index) {
        final titles = [
          'Early Bird',
          'Visa Pro',
          'First Friend',
          'Debt Free',
          'Workaholic',
          'Explorer',
          'Top Scorer',
          'Program Completer',
        ];
        final icons = [
          Icons.wb_sunny_outlined,
          Icons.description_outlined,
          Icons.group_add_outlined,
          Icons.account_balance_wallet_outlined,
          Icons.work_outline,
          Icons.explore_outlined,
          Icons.emoji_events_outlined,
          Icons.workspace_premium_outlined,
        ];
        return BadgeGridTile(
          title: titles[index],
          icon: icons[index],
          isEarned: index < 3,
        );
      },
    );
  }
}
