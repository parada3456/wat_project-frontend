import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/mission/create_mission_request.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/mission/create_task_request.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/bloc/create_mission_bloc.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class CreateMissionPage extends StatelessWidget {
  const CreateMissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateMissionBloc>(
      create: (_) => getIt<CreateMissionBloc>(),
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
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _pointsController = TextEditingController();
  final _phaseIdController = TextEditingController();
  final _fixedDueDateController = TextEditingController();
  final _relativeDaysController = TextEditingController();

  bool _isMandatory = false;
  String _verificationType = 'none';
  String _dueDateType = 'fixed';
  DateTime? _selectedDueDate;

  final List<Map<String, TextEditingController>> _taskControllers = [];

  static const List<String> _verificationTypes = ['none', 'upload', 'admin'];
  static const List<String> _dueDateTypes = ['fixed', 'relative'];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _pointsController.dispose();
    _phaseIdController.dispose();
    _fixedDueDateController.dispose();
    _relativeDaysController.dispose();
    for (final task in _taskControllers) {
      task['title']?.dispose();
      task['description']?.dispose();
    }
    super.dispose();
  }

  void _onSubmit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    if (_taskControllers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add at least one task to the mission.'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
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
      phaseId: _phaseIdController.text.trim(),
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
      location: _locationController.text.trim().isEmpty
          ? null
          : _locationController.text.trim(),
      basePoints: int.tryParse(_pointsController.text.trim()) ?? 0,
      isMandatory: _isMandatory,
      verificationType: _verificationType,
      dueDateType: _dueDateType,
      fixedDueDate: _dueDateType == 'fixed' && _selectedDueDate != null
          ? _selectedDueDate!.toIso8601String()
          : null,
      relativeDaysOffset: _dueDateType == 'relative'
          ? int.tryParse(_relativeDaysController.text.trim())
          : null,
      taskList: taskList,
    );

    context.read<CreateMissionBloc>().add(CreateMissionEvent.submitted(request: request));
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDueDate ?? now.add(const Duration(days: 7)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 365 * 3)),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppColors.primary,
            onPrimary: AppColors.white,
            onSurface: AppColors.textPrimary,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        _selectedDueDate = picked;
        _fixedDueDateController.text =
            '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateMissionBloc, CreateMissionState>(
      listener: (context, state) {
        if (state.status is UILoadSuccess &&
            (state.status as UILoadSuccess).message == 'MISSION_CREATED') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Mission created successfully!'),
              backgroundColor: AppColors.primary,
            ),
          );
          context.pop();
        } else if (state.status is UILoadFailed) {
          final msg = (state.status as UILoadFailed).message;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(msg ?? 'Failed to create mission'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundAlt,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
            onPressed: () => context.pop(),
          ),
          title: const Text(
            'Create Mission',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppDimension.space16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionCard(
                    title: 'Basic Information',
                    icon: Icons.info_outline,
                    children: [
                      _buildTextField(
                        controller: _titleController,
                        label: 'Mission Title',
                        hint: 'e.g. Complete onboarding tasks',
                        validator: (v) =>
                            (v == null || v.trim().isEmpty) ? 'Title is required' : null,
                      ),
                      const SizedBox(height: AppDimension.space16),
                      _buildTextField(
                        controller: _descriptionController,
                        label: 'Description (optional)',
                        hint: 'Brief description of this mission',
                        maxLines: 3,
                      ),
                      const SizedBox(height: AppDimension.space16),
                      _buildTextField(
                        controller: _locationController,
                        label: 'Location (optional)',
                        hint: 'e.g. Bangkok Office',
                        prefixIcon: Icons.location_on_outlined,
                      ),
                      const SizedBox(height: AppDimension.space16),
                      _buildTextField(
                        controller: _phaseIdController,
                        label: 'Phase ID',
                        hint: 'e.g. phase-uuid-here',
                        validator: (v) =>
                            (v == null || v.trim().isEmpty) ? 'Phase ID is required' : null,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimension.space16),
                  _SectionCard(
                    title: 'Settings',
                    icon: Icons.tune_outlined,
                    children: [
                      _buildTextField(
                        controller: _pointsController,
                        label: 'Base Points',
                        hint: '100',
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        prefixIcon: Icons.star_outline,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return 'Points are required';
                          if ((int.tryParse(v.trim()) ?? -1) < 0) return 'Enter a valid number';
                          return null;
                        },
                      ),
                      const SizedBox(height: AppDimension.space16),
                      _buildDropdownField<String>(
                        label: 'Verification Type',
                        value: _verificationType,
                        items: _verificationTypes,
                        itemLabel: (v) => v[0].toUpperCase() + v.substring(1),
                        onChanged: (v) => setState(() => _verificationType = v!),
                      ),
                      const SizedBox(height: AppDimension.space16),
                      _MandatoryToggle(
                        value: _isMandatory,
                        onChanged: (v) => setState(() => _isMandatory = v),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimension.space16),
                  _SectionCard(
                    title: 'Due Date',
                    icon: Icons.calendar_today_outlined,
                    children: [
                      _buildDropdownField<String>(
                        label: 'Due Date Type',
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
                            child: _buildTextField(
                              controller: _fixedDueDateController,
                              label: 'Fixed Due Date',
                              hint: 'Tap to select date',
                              prefixIcon: Icons.event_outlined,
                            ),
                          ),
                        ),
                      ] else ...[
                        _buildTextField(
                          controller: _relativeDaysController,
                          label: 'Days from trigger',
                          hint: 'e.g. 7',
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          prefixIcon: Icons.access_time_outlined,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: AppDimension.space16),
                  _SectionCard(
                    title: 'Tasks',
                    icon: Icons.checklist_outlined,
                    children: [
                      if (_taskControllers.isEmpty) ...[
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'No tasks added yet. Missions must have at least one task.',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ] else ...[
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _taskControllers.length,
                          separatorBuilder: (context, index) => const SizedBox(height: AppDimension.space12),
                          itemBuilder: (context, index) {
                            final controllers = _taskControllers[index];
                            return Container(
                              padding: const EdgeInsets.all(AppDimension.space12),
                              decoration: BoxDecoration(
                                color: AppColors.backgroundAlt,
                                borderRadius: BorderRadius.circular(AppDimension.radiusSmall),
                                border: Border.all(color: AppColors.surface),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Task #${index + 1}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete_outline, color: AppColors.error),
                                        onPressed: () {
                                          setState(() {
                                            final removed = _taskControllers.removeAt(index);
                                            removed['title']?.dispose();
                                            removed['description']?.dispose();
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  _buildTextField(
                                    controller: controllers['title']!,
                                    label: 'Task Title',
                                    hint: 'e.g. Read the guide',
                                    validator: (v) => (v == null || v.trim().isEmpty) ? 'Task title is required' : null,
                                  ),
                                  const SizedBox(height: AppDimension.space8),
                                  _buildTextField(
                                    controller: controllers['description']!,
                                    label: 'Task Description (optional)',
                                    hint: 'What to do for this task',
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                      const SizedBox(height: AppDimension.space16),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            setState(() {
                              _taskControllers.add({
                                'title': TextEditingController(),
                                'description': TextEditingController(),
                              });
                            });
                          },
                          icon: const Icon(Icons.add, color: AppColors.primary),
                          label: const Text(
                            'Add Task',
                            style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColors.primary),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppDimension.radiusSmall),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimension.space32),
                  BlocBuilder<CreateMissionBloc, CreateMissionState>(
                    builder: (context, state) {
                      final isLoading = state.status is UILoading;
                      return _SubmitButton(
                        isLoading: isLoading,
                        onPressed: isLoading ? null : _onSubmit,
                      );
                    },
                  ),
                  const SizedBox(height: AppDimension.space50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    IconData? prefixIcon,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppDimension.space8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFFAAAAAA), fontSize: 14),
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: AppColors.primary, size: 20)
                : null,
            filled: true,
            fillColor: AppColors.background,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppDimension.space16,
              vertical: AppDimension.space12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimension.radiusSmall),
              borderSide: const BorderSide(color: AppColors.surface),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimension.radiusSmall),
              borderSide: const BorderSide(color: AppColors.surface),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimension.radiusSmall),
              borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimension.radiusSmall),
              borderSide: const BorderSide(color: AppColors.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimension.radiusSmall),
              borderSide: const BorderSide(color: AppColors.error, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField<T>({
    required String label,
    required T value,
    required List<T> items,
    required String Function(T) itemLabel,
    required ValueChanged<T?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppDimension.space8),
        DropdownButtonFormField<T>(
          value: value,
          onChanged: onChanged,
          items: items
              .map((item) => DropdownMenuItem<T>(
                    value: item,
                    child: Text(itemLabel(item)),
                  ))
              .toList(),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.background,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppDimension.space16,
              vertical: AppDimension.space12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimension.radiusSmall),
              borderSide: const BorderSide(color: AppColors.surface),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimension.radiusSmall),
              borderSide: const BorderSide(color: AppColors.surface),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimension.radiusSmall),
              borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

// ──────────────────────────────────────────────
// Supporting Widgets
// ──────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.icon,
    required this.children,
  });

  final String title;
  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppDimension.space16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 18),
              const SizedBox(width: AppDimension.space8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimension.space16),
          ...children,
        ],
      ),
    );
  }
}

class _MandatoryToggle extends StatelessWidget {
  const _MandatoryToggle({
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundAlt,
        borderRadius: BorderRadius.circular(AppDimension.radiusSmall),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimension.space16,
        vertical: AppDimension.space12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Mandatory',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Users must complete this mission',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({
    required this.isLoading,
    required this.onPressed,
  });

  final bool isLoading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  color: AppColors.white,
                  strokeWidth: 2.5,
                ),
              )
            : const Text(
                'Create Mission',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
      ),
    );
  }
}
