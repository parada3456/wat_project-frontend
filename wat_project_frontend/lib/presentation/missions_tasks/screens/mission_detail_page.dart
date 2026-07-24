import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/bloc/mission_task_bloc.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/widgets/task_checkbox_tile.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';
import 'package:wat_project_frontend/core/widgets/pixel_border_container.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';
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

class MissionDetailView extends StatefulWidget {
  final String missionId;
  const MissionDetailView({super.key, required this.missionId});

  @override
  State<MissionDetailView> createState() => _MissionDetailViewState();
}

class _MissionDetailViewState extends State<MissionDetailView> {
  File? _pickedFile;

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(source: source);
      if (picked != null) {
        setState(() {
          _pickedFile = File(picked.path);
        });
      }
    } catch (_) {}
  }

  void _showImagePickerModal() {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: AppColors.primary),
              title: const Text('Camera'),
              onTap: () {
                Navigator.of(ctx).pop();
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: AppColors.primary),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.of(ctx).pop();
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

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
                        context.pop(true);
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
                style: GoogleFonts.notoSansThai(
                  fontSize: 11,
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
          final isUploadRequired = detail.verificationType == VerificationType.upload;

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
                        style: GoogleFonts.notoSansThai(
                          fontSize: 11,
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
                          style: GoogleFonts.notoSansThai(
                            color: AppColors.primary,
                            fontSize: 11,
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
                        style: GoogleFonts.notoSansThai(
                          fontSize: 14,
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
                      style: GoogleFonts.notoSansThai(
                        fontSize: 12,
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
                _MissionMetadataCard(mission: detail, userMission: detail.userMission),
                const SizedBox(height: AppDimension.space16),
                if (detail.description != null) ...[
                  Text(
                    detail.description!,
                    style: GoogleFonts.notoSansThai(
                      fontSize: 11,
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
                      style: GoogleFonts.notoSansThai(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '$totalCount QUESTS',
                      style: GoogleFonts.notoSansThai(
                        fontSize: 11,
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

                if (isUploadRequired &&
                    detail.userMission?.status != UserMissionStatus.completed &&
                    detail.userMission?.status != UserMissionStatus.pendingVerification) ...[
                  const SizedBox(height: AppDimension.space16),
                  const Text(
                    'Upload Proof',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppDimension.space12),
                  GestureDetector(
                    onTap: _showImagePickerModal,
                    child: Container(
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.backgroundAlt,
                        borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
                        border: Border.all(
                          color: AppColors.primary.withOpacity(0.5),
                          style: BorderStyle.solid,
                          width: 1.5,
                        ),
                      ),
                      child: _pickedFile != null
                          ? Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(AppDimension.radiusMedium - 1),
                                  child: Image.file(
                                    _pickedFile!,
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: InkWell(
                                    onTap: () => setState(() => _pickedFile = null),
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: const BoxDecoration(
                                        color: Colors.black54,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(Icons.close, color: Colors.white, size: 18),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.cloud_upload_outlined, size: 36, color: AppColors.primary),
                                SizedBox(height: 8),
                                Text(
                                  'Tap to select image proof',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.textSecondary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ],

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
          final isPending =
              detail.userMission?.status == UserMissionStatus.pendingVerification;
          final isUploadRequired =
              detail.verificationType == VerificationType.upload;

          final canSubmit = allDone &&
              !isCompleted &&
              !isPending &&
              (!isUploadRequired || _pickedFile != null);

          String buttonLabel = 'Mark Mission as Done';
          if (isCompleted) {
            buttonLabel = 'Completed';
          } else if (isPending) {
            buttonLabel = 'Pending Verification';
          }

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimension.space24,
                vertical: AppDimension.space16,
              ),
              child: WatButton(
                label: buttonLabel,
                onPressed: canSubmit
                    ? () {
                        context.read<MissionTaskBloc>().add(
                          MissionTaskEvent.proofSubmitted(
                            missionId: detail.missionId,
                            file: _pickedFile,
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

class _MissionMetadataCard extends StatelessWidget {
  final MissionModel mission;
  final UserMissionModel? userMission;

  const _MissionMetadataCard({
    required this.mission,
    this.userMission,
  });

  @override
  Widget build(BuildContext context) {
    final dueDate = userMission?.calculatedDueDate;
    final formattedDueDate = dueDate != null
        ? DateFormat('d MMM yyyy').format(dueDate)
        : 'No deadline';

    final vTypeStr = mission.verificationType.name;
    final formattedVType = vTypeStr[0].toUpperCase() + vTypeStr.substring(1);

    final userStatusStr = userMission?.status.name;

    return Container(
      padding: const EdgeInsets.all(AppDimension.space16),
      decoration: BoxDecoration(
        color: AppColors.backgroundAlt,
        borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
        border: Border.all(color: AppColors.surfaceAlt),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMetaItem(
                icon: Icons.calendar_today_outlined,
                label: 'Due Date',
                value: formattedDueDate,
              ),
              _buildMetaItem(
                icon: Icons.star_outline,
                label: 'Base Points',
                value: '${mission.basePoints} ✦',
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMetaItem(
                icon: Icons.verified_outlined,
                label: 'Verification',
                value: formattedVType,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Type',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: mission.isMandatory
                          ? AppColors.error.withOpacity(0.1)
                          : AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      mission.isMandatory ? 'Mandatory' : 'Optional',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: mission.isMandatory ? AppColors.error : AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (mission.location != null && mission.location!.isNotEmpty) ...[
            const SizedBox(height: 12),
            _buildMetaItem(
              icon: Icons.location_on_outlined,
              label: 'Location',
              value: mission.location!,
            ),
          ],
          if (userStatusStr != null) ...[
            const SizedBox(height: 12),
            _buildMetaItem(
              icon: Icons.info_outline,
              label: 'Status',
              value: userStatusStr.replaceAll('_', ' ').toUpperCase(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMetaItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
