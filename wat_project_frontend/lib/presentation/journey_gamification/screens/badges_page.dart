import 'package:flutter/material.dart';
import 'package:wat_project_frontend/presentation/journey_gamification/widgets/badge_grid_tile.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class BadgesPage extends StatelessWidget {
  const BadgesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textColor = AppColors.text(context);

    return Scaffold(
      backgroundColor: AppColors.bg(context),
      appBar: AppBar(
        leading: IconButton(
          icon: AppAssets.img(AppAssets.iconBack, size: 20, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('MY BADGES'),
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
              'Program Completer',
            ];
            final icons = [
              AppAssets.iconCalendar,
              AppAssets.iconSponsor,
              AppAssets.iconFriend,
              AppAssets.iconSalary,
              AppAssets.iconJobs,
              AppAssets.iconLocation,
              AppAssets.iconBadge,
              AppAssets.iconBadge,
            ];
            return BadgeGridTile(
              title: titles[index],
              iconAsset: icons[index],
              isEarned: index < 3,
            );
          },
        ),
      ),
    );
  }
}
