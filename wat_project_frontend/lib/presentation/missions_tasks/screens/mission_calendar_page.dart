import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/bloc/mission_task_bloc.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/widgets/mission_calendar.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/widgets/mission_card.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class MissionCalendarPage extends StatelessWidget {
  const MissionCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MissionTaskBloc>(
      create: (context) =>
          getIt<MissionTaskBloc>()..add(const MissionsTasksListRequested()),
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
      backgroundColor: AppColors.bg(context),
      appBar: AppBar(
        leading: IconButton(
          icon: AppAssets.img(AppAssets.iconBack, size: 20, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('QUEST CALENDAR'),
      ),
      body: SafeArea(
        child: BlocBuilder<MissionTaskBloc, MissionTaskState>(
          builder: (context, state) {
            if (state.missions.isEmpty && state.status is UILoading) {
              return const Center(
                child: PixelLoadingDots(color: AppColors.primary),
              );
            }

            if (state.status is UILoadFailed) {
              final message = (state.status as UILoadFailed).message ?? 'Failed to load missions';
              return Center(
                child: Text(
                  message.toUpperCase(),
                  style: GoogleFonts.notoSansThai(fontSize: 7, color: AppColors.error),
                ),
              );
            }

            final deadlinesThisMonth = state.missions
                .where(
                  (m) =>
                      m.userMission?.calculatedDueDate != null &&
                      m.userMission?.calculatedDueDate!.month == 6 &&
                      m.userMission?.calculatedDueDate!.year == 2026,
                )
                .toList();

            return RefreshIndicator(
              onRefresh: () async {
                context.read<MissionTaskBloc>().add(
                  const MissionsTasksListRequested(),
                );
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(AppDimension.space16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MissionCalendar(missions: state.missions),
                    const SizedBox(height: AppDimension.space32),
                    Text(
                      'DEADLINES THIS MONTH',
                      style: GoogleFonts.notoSansThai(
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: AppDimension.space16),
                    if (deadlinesThisMonth.isEmpty)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Text(
                            'NO DEADLINES THIS MONTH.',
                            style: GoogleFonts.notoSansThai(
                              fontSize: 7,
                              color: subtextColor,
                            ),
                          ),
                        ),
                      )
                    else
                      ...deadlinesThisMonth.map((dm) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: InkWell(
                            onTap: () => context.push(
                              '/missions/detail',
                              extra: dm.missionId,
                            ),
                            child: MissionCard(mission: dm),
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
}
