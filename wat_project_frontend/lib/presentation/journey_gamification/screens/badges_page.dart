import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/presentation/auth_profile/profile/bloc/profile_bloc.dart';
import 'package:wat_project_frontend/presentation/journey_gamification/widgets/badge_grid_tile.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

class BadgesPage extends StatelessWidget {
  const BadgesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (context) => getIt<ProfileBloc>()..add(const GetProfileEvent()),
      child: Scaffold(
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
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state.status is UILoading) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              }

              if (state.status is UILoadFailed) {
                final failure = state.status as UILoadFailed;
                return Center(
                  child: Text(
                    failure.message ?? 'Failed to load badges',
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                );
              }

              final badges = state.badges;
              if (badges.isEmpty) {
                return const Center(
                  child: Text(
                    'No badges found',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                );
              }

              return GridView.builder(
                padding: const EdgeInsets.all(AppDimension.space16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: AppDimension.space16,
                  crossAxisSpacing: AppDimension.space16,
                  childAspectRatio: 1.0,
                ),
                itemCount: badges.length,
                itemBuilder: (context, index) {
                  final badge = badges[index];
                  return BadgeGridTile(
                    title: badge.title,
                    icon: Icons.workspace_premium_outlined,
                    isEarned: true,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

