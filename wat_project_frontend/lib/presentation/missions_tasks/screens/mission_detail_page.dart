import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/bloc/mission_task_bloc.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/widgets/task_checkbox_tile.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class MissionDetailPage extends StatelessWidget {
  final String missionId;

  const MissionDetailPage({
    super.key,
    required this.missionId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MissionTaskBloc>(
      create: (context) => getIt<MissionTaskBloc>()..add(MissionTaskDetailRequested(missionId)),
      child: const MissionDetailView(),
    );
  }
}

class MissionDetailView extends StatelessWidget {
  const MissionDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocConsumer<MissionTaskBloc, MissionTaskState>(
        listener: (context, state) {
          state.status.whenOrNull(
            loadFailed: (message, _) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message ?? 'An error occurred'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            loadSuccess: (message) {
              if (message == 'PROOF_SUBMIT_SUCCESS') {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Proof submitted successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
          );
        },
        builder: (context, state) {
          final detail = state.detail;
          
          if (detail == null && state.status is UILoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (detail == null) {
            return Center(
              child: Text(
                state.status.maybeWhen(
                  loadFailed: (msg, _) => msg ?? 'Failed to load details',
                  orElse: () => 'No details available',
                ),
              ),
            );
          }

          final tasks = detail.tasks;
          final userTasks = detail.userTasks;
          final completedCount = userTasks.where((ut) => ut.isCompleted).length;
          final totalCount = tasks.length;
          final progress = totalCount > 0 ? completedCount / totalCount : 0.0;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: AppDimension.space32, vertical: AppDimension.space16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Phase Mission: ${detail.mission.title}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppDimension.space8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        detail.mission.title,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '$completedCount/$totalCount',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimension.space16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppDimension.radiusSmall),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: AppColors.surfaceAlt,
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                    minHeight: 8,
                  ),
                ),
                const SizedBox(height: AppDimension.space16),
                if (detail.mission.description != null) ...[
                  Text(
                    detail.mission.description!,
                    style: const TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.4),
                  ),
                  const SizedBox(height: AppDimension.space32),
                ],
                
                Row(
                  children: [
                    const Text(
                      'Tasks Checklist',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '$totalCount items',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimension.space16),
                
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
                    border: Border.all(color: AppColors.surfaceAlt),
                  ),
                  child: Column(
                    children: tasks.map((task) {
                      final index = tasks.indexOf(task);
                      final userTask = userTasks.firstWhere(
                        (ut) => ut.taskId == task.taskId,
                        orElse: () => UserTaskModel(
                          userTaskId: '',
                          userId: '',
                          taskId: task.taskId,
                          userMissionId: detail.userMission.userMissionId,
                          isCompleted: false,
                          updatedAt: DateTime.now(),
                        ),
                      );

                      return Column(
                        children: [
                          TaskCheckboxTile(
                            title: task.title,
                            subtitle: task.description,
                            isChecked: userTask.isCompleted,
                            onChanged: (val) {
                              context.read<MissionTaskBloc>().add(
                                MissionTaskEvent.toggleRequested(
                                  userMissionId: detail.userMission.userMissionId,
                                  taskId: task.taskId,
                                  completed: val ?? false,
                                ),
                              );
                            },
                          ),
                          if (index < tasks.length - 1)
                            const Divider(height: 1, indent: 56),
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

          final completedCount = detail.userTasks.where((ut) => ut.isCompleted).length;
          final totalCount = detail.tasks.length;
          final allDone = totalCount > 0 && completedCount == totalCount;

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppDimension.space32),
              child: WatButton(
                label: detail.userMission.status == UserMissionStatus.completed 
                    ? 'Completed' 
                    : 'Mark Mission as Done',
                onPressed: allDone && detail.userMission.status != UserMissionStatus.completed
                    ? () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Mission completed successfully!'),
                            backgroundColor: Colors.green,
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
