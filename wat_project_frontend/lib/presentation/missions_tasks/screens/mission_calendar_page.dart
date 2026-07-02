import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/bloc/mission_task_bloc.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/widgets/mission_calendar.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/widgets/mission_card.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class MissionCalendarPage extends StatelessWidget {
  const MissionCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MissionTaskBloc>(
      create: (context) => getIt<MissionTaskBloc>()..add(const MissionsTasksListRequested()),
      child: const MissionCalendarView(),
    );
  }
}

class MissionCalendarView extends StatelessWidget {
  const MissionCalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundAlt,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Mission Calendar',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
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

            // Filter missions with deadlines in June 2026
            final deadlinesThisMonth = state.missions.where((m) =>
                m.userMission.calculatedDueDate != null &&
                m.userMission.calculatedDueDate!.month == 6 &&
                m.userMission.calculatedDueDate!.year == 2026).toList();

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
                    MissionCalendar(missions: state.missions),
                    const SizedBox(height: AppDimension.space32),
                    const Text(
                      'Deadlines this month',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppDimension.space16),
                    if (deadlinesThisMonth.isEmpty)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 24.0),
                          child: Text('No deadlines this month.'),
                        ),
                      )
                    else
                      ...deadlinesThisMonth.map((dm) {
                        final totalTasks = dm.tasks.length;
                        final completedTasks = dm.userTasks.where((t) => t.isCompleted).length;
                        final progress = totalTasks > 0 ? completedTasks / totalTasks : 0.0;
                        
                        final deadlineString = '${dm.userMission.calculatedDueDate!.day} ${_getMonthName(dm.userMission.calculatedDueDate!.month)}';

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
                      }),
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

  String _getMonthName(int month) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }
}
