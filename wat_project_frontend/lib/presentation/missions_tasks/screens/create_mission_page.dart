import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wat_project_frontend/core/widgets/app_popup.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/core/widgets/pixel_border_container.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/mission/create_mission_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/mission/create_task_request.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/domain/usecases/journey/list_journey_phases_usecase.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/bloc/mission_task_bloc.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_input_field.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';
import 'package:wat_project_frontend/core/widgets/app_popup.dart';
import 'package:wat_project_frontend/domain/services/auth_manager.dart';

class CreateMissionPage extends StatelessWidget {
  const CreateMissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MissionTaskBloc>(
      create: (_) => getIt<MissionTaskBloc>(),
      child: const _CreateMissionView(),
    );
  }
}

class _CreateMissionView extends StatefulWidget {
  const _CreateMissionView();

  @override
  State<_CreateMissionView> createState() => _CreateMissionViewState();
}

class _CreateMissionViewState extends State<_CreateMissionView> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _pointsController = TextEditingController();
  final _fixedDueDateController = TextEditingController();
  final _relativeDaysController = TextEditingController();

  String? _titleError;
  String? _pointsError;
  String? _relativeDaysError;
  String? _fixedDueDateError;

  bool _isMandatory = false;
  String _verificationType = 'none';
  String _dueDateType = 'fixed';
  DateTime? _selectedDueDate;

  bool _isAdmin = false;
  String _selectedPhaseId = 'phase-1';
  int _currentStep = 0;

  final List<Map<String, TextEditingController>> _taskControllers = [];

  static const List<String> _verificationTypes = ['none', 'upload', 'admin'];
  static const List<String> _dueDateTypes = ['fixed', 'relative'];

  List<Map<String, String>> _phases = [
    {'id': 'phase-1', 'name': 'Phase 1: Pre-Departure Prep'},
    {'id': 'phase-2', 'name': 'Phase 2: Arrival & Onboarding'},
    {'id': 'phase-3', 'name': 'Phase 3: Work Period'},
    {'id': 'phase-4', 'name': 'Phase 4: Return & Wrap-up'},
  ];

  @override
  void initState() {
    super.initState();
    _isAdmin = getIt<AuthSessionManager>().isAdmin;
    if (!_isAdmin) {
      _pointsController.text = '100';
      _isMandatory = false;
    } else {
      _pointsController.text = '100';
    }
    _loadPhases();
  }

  Future<void> _loadPhases() async {
    try {
      final usecase = getIt<ListJourneyPhasesUseCase>();
      final result = await usecase();
      result.fold((failure) {}, (phases) {
        if (phases.isNotEmpty && mounted) {
          setState(() {
            _phases = phases
                .map((p) => {'id': p.phaseId, 'name': p.title})
                .toList();
            if (!_phases.any((p) => p['id'] == _selectedPhaseId)) {
              _selectedPhaseId = _phases.first['id']!;
            }
          });
        }
      });
    } catch (_) {}
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _pointsController.dispose();
    _fixedDueDateController.dispose();
    _relativeDaysController.dispose();
    for (final task in _taskControllers) {
      task['title']?.dispose();
      task['description']?.dispose();
    }
    super.dispose();
  }

  bool _validateForm() {
    setState(() {
      _titleError = null;
      _pointsError = null;
      _relativeDaysError = null;
      _fixedDueDateError = null;
    });

    bool isValid = true;

    if (_titleController.text.trim().isEmpty) {
      setState(() => _titleError = 'Title is required');
      isValid = false;
    }

    if (_isAdmin) {
      final points = int.tryParse(_pointsController.text.trim());
      if (points == null || points < 0) {
        setState(() => _pointsError = 'Invalid points value');
        isValid = false;
      }
    }

    if (_dueDateType == 'fixed' && _selectedDueDate == null) {
      setState(() => _fixedDueDateError = 'Please select a date');
      isValid = false;
    }

    if (_dueDateType == 'relative') {
      final days = int.tryParse(_relativeDaysController.text.trim());
      if (days == null || days < 0) {
        setState(() => _relativeDaysError = 'Invalid days offset');
        isValid = false;
      }
    }

    return isValid;
  }

  void _onSubmit() {
    if (_taskControllers.isEmpty) {
      AppPopup.show<void>(
        context: context,
        title: 'Error',
        message: 'Please add at least one task to the mission.',
        type: AppPopupType.error,
        buttons: [
          AppPopupButton(
            label: 'Dismiss',
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
      return;
    }

    // Verify all tasks have a title
    for (final task in _taskControllers) {
      if (task['title']!.text.trim().isEmpty) {
        AppPopup.show<void>(
          context: context,
          title: 'Error',
          message: 'All tasks must have a title.',
          type: AppPopupType.error,
          buttons: [
            AppPopupButton(
              label: 'Dismiss',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
        return;
      }
    }

    final taskList = _taskControllers.map((t) {
      return CreateTaskRequest(
        title: t['title']!.text.trim(),
        description: t['description']!.text.trim().isEmpty
            ? null
            : t['description']!.text.trim(),
      );
    }).toList();

    final request = CreateMissionRequest(
      phaseId: _selectedPhaseId,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
      location: _locationController.text.trim().isEmpty
          ? null
          : _locationController.text.trim(),
      basePoints: _isAdmin
          ? (int.tryParse(_pointsController.text.trim()) ?? 100)
          : 100,
      isMandatory: _isMandatory,
      verificationType: _verificationType,
      dueDateType: _dueDateType,
      fixedDueDate: _selectedDueDate?.toIso8601String(),
      relativeDaysOffset: _dueDateType == 'relative'
          ? int.tryParse(_relativeDaysController.text.trim())
          : null,
      taskList: taskList,
    );

    context.read<MissionTaskBloc>().add(
      MissionTaskEvent.createMissionSubmitted(request: request),
    );
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDueDate ?? DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() {
        _selectedDueDate = date;
        _fixedDueDateController.text =
            '${date.day}/${date.month}/${date.year}';
      });
    }
  }

  Widget _buildStepIndicator(int index, String title, bool active) {
    final textColor = AppColors.text(context);
    final subtextColor = AppColors.textSub(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: active ? AppColors.primary : Colors.transparent,
            border: Border.all(
              color: active ? AppColors.primary : subtextColor,
              width: AppDimension.pixelBorderWidth,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            '${index + 1}',
            style: GoogleFonts.notoSansThai(
              fontSize: 7,
              fontWeight: FontWeight.bold,
              color: active ? AppColors.black : subtextColor,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title.toUpperCase(),
          style: GoogleFonts.notoSansThai(
            fontSize: 7,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
            color: active ? textColor : subtextColor,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MissionTaskBloc, MissionTaskState>(
      listener: (context, state) {
        if (state.status is UILoadSuccess &&
            (state.status as UILoadSuccess).message == 'MISSION_CREATED') {
          AppPopup.show<void>(
            context: context,
            title: 'Success',
            message: 'Mission created successfully!',
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
        } else if (state.status is UILoadFailed) {
          final msg = (state.status as UILoadFailed).message;
          AppPopup.show<void>(
            context: context,
            title: 'Error',
            message: msg ?? 'Failed to create mission',
            type: AppPopupType.error,
            buttons: [
              AppPopupButton(
                label: 'Dismiss',
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.bg(context),
        appBar: AppBar(
          leading: IconButton(
            icon: AppAssets.img(AppAssets.iconBack, size: 20, color: textColor),
            onPressed: () => context.pop(),
          ),
          title: const Text('CREATE QUEST'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppDimension.space16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Step Indicator
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: AppDimension.space16,
                    ),
                    child: Row(
                      children: [
                        WatInputField(
                          label: 'Quest Title',
                          hint: 'e.g. Onboarding Tasks',
                          controller: _titleController,
                          errorText: _titleError,
                        ),
                        const SizedBox(height: AppDimension.space16),
                        Text(
                          'DESCRIPTION',
                          style: GoogleFonts.notoSansThai(
                            fontSize: 7,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: AppDimension.space8),
                        PixelBorderContainer(
                          child: TextField(
                            controller: _descriptionController,
                            maxLines: 3,
                            style: GoogleFonts.notoSansThai(
                              fontSize: 7,
                              color: textColor,
                              height: 1.6,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Provide details about this quest...',
                              hintStyle: GoogleFonts.notoSansThai(
                                fontSize: 6,
                                color: subtextColor,
                                height: 1.6,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppDimension.space16),
                        WatInputField(
                          label: 'Location (Optional)',
                          hint: 'e.g. Cedar Point Park',
                          controller: _locationController,
                        ),
                        const SizedBox(height: AppDimension.space16),
                        _buildDropdownField(
                          label: 'Journey Region / Phase',
                          value: _selectedPhaseId,
                          items: _phases.map((p) => p['id']!).toList(),
                          itemLabel: (id) =>
                              _phases.firstWhere((p) => p['id'] == id)['name']!,
                          onChanged: (v) =>
                              setState(() => _selectedPhaseId = v!),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppDimension.space16),
                  PixelDialogBox(
                    title: 'QUEST SETTINGS',
                    child: Column(
                      children: [
                        WatInputField(
                          label: 'Base EXP Points',
                          hint: '100',
                          controller: _pointsController,
                          keyboardType: TextInputType.number,
                          enabled: _isAdmin,
                          errorText: _pointsError,
                        ),
                        const SizedBox(height: AppDimension.space16),
                        _buildDropdownField(
                          label: 'Verification Method',
                          value: _verificationType,
                          items: _verificationTypes,
                          itemLabel: (v) => v[0].toUpperCase() + v.substring(1),
                          onChanged: (v) =>
                              setState(() => _verificationType = v!),
                        ),
                        const SizedBox(height: AppDimension.space16),
                        _MandatoryToggle(
                          value: _isMandatory,
                          onChanged: _isAdmin
                              ? (v) => setState(() => _isMandatory = v)
                              : null,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppDimension.space16),
                  PixelDialogBox(
                    title: 'DUE DATE PARAMETERS',
                    child: Column(
                      children: [
                        _buildDropdownField(
                          label: 'Due Date Category',
                          value: _dueDateType,
                          items: _dueDateTypes,
                          itemLabel: (v) => v[0].toUpperCase() + v.substring(1),
                          onChanged: (v) => setState(() {
                            _dueDateType = v!;
                            _fixedDueDateController.clear();
                            _relativeDaysController.clear();
                            _selectedDueDate = null;
                          }),
                        ),
                        const SizedBox(height: AppDimension.space16),
                        if (_dueDateType == 'fixed') ...[
                          GestureDetector(
                            onTap: _pickDate,
                            child: AbsorbPointer(
                              child: WatInputField(
                                label: 'Fixed Due Date',
                                hint: 'Tap to select calendar...',
                                controller: _fixedDueDateController,
                                errorText: _fixedDueDateError,
                              ),
                            ),
                          ),
                        ] else ...[
                          WatInputField(
                            label: 'Days from trigger',
                            hint: 'e.g. 7',
                            controller: _relativeDaysController,
                            keyboardType: TextInputType.number,
                            errorText: _relativeDaysError,
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: AppDimension.space32),
                  WatButton(
                    label: 'Next: Add Tasks',
                    onPressed: () {
                      if (_validateForm()) {
                        setState(() {
                          _currentStep = 1;
                        });
                      }
                    },
                  ),
                ] else ...[
                  PixelDialogBox(
                    title: 'TASKS CHECKLIST',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_taskControllers.isEmpty) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'NO TASKS ADDED YET. MISSIONS REQUIRE AT LEAST ONE TASK.',
                              style: GoogleFonts.notoSansThai(
                                fontSize: 6,
                                color: subtextColor,
                                height: 1.6,
                              ),
                            ),
                          ),
                        ] else ...[
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _taskControllers.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: AppDimension.space12),
                            itemBuilder: (context, index) {
                              final controllers = _taskControllers[index];
                              return Container(
                                padding: const EdgeInsets.all(AppDimension.space12),
                                decoration: BoxDecoration(
                                  color: isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt,
                                  border: Border.all(
                                    color: borderColor,
                                    width: AppDimension.pixelBorderWidth,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'TASK #${index + 1}',
                                          style: GoogleFonts.notoSansThai(
                                            fontSize: 7,
                                            fontWeight: FontWeight.bold,
                                            color: textColor,
                                          ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.arrow_upward, size: 16),
                                              onPressed: index > 0
                                                  ? () {
                                                      setState(() {
                                                        final temp =
                                                            _taskControllers[index];
                                                        _taskControllers[index] =
                                                            _taskControllers[index -
                                                                1];
                                                        _taskControllers[index -
                                                                1] =
                                                            temp;
                                                      });
                                                    }
                                                  : null,
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.arrow_downward,
                                                size: 20,
                                              ),
                                              onPressed:
                                                  index <
                                                      _taskControllers.length - 1
                                                  ? () {
                                                      setState(() {
                                                        final temp =
                                                            _taskControllers[index];
                                                        _taskControllers[index] = _taskControllers[index +1];
                                                        _taskControllers[index + 1] = temp;
                                                      });
                                                    }
                                                  : null,
                                            ),
                                            IconButton(
                                              icon: AppAssets.img(
                                                AppAssets.iconDelete,
                                                size: 16,
                                                color: AppColors.error,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  final removed =
                                                      _taskControllers.removeAt(index);
                                                  removed['title']?.dispose();
                                                  removed['description']?.dispose();
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    WatInputField(
                                      label: 'Task Title',
                                      hint: 'e.g. Submit visa photo',
                                      controller: controllers['title']!,
                                    ),
                                    const SizedBox(height: AppDimension.space8),
                                    WatInputField(
                                      label: 'Task Description (Optional)',
                                      hint: 'Brief details...',
                                      controller: controllers['description']!,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                        const SizedBox(height: AppDimension.space16),
                        OutlinedButton(
                          onPressed: () {
                            setState(() {
                              _taskControllers.add({
                                'title': TextEditingController(),
                                'description': TextEditingController(),
                              });
                            });
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: AppColors.primary, width: AppDimension.pixelBorderWidth),
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppAssets.img(AppAssets.iconAdd, size: 14, color: AppColors.primary),
                              const SizedBox(width: 8),
                              Text(
                                'ADD TASK',
                                style: GoogleFonts.notoSansThai(
                                  fontSize: 7,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              child: const Text(
                                'Back',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppDimension.space16),
                        Expanded(
                          child:
                              BlocBuilder<
                                MissionTaskBloc,
                                MissionTaskState
                              >(
                                builder: (context, state) {
                                  final isLoading = state.status is UILoading;
                                  return _SubmitButton(
                                    isLoading: isLoading,
                                    onPressed: isLoading ? null : _onSubmit,
                                  );
                                },
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppDimension.space32),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              _currentStep = 0;
                            });
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: textColor, width: AppDimension.pixelBorderWidth),
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: Text(
                            'BACK',
                            style: GoogleFonts.notoSansThai(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppDimension.space16),
                      Expanded(
                        child: BlocBuilder<CreateMissionBloc, CreateMissionState>(
                          builder: (context, state) {
                            final isLoading = state.status is UILoading;
                            return _SubmitButton(
                              isLoading: isLoading,
                              onPressed: isLoading ? null : _onSubmit,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: AppDimension.space50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required String Function(String) itemLabel,
    required ValueChanged<String?> onChanged,
  }) {
    final textColor = AppColors.text(context);
    final borderColor = AppColors.border(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toString().toUpperCase(),
          style: GoogleFonts.notoSansThai(
            fontSize: 7,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: AppDimension.space8),
        Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
            border: Border.all(color: borderColor, width: AppDimension.pixelBorderWidth),
          ),
          padding: const EdgeInsets.symmetric(horizontal: AppDimension.space12),
          child: DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              initialValue: value,
              onChanged: onChanged,
              dropdownColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
              style: GoogleFonts.notoSansThai(
                fontSize: 7,
                color: textColor,
              ),
              items: items
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(itemLabel(item)),
                    ),
                  )
                  .toList(),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MandatoryToggle extends StatelessWidget {
  const _MandatoryToggle({required this.value, this.onChanged});

  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final enabled = onChanged != null;
    final textColor = AppColors.text(context);
    final subtextColor = AppColors.textSub(context);
    final borderColor = AppColors.border(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt,
        border: Border.all(color: borderColor, width: AppDimension.pixelBorderWidth),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimension.space12,
        vertical: AppDimension.space12,
      ),
      child: Opacity(
        opacity: enabled ? 1.0 : 0.5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MANDATORY QUEST',
                    style: GoogleFonts.notoSansThai(
                      fontSize: 7,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Users must complete this mission',
                    style: GoogleFonts.notoSansThai(
                      fontSize: 5,
                      color: subtextColor,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: value,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({required this.isLoading, required this.onPressed});

  final bool isLoading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return WatButton(
      label: 'CREATE QUEST',
      isLoading: isLoading,
      onPressed: onPressed,
    );
  }
}
