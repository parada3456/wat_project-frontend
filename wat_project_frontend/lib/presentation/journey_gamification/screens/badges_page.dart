import 'package:flutter/material.dart';
import 'package:wat_project_frontend/presentation/journey_gamification/widgets/badge_grid_tile.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class BadgesPage extends StatelessWidget {
  const BadgesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundAlt,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'My Badges',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: GridView.builder(
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
              'Program Completer'
            ];
            final icons = [
              Icons.wb_sunny_outlined,
              Icons.description_outlined,
              Icons.group_add_outlined,
              Icons.account_balance_wallet_outlined,
              Icons.work_outline,
              Icons.explore_outlined,
              Icons.emoji_events_outlined,
              Icons.workspace_premium_outlined
            ];
            return BadgeGridTile(
              title: titles[index],
              icon: icons[index],
              isEarned: index < 3,
            );
          },
        ),
      ),
    );
  }
}
