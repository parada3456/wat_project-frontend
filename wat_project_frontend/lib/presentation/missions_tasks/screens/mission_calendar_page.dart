import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/bloc/calendar_bloc/calendar_bloc.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/bloc/mission_task_bloc.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/widgets/mission_calendar.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/widgets/mission_card.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

class MissionCalendarPage extends StatelessWidget {
  const MissionCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MissionTaskBloc>(
          create: (context) =>
              getIt<MissionTaskBloc>()..add(const MissionsTasksListRequested()),
        ),
        BlocProvider<CalendarBloc>(
          create: (context) => CalendarBloc(initialMonth: DateTime.now()),
        ),
      ],
      child: const MissionCalendarView(),
    );
  }
}

class MissionCalendarView extends StatelessWidget {
  const MissionCalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    final textColor = AppColors.text(context);
    final subtextColor = AppColors.textSub(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundAlt,
      body: SafeArea(
        child: BlocBuilder<MissionTaskBloc, MissionTaskState>(
          builder: (context, taskState) {
            return BlocBuilder<CalendarBloc, CalendarState>(
              builder: (context, calendarState) {
                final bool isSelected = calendarState.selectedDate != null;
                final filteredMissions = taskState.missions.where((m) {
                  final dueDate = m.userMission?.calculatedDueDate;
                  if (dueDate == null) return false;
                  if (isSelected) {
                    return dueDate.day == calendarState.selectedDate!.day &&
                        dueDate.month == calendarState.selectedDate!.month &&
                        dueDate.year == calendarState.selectedDate!.year;
                  } else {
                    return dueDate.month == calendarState.focusedMonth.month &&
                        dueDate.year == calendarState.focusedMonth.year;
                  }
                }).toList();

                final listTitle = isSelected
                    ? 'Deadlines on ${DateFormat('d MMMM yyyy').format(calendarState.selectedDate!)}'
                    : 'Deadlines this month';

                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<MissionTaskBloc>().add(
                      const MissionsTasksListRequested(),
                    );
                  },
                  child: CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [
                      SliverAppBar(
                        pinned: true,
                        expandedHeight: 390.0,
                        backgroundColor: AppColors.backgroundAlt,
                        elevation: 0,
                        leading: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: AppColors.textPrimary,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        title: const Text(
                          'Mission Calendar',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        flexibleSpace: FlexibleSpaceBar(
                          background: ClipRect(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 56.0),
                              child: SingleChildScrollView(
                                physics: const NeverScrollableScrollPhysics(),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 8.0,
                                  ),
                                  child: MissionCalendar(
                                    missions: taskState.missions,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.only(
                          left: AppDimension.space16,
                          right: AppDimension.space16,
                          top: AppDimension.space16,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: Text(
                            listTitle,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ),
                      _buildDeadlineContent(
                        context,
                        taskState,
                        filteredMissions,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildDeadlineContent(
    BuildContext context,
    MissionTaskState taskState,
    List<MissionModel> filteredMissions,
  ) {
    if (taskState.missions.isEmpty && taskState.status is UILoading) {
      return const SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      );
    }

    if (taskState.status is UILoadFailed) {
      final message = (taskState.status as UILoadFailed).message;
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(child: Text(message ?? 'Failed to load missions')),
      );
    }

    if (filteredMissions.isEmpty) {
      return const SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            child: Text(
              'No deadlines found.',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.all(AppDimension.space16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final dm = filteredMissions[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: InkWell(
              onTap: () =>
                  context.push('/missions/detail', extra: dm.missionId),
              borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
              child: MissionCard(mission: dm),
            ),
          );
        }, childCount: filteredMissions.length),
      ),
    );
  }
}
