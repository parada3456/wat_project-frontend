import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/domain/repositories/user_repository.dart';
import 'package:wat_project_frontend/domain/models/journey_models.dart';
import 'package:wat_project_frontend/presentation/journey_gamification/bloc/journey_gamification_bloc.dart';
import 'package:wat_project_frontend/presentation/journey_gamification/bloc/journey_gamification_event.dart';
import 'package:wat_project_frontend/presentation/journey_gamification/bloc/journey_gamification_state.dart';
import 'package:wat_project_frontend/presentation/journey_gamification/widgets/phase_node_widget.dart';
import 'package:wat_project_frontend/presentation/journey_gamification/widgets/leaderboard_row.dart';
import 'package:wat_project_frontend/presentation/journey_gamification/widgets/badge_grid_tile.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
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
          backgroundColor: AppColors.bg(context),
          appBar: AppBar(
            title: const Text('YOUR JOURNEY'),
            bottom: TabBar(
              labelStyle: GoogleFonts.pressStart2p(fontSize: 6, fontWeight: FontWeight.bold),
              unselectedLabelStyle: GoogleFonts.pressStart2p(fontSize: 6),
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textSub(context),
              indicatorColor: AppColors.primary,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: const [
                Tab(text: 'TIMELINE'),
                Tab(text: 'RANKINGS'),
                Tab(text: 'BADGES'),
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
      return Center(
        child: PixelLoadingDots(color: AppColors.primary),
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
          return Center(
            child: PixelLoadingDots(color: AppColors.primary),
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
                'FAILED TO LOAD REGIONS: ${state.message.toUpperCase()}',
                style: GoogleFonts.pressStart2p(
                  fontSize: 7,
                  color: AppColors.textSub(context),
                ),
              ),
            );
          }
          return Center(
            child: Text(
              'NO REGIONS UNLOCKED YET.',
              style: GoogleFonts.pressStart2p(
                fontSize: 7,
                color: AppColors.textSub(context),
              ),
            ),
          );
        }

        int activePhaseNumber = 1;
        final activePhase = phases.firstWhere(
          (p) => p.phaseId == _currentPhaseId,
          orElse: () => phases.first,
        );
        activePhaseNumber = activePhase.phaseNumber;

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimension.space24,
            vertical: AppDimension.space32,
          ),
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
              const SizedBox(height: AppDimension.space48),
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
    );
  }
}
