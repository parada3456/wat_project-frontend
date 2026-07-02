import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/domain/models/mission_detail_model.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/bloc/mission_task_bloc.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/widgets/mission_card.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class MissionsDashboardPage extends StatelessWidget {
  const MissionsDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MissionTaskBloc>(
      create: (context) => getIt<MissionTaskBloc>()..add(const MissionsTasksListRequested()),
      child: const MissionsDashboardView(),
    );
  }
}

class MissionsDashboardView extends StatelessWidget {
  const MissionsDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundAlt,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Missions',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today_outlined, color: AppColors.textPrimary),
            onPressed: () => context.push('/missions/calendar'),
          ),
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.textPrimary),
            onPressed: () => context.push('/missions/search'),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<MissionTaskBloc, MissionTaskState>(
          builder: (context, state) {
            if (state.missions.isEmpty && state.status is UILoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }

            if (state.status is UILoadFailed) {
              final message = (state.status as UILoadFailed).message;
              return Center(
                child: Text(message ?? 'Failed to load missions'),
              );
            }

            if (state.missions.isEmpty) {
              return const Center(
                child: Text('No missions available.'),
              );
            }

            // Split into active/mandatory and exploratory/optional missions
            final mandatoryMissions = state.missions.where((dm) => dm.mission.isMandatory).toList();
            final optionalMissions = state.missions.where((dm) => !dm.mission.isMandatory).toList();

            return RefreshIndicator(
              onRefresh: () async {
                context.read<MissionTaskBloc>().add(const MissionsTasksListRequested());
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(AppDimension.space16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (mandatoryMissions.isNotEmpty) ...[
                      const Text(
                        'Mandatory Missions',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: AppDimension.space16),
                      ...mandatoryMissions.map((dm) => _buildMissionCard(context, dm)),
                      const SizedBox(height: AppDimension.space32),
                    ],

                    if (optionalMissions.isNotEmpty) ...[
                      const Text(
                        'Explore Missions',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: AppDimension.space16),
                      ...optionalMissions.map((dm) => _buildMissionCard(context, dm)),
                    ],
                    const SizedBox(height: AppDimension.space50),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMissionCard(BuildContext context, MissionDetailModel dm) {
    final totalTasks = dm.tasks.length;
    final completedTasks = dm.userTasks.where((t) => t.isCompleted).length;
    final progress = totalTasks > 0 ? completedTasks / totalTasks : 0.0;
    
    final deadlineString = dm.userMission.calculatedDueDate != null
        ? '${dm.userMission.calculatedDueDate!.day} ${_getMonthName(dm.userMission.calculatedDueDate!.month)}'
        : 'Soon';

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: () => context.push('/missions/detail', extra: dm.userMission.userMissionId),
        borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
        child: MissionCard(
          title: dm.mission.title,
          deadline: deadlineString,
          bonusPoints: dm.mission.basePoints,
          isMandatory: dm.mission.isMandatory,
          progress: progress,
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }
}
