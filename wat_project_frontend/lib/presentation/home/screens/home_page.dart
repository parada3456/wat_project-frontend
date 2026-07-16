import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/core/widgets/pixel_border_container.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/domain/models/user_models.dart';
import 'package:wat_project_frontend/domain/models/journey_models.dart';
import 'package:wat_project_frontend/presentation/home/bloc/home_bloc.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/bloc/mission_task_bloc.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/widgets/mission_card_list.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => getIt<HomeBloc>()..add(const HomeFetched()),
        ),
        BlocProvider<MissionTaskBloc>(
          create: (context) => getIt<MissionTaskBloc>(),
        ),
      ],
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final bgColor = AppColors.bg(context);
    final textColor = AppColors.text(context);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('WAT DASHBOARD'),
        actions: [
          IconButton(
            icon: AppAssets.img(
              AppAssets.iconAdmin,
              size: 20,
              color: AppColors.primary,
            ),
            tooltip: 'Debug Dashboard',
            onPressed: () => context.push('/home/debug'),
          ),
          IconButton(
            icon: AppAssets.img(
              AppAssets.iconNotification,
              size: 20,
              color: textColor,
            ),
            onPressed: () => context.push('/notifications'),
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.homeData == null && state.status is UILoading) {
            return const Center(
              child: PixelLoadingDots(color: AppColors.primary),
            );
          }

          if (state.status is UILoadFailed) {
            final message = (state.status as UILoadFailed).message;
            if (state.homeData != null) {
              return _buildDashboard(
                context,
                state.homeData!,
                errorMessage: message,
              );
            }
            return _buildErrorState(
              context,
              message ?? 'Failed to load home data',
            );
          }

          if (state.homeData != null) {
            return _buildDashboard(context, state.homeData!);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildDashboard(
    BuildContext context,
    HomeData data, {
    String? errorMessage,
  }) {
    final currentProgress = data.allPhases.indexOf(data.currentPhase) + 1;
    final totalPhases = data.allPhases.isNotEmpty ? data.allPhases.length : 3;
    final textColor = AppColors.text(context);

    return RefreshIndicator(
      onRefresh: () async {
        context.read<HomeBloc>().add(const HomeFetched());
      },
      color: AppColors.primary,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimension.space16,
          vertical: AppDimension.space20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (data.isMock || errorMessage != null)
              _buildDemoBanner(
                context,
                errorMessage ?? 'Showing cached offline data.',
              ),

            _buildGreeting(context, data.user),
            const SizedBox(height: AppDimension.space24),

            _buildPhaseCard(context, data.currentPhase, currentProgress, totalPhases),
            const SizedBox(height: AppDimension.space24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ACTIVE QUESTS',
                  style: GoogleFonts.notoSansThai(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                GestureDetector(
                  onTap: () => context.push('/missions'),
                  child: Row(
                    children: [
                      Text(
                        'VIEW ALL ',
                        style: GoogleFonts.notoSansThai(
                          fontSize: 11,
                          color: AppColors.primary,
                        ),
                      ),
                      AppAssets.img(
                        AppAssets.iconBack, // flipped arrow helper
                        size: 10,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimension.space12),

            if (data.phaseMissions.isEmpty)
              _buildEmptyMissionsState(context)
            else
              SizedBox(
                height: 420,
                child: MissionCardList(
                  feedType: MissionFeedType.my,
                  pageSize: 3,
                  padding: EdgeInsets.zero,
                  missions: data.phaseMissions,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDemoBanner(BuildContext context, String message) {
    return PixelBorderContainer(
      borderColor: AppColors.primary,
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(AppDimension.space12),
      child: Row(
        children: [
          AppAssets.img(
            AppAssets.iconWarning,
            size: 20,
            color: AppColors.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DEMO MODE ACTIVE',
                  style: GoogleFonts.notoSansThai(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Server offline. Using cached data.',
                  style: GoogleFonts.notoSansThai(
                    color: AppColors.textSub(context),
                    fontSize: 11,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          WatButton(
            label: 'Retry',
            width: 80,
            onPressed: () {
              context.read<HomeBloc>().add(const HomeFetched());
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGreeting(BuildContext context, UserModel user) {
    final name = (user.firstName != null && user.firstName!.trim().isNotEmpty)
        ? user.firstName!.trim()
        : 'Traveler';
    final textColor = AppColors.text(context);
    final subtextColor = AppColors.textSub(context);

    return Row(
      children: [
        // Square pixel avatar frame
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.15),
            border: Border.all(
              color: AppColors.border(context),
              width: AppDimension.pixelBorderWidth,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            name.isNotEmpty ? name[0].toUpperCase() : 'T',
            style: GoogleFonts.notoSansThai(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'HI, ${name.toUpperCase()}!',
                style: GoogleFonts.notoSansThai(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Welcome back to your adventure.',
                style: GoogleFonts.notoSansThai(
                  fontSize: 11,
                  color: subtextColor,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPhaseCard(
    BuildContext context,
    JourneyPhaseModel phase,
    int currentProgress,
    int totalPhases,
  ) {
    final progressFraction = currentProgress / totalPhases;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = AppColors.text(context);
    final subtextColor = AppColors.textSub(context);

    return PixelBorderContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  border: Border.all(
                    color: AppColors.border(context),
                    width: AppDimension.pixelBorderWidth,
                  ),
                ),
                child: Text(
                  'PHASE $currentProgress OF $totalPhases',
                  style: GoogleFonts.notoSansThai(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
              AppAssets.img(
                AppAssets.iconBadge,
                size: 20,
                color: AppColors.primary,
              ),
            ],
          ),
          const SizedBox(height: AppDimension.space16),
          Text(
            phase.title.toUpperCase(),
            style: GoogleFonts.notoSansThai(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: textColor,
              height: 1.5,
            ),
          ),
          if (phase.description != null) ...[
            const SizedBox(height: 8),
            Text(
              phase.description!,
              style: GoogleFonts.notoSansThai(
                fontSize: 11,
                color: subtextColor,
                height: 1.8,
              ),
            ),
          ],
          const SizedBox(height: AppDimension.space20),
          // Flat Pixel Linear Progress Bar
          Container(
            height: 12,
            width: double.infinity,
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt,
              border: Border.all(
                color: AppColors.border(context),
                width: AppDimension.pixelBorderWidth,
              ),
            ),
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: progressFraction,
              child: Container(
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'JOURNEY STATUS',
                style: GoogleFonts.notoSansThai(
                  fontSize: 11,
                  color: subtextColor,
                ),
              ),
              Text(
                '${(progressFraction * 100).toInt()}% COMPLETED',
                style: GoogleFonts.notoSansThai(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyMissionsState(BuildContext context) {
    return PixelBorderContainer(
      child: Column(
        children: [
          const SizedBox(height: AppDimension.space16),
          AppAssets.img(
            AppAssets.iconSuccess,
            size: 40,
            color: AppColors.textSub(context),
          ),
          const SizedBox(height: 12),
          Text(
            'ALL DONE FOR THIS PHASE!',
            style: GoogleFonts.notoSansThai(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.text(context),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'No active quests in this phase. Keep it up!',
            style: GoogleFonts.notoSansThai(
              fontSize: 11,
              color: AppColors.textSub(context),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimension.space16),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimension.space24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppAssets.img(
              AppAssets.iconError,
              size: 48,
              color: AppColors.error,
            ),
            const SizedBox(height: 16),
            Text(
              'UNABLE TO LOAD HOME DASHBOARD',
              style: GoogleFonts.notoSansThai(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.text(context),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message.toUpperCase(),
              style: GoogleFonts.notoSansThai(
                fontSize: 11,
                color: AppColors.textSub(context),
                height: 1.8,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            WatButton(
              label: 'Try Again',
              onPressed: () {
                context.read<HomeBloc>().add(const HomeFetched());
              },
            ),
          ],
        ),
      ),
    );
  }
}
