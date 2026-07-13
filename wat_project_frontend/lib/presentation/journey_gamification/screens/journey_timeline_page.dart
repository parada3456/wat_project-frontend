import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/domain/repositories/user_repository.dart';
import 'package:wat_project_frontend/domain/models/journey_models.dart';
import 'package:wat_project_frontend/presentation/journey_gamification/bloc/journey_gamification_bloc.dart';
import 'package:wat_project_frontend/presentation/journey_gamification/bloc/journey_gamification_event.dart';
import 'package:wat_project_frontend/presentation/journey_gamification/bloc/journey_gamification_state.dart';
import 'package:wat_project_frontend/presentation/journey_gamification/widgets/phase_node_widget.dart';
import 'package:wat_project_frontend/presentation/journey_gamification/widgets/leaderboard_row.dart';
import 'package:wat_project_frontend/presentation/journey_gamification/widgets/badge_grid_tile.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class JourneyTimelinePage extends StatefulWidget {
  const JourneyTimelinePage({super.key});

  @override
  State<JourneyTimelinePage> createState() => _JourneyTimelinePageState();
}

class _JourneyTimelinePageState extends State<JourneyTimelinePage> {
  String? _currentPhaseId;
  bool _isLoadingProfile = true;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      final profile = await getIt<UserRepository>().getMe();
      if (mounted) {
        setState(() {
          _currentPhaseId = profile.userAccount.currentPhaseId;
          _isLoadingProfile = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _isLoadingProfile = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<JourneyGamificationBloc>(
      create: (context) => getIt<JourneyGamificationBloc>()
        ..add(const JourneyPhasesRequested()),
      child: DefaultTabController(
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
      ),
    );
  }

  Widget _buildTimelineTab() {
    if (_isLoadingProfile) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }

    return BlocBuilder<JourneyGamificationBloc, JourneyGamificationState>(
      buildWhen: (previous, current) =>
          current is JourneyPhasesRequested ||
          current is JourneyPhasesLoadSuccess ||
          current is JourneyGamificationFailure ||
          current is JourneyGamificationLoading,
      builder: (context, state) {
        if (state is JourneyGamificationLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        List<JourneyPhaseModel> phases = [];
        if (state is JourneyPhasesLoadSuccess) {
          phases = state.phases;
        }

        if (phases.isEmpty) {
          if (state is JourneyGamificationFailure) {
            return Center(
              child: Text(
                'Failed to load journey: ${state.message}',
                style: const TextStyle(color: AppColors.textSecondary),
              ),
            );
          }
          return const Center(
            child: Text(
              'No journey phases available',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          );
        }

        // Determine which phase is active / completed
        int activePhaseNumber = 1;
        final activePhase = phases.firstWhere(
          (p) => p.phaseId == _currentPhaseId,
          orElse: () => phases.first,
        );
        activePhaseNumber = activePhase.phaseNumber;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimension.space32),
          child: Column(
            children: [
              ...phases.asMap().entries.map((entry) {
                final index = entry.key;
                final phase = entry.value;
                final isCompleted = phase.phaseNumber < activePhaseNumber;
                final isActive = phase.phaseNumber == activePhaseNumber;
                final isLast = index == phases.length - 1;

                return PhaseNodeWidget(
                  phaseNumber: phase.phaseNumber,
                  title: phase.title,
                  isCompleted: isCompleted,
                  isActive: isActive,
                  isLast: isLast,
                );
              }),
              const SizedBox(height: AppDimension.space50),
            ],
          ),
        );
      },
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
