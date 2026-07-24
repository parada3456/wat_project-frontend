import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/domain/repositories/user_repository.dart';
import 'package:wat_project_frontend/domain/models/journey_models.dart';
import 'package:wat_project_frontend/presentation/journey_gamification/bloc/journey_gamification_bloc.dart';
import 'package:wat_project_frontend/presentation/journey_gamification/widgets/phase_node_widget.dart';
import 'package:wat_project_frontend/presentation/journey_gamification/screens/badges_page.dart';
import 'package:wat_project_frontend/presentation/journey_gamification/screens/leaderboard_page.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

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
                const LeaderboardPage(),
                const BadgesPage(),
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
}
