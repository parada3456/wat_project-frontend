import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wat_project_frontend/data/mappers/mission_mapper.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';
import 'package:wat_project_frontend/domain/models/paged_model.dart';
import 'package:wat_project_frontend/domain/models/user_models.dart';
import 'package:wat_project_frontend/domain/models/journey_models.dart';
import 'package:wat_project_frontend/domain/repositories/mission_repository.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/presentation/home/bloc/home_bloc.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/bloc/mission_task_bloc.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/widgets/mission_card.dart';
import 'package:wat_project_frontend/presentation/widgets/paginated_list_view.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

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
    return Scaffold(
      backgroundColor: AppColors.backgroundAlt,
      appBar: AppBar(
        title: const Text(
          'WAT Project',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.background,
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.bug_report_outlined,
              color: AppColors.primary,
            ),
            tooltip: 'Debug Dashboard',
            onPressed: () => context.push('/home/debug'),
          ),
          IconButton(
            icon: const Icon(
              Icons.notifications_outlined,
              color: AppColors.textPrimary,
            ),
            onPressed: () => context.push('/notifications'),
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.homeData == null && state.status is UILoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
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

    return RefreshIndicator(
      onRefresh: () async {
        context.read<HomeBloc>().add(const HomeFetched());
      },
      color: AppColors.primary,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (data.isMock || errorMessage != null)
              _buildDemoBanner(
                context,
                errorMessage ?? 'Showing cached demo data.',
              ),

            _buildGreeting(data.user),
            const SizedBox(height: 20),

            _buildPhaseCard(data.currentPhase, currentProgress, totalPhases),
            const SizedBox(height: 28),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Active Missions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                TextButton.icon(
                  onPressed: () => context.push('/missions'),
                  icon: const Icon(Icons.arrow_forward, size: 16),
                  label: const Text('View All'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            if (data.phaseMissions.isEmpty)
              _buildEmptyMissionsState()
            else
              SizedBox(
                height: 420,
                child: PaginatedListView<MissionModel>(
                  // Homepage preview: fetch only page 1 with pageSize=3,
                  // limit=3 stops any further fetch once we have 3 items.
                  fetchPage: (page, pageSize) async {
                    final repo = getIt<MissionRepository>();
                    final response = await repo.listMyMissions(
                      page: page,
                      pageSize: pageSize,
                    );
                    final models =
                        response.data.map((e) => e.toModel()).toList();
                    return PagedModel<MissionModel>.fromResponse(
                      updatedItems: models,
                      serverCurrentPage: page,
                      totalPages: response.pagination?.totalPages ??
                          (models.length == pageSize ? page + 1 : page),
                      pageSize: pageSize,
                    );
                  },
                  initialItems: data.phaseMissions,
                  pageSize: 3,
                  limit: 3,
                  padding: EdgeInsets.zero,
                  emptyMessage: 'No active missions.',
                  itemBuilder: (context, mission) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: InkWell(
                      onTap: () => context.push(
                        '/missions/detail',
                        extra: mission.missionId,
                      ),
                      borderRadius:
                          BorderRadius.circular(AppDimension.radiusMedium),
                      child: MissionCard(mission: mission),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDemoBanner(BuildContext context, String message) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline_rounded, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Demo/Offline Mode Active',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                    fontSize: 13,
                  ),
                ),
                Text(
                  'Unable to reach server. Showing cached demo data.',
                  style: TextStyle(color: Colors.grey[700], fontSize: 11),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              context.read<HomeBloc>().add(const HomeFetched());
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildGreeting(UserModel user) {
    final name = (user.firstName != null && user.firstName!.trim().isNotEmpty)
        ? user.firstName!.trim()
        : 'Traveler';
    return Row(
      children: [
        CircleAvatar(
          radius: 26,
          backgroundColor: AppColors.primary.withOpacity(0.15),
          child: Text(
            name.isNotEmpty ? name[0].toUpperCase() : 'T',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, $name!',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
            const Text(
              'Welcome back to your WAT adventure.',
              style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPhaseCard(
    JourneyPhaseModel phase,
    int currentProgress,
    int totalPhases,
  ) {
    final progressFraction = currentProgress / totalPhases;

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
        side: BorderSide(color: Colors.grey.withOpacity(0.15)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(
                      AppDimension.radiusSmall,
                    ),
                  ),
                  child: Text(
                    'Phase $currentProgress of $totalPhases',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const Icon(
                  Icons.flag_rounded,
                  color: AppColors.primary,
                  size: 20,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              phase.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
            if (phase.description != null) ...[
              const SizedBox(height: 8),
              Text(
                phase.description!,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
            ],
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppDimension.radiusSmall),
              child: LinearProgressIndicator(
                value: progressFraction,
                minHeight: 8,
                backgroundColor: AppColors.surfaceAlt,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Journey Status',
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
                Text(
                  '${(progressFraction * 100).toInt()}% Completed',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyMissionsState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
        border: Border.all(color: Colors.grey.withOpacity(0.15)),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.assignment_turned_in_outlined,
            size: 48,
            color: Colors.grey,
          ),
          SizedBox(height: 12),
          Text(
            'All Done for This Phase!',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'No active missions in this phase. Keep it up!',
            style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cloud_off, size: 64, color: AppColors.error),
            const SizedBox(height: 16),
            const Text(
              'Unable to load your home dashboard',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: const TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                context.read<HomeBloc>().add(const HomeFetched());
              },
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}
