import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/bloc/mission_task_bloc.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/widgets/task_checkbox_tile.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/core/widgets/pixel_border_container.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';
import 'package:wat_project_frontend/core/widgets/app_popup.dart';
import 'package:wat_project_frontend/domain/services/auth_manager.dart';

class MissionDetailPage extends StatelessWidget {
  final String missionId;

  const MissionDetailPage({super.key, required this.missionId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MissionTaskBloc>(
      create: (context) =>
          getIt<MissionTaskBloc>()..add(MissionTaskDetailRequested(missionId)),
      child: MissionDetailView(missionId: missionId),
    );
  }
}

class MissionDetailView extends StatelessWidget {
  final String missionId;
  const MissionDetailView({super.key, required this.missionId});

  @override
  Widget build(BuildContext context) {
    final textColor = AppColors.text(context);
    final subtextColor = AppColors.textSub(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = AppColors.border(context);

    return Scaffold(
      backgroundColor: AppColors.bg(context),
      appBar: AppBar(
        leading: IconButton(
          icon: AppAssets.img(AppAssets.iconBack, size: 20, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: AppAssets.img(AppAssets.iconInfo, size: 20, color: textColor),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocConsumer<MissionTaskBloc, MissionTaskState>(
        listener: (context, state) {
          state.status.whenOrNull(
            loadFailed: (message, _) {
              AppPopup.show<void>(
                context: context,
                title: 'Error',
                message: message ?? 'An error occurred',
                type: AppPopupType.error,
                buttons: [
                  AppPopupButton(
                    label: 'Dismiss',
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              );
            },
            loadSuccess: (message) {
              if (message == 'PROOF_SUBMIT_SUCCESS') {
                AppPopup.show<void>(
                  context: context,
                  title: 'Success',
                  message: 'Proof submitted successfully!',
                  type: AppPopupType.success,
                  buttons: [
                    AppPopupButton(
                      label: 'OK',
                      isPrimary: true,
                      onPressed: () {
                        Navigator.of(context).pop();
                        context.read<MissionTaskBloc>().add(
                          MissionTaskDetailRequested(missionId),
                        );
                      },
                    ),
                  ],
                );
              }
            },
          );
        },
        builder: (context, state) {
          final detail = state.detail;

          if (detail == null && state.status is UILoading) {
            return const Center(
              child: PixelLoadingDots(color: AppColors.primary),
            );
          }

          if (detail == null) {
            return Center(
              child: Text(
                state.status.maybeWhen(
                  loadFailed: (msg, _) => (msg ?? 'Failed to load details').toUpperCase(),
                  orElse: () => 'NO DETAILS AVAILABLE',
                ),
                style: GoogleFonts.pressStart2p(
                  fontSize: 7,
                  color: subtextColor,
                ),
              ),
            );
          }

          final tasks = detail.tasks;
          final completedCount = tasks
              .where((t) => t.isCompleted == true)
              .length;
          final totalCount = tasks.length;
          final progress = totalCount > 0 ? completedCount / totalCount : 0.0;

          final currentUserId = getIt<AuthSessionManager>().userId;
          final isCreator = detail.createdBy == currentUserId;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimension.space24,
              vertical: AppDimension.space16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'QUEST TYPE: PHASE MISSION'.toUpperCase(),
                        style: GoogleFonts.pressStart2p(
                          fontSize: 6,
                          fontWeight: FontWeight.bold,
                          color: subtextColor,
                        ),
                      ),
                    ),
                    if (isCreator) ...[
                      const SizedBox(width: AppDimension.space8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.15),
                          border: Border.all(
                            color: AppColors.primary,
                            width: AppDimension.pixelBorderWidth,
                          ),
                        ),
                        child: Text(
                          'YOUR CREATION',
                          style: GoogleFonts.pressStart2p(
                            color: AppColors.primary,
                            fontSize: 5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: AppDimension.space8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        detail.title.toUpperCase(),
                        style: GoogleFonts.pressStart2p(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '$completedCount/$totalCount',
                      style: GoogleFonts.pressStart2p(
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimension.space16),
                // Retro flat progress bar
                Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt,
                    border: Border.all(
                      color: borderColor,
                      width: AppDimension.pixelBorderWidth,
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: progress,
                    child: Container(
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: AppDimension.space16),
                if (detail.description != null) ...[
                  Text(
                    detail.description!,
                    style: GoogleFonts.pressStart2p(
                      fontSize: 6,
                      color: subtextColor,
                      height: 1.8,
                    ),
                  ),
                  const SizedBox(height: AppDimension.space32),
                ],

                Row(
                  children: [
                    Text(
                      'CHECKLIST',
                      style: GoogleFonts.pressStart2p(
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '$totalCount QUESTS',
                      style: GoogleFonts.pressStart2p(
                        fontSize: 6,
                        color: subtextColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimension.space16),

                PixelBorderContainer(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimension.space12,
                    vertical: AppDimension.space4,
                  ),
                  child: Column(
                    children: tasks.map((task) {
                      final index = tasks.indexOf(task);
                      return Column(
                        children: [
                          TaskCheckboxTile(
                            title: task.title,
                            subtitle: task.description,
                            isChecked: task.isCompleted ?? false,
                            onChanged: (val) {
                              context.read<MissionTaskBloc>().add(
                                MissionTaskEvent.toggleRequested(
                                  userMissionId:
                                      detail.userMission?.userMissionId ?? '',
                                  taskId: task.taskId,
                                  completed: val ?? false,
                                ),
                              );
                            },
                          ),
                          if (index < tasks.length - 1)
                            Divider(height: 1, color: borderColor),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: AppDimension.space50),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<MissionTaskBloc, MissionTaskState>(
        builder: (context, state) {
          final detail = state.detail;
          if (detail == null) return const SizedBox.shrink();

          final completedCount = detail.tasks
              .where((t) => t.isCompleted == true)
              .length;
          final totalCount = detail.tasks.length;
          final allDone = totalCount > 0 && completedCount == totalCount;
          final isCompleted =
              detail.userMission?.status == UserMissionStatus.completed;

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimension.space24,
                vertical: AppDimension.space16,
              ),
              child: WatButton(
                label: isCompleted ? 'COMPLETED' : 'COMPLETE QUEST',
                onPressed: allDone && !isCompleted
                    ? () {
                        context.read<MissionTaskBloc>().add(
                          MissionTaskEvent.proofSubmitted(
                            missionId: detail.missionId,
                          ),
                        );
                      }
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }
}
