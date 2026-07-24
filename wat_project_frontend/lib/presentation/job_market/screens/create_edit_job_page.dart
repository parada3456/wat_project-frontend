import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:wat_project_frontend/core/widgets/app_popup.dart';
import 'package:wat_project_frontend/domain/models/job/job_posting_model.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/presentation/job_market/bloc/job_market_bloc.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_input_field.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

class CreateEditJobPage extends StatelessWidget {
  final String? jobId;

  const CreateEditJobPage({super.key, this.jobId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: GetIt.instance<JobMarketBloc>(),
      child: _CreateEditJobView(jobId: jobId),
    );
  }
}

class _CreateEditJobView extends StatefulWidget {
  final String? jobId;

  const _CreateEditJobView({this.jobId});

  @override
  State<_CreateEditJobView> createState() => _CreateEditJobViewState();
}

class _CreateEditJobViewState extends State<_CreateEditJobView> {
  final _agencyController = TextEditingController();
  final _employerController = TextEditingController();
  final _positionController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _groupLocationController = TextEditingController();
  final _salaryMinController = TextEditingController(text: '0.0');
  final _salaryMaxController = TextEditingController(text: '0.0');
  final _slotsController = TextEditingController(text: '0');
  final _descriptionController = TextEditingController();
  final _sourceUrlController = TextEditingController();

  String _positionType = 'Full-time';
  bool _usSponsor = false;
  bool _initialized = false;

  String? _agencyError;
  String? _employerError;
  String? _positionError;
  String? _cityError;
  String? _stateError;
  String? _salaryMinError;
  String? _salaryMaxError;
  String? _slotsError;

  bool get isEdit => widget.jobId != null;

  @override
  void initState() {
    super.initState();
    if (isEdit) {
      context.read<JobMarketBloc>().add(
        JobMarketEvent.getJobDetail(jobId: widget.jobId!),
      );
    } else {
      _initialized = true;
    }
  }

  @override
  void dispose() {
    _agencyController.dispose();
    _employerController.dispose();
    _positionController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _groupLocationController.dispose();
    _salaryMinController.dispose();
    _salaryMaxController.dispose();
    _slotsController.dispose();
    _descriptionController.dispose();
    _sourceUrlController.dispose();
    super.dispose();
  }

  void _populateFields(JobPostingModel job) {
    if (_initialized) return;
    _agencyController.text = job.agencyName ?? '';
    _employerController.text = job.employerTitle ?? '';
    _positionController.text = job.position ?? '';
    _cityController.text = job.locationCity ?? '';
    _stateController.text = job.locationState ?? '';
    _groupLocationController.text = job.groupLocation ?? '';
    _salaryMinController.text = job.salaryRangeMin.toString();
    _salaryMaxController.text = job.salaryRangeMax.toString();
    _slotsController.text = job.availableSlots.toString();
    _descriptionController.text = job.description ?? '';
    _sourceUrlController.text = job.sourceUrl ?? '';
    _positionType = job.positionType ?? 'Full-time';
    _usSponsor = job.usSponsor;
    _initialized = true;
  }

  bool _validateForm() {
    setState(() {
      _agencyError = null;
      _employerError = null;
      _positionError = null;
      _cityError = null;
      _stateError = null;
      _salaryMinError = null;
      _salaryMaxError = null;
      _slotsError = null;
    });

    bool isValid = true;

    if (_positionController.text.trim().isEmpty) {
      setState(() => _positionError = 'Position title is required');
      isValid = false;
    }
    if (_employerController.text.trim().isEmpty) {
      setState(() => _employerError = 'Employer name is required');
      isValid = false;
    }
    if (_cityController.text.trim().isEmpty) {
      setState(() => _cityError = 'Location city is required');
      isValid = false;
    }
    if (_stateController.text.trim().isEmpty) {
      setState(() => _stateError = 'Location state is required');
      isValid = false;
    }

    final salaryMin = double.tryParse(_salaryMinController.text) ?? -1;
    if (salaryMin < 0) {
      setState(() => _salaryMinError = 'Salary min must be non-negative');
      isValid = false;
    }

    final salaryMax = double.tryParse(_salaryMaxController.text) ?? -1;
    if (salaryMax < 0) {
      setState(() => _salaryMaxError = 'Salary max must be non-negative');
      isValid = false;
    } else if (salaryMax < salaryMin) {
      setState(() => _salaryMaxError = 'Salary max must be >= salary min');
      isValid = false;
    }

    final slots = int.tryParse(_slotsController.text) ?? -1;
    if (slots < 0) {
      setState(() => _slotsError = 'Available slots must be non-negative');
      isValid = false;
    }

    return isValid;
  }

  void _saveJob() {
    if (!_validateForm()) return;

    final job = JobPostingModel(
      jobId: isEdit ? widget.jobId! : '',
      agencyName: _agencyController.text.trim(),
      employerTitle: _employerController.text.trim(),
      position: _positionController.text.trim(),
      positionType: _positionType,
      locationCity: _cityController.text.trim(),
      locationState: _stateController.text.trim(),
      groupLocation: _groupLocationController.text.trim(),
      usSponsor: _usSponsor,
      salaryRangeMin: double.parse(_salaryMinController.text),
      salaryRangeMax: double.parse(_salaryMaxController.text),
      availableSlots: int.parse(_slotsController.text),
      description: _descriptionController.text.trim(),
      sourceUrl: _sourceUrlController.text.trim(),
      updatedAt: DateTime.now(),
    );

    if (isEdit) {
      context.read<JobMarketBloc>().add(
        JobMarketEvent.updateJob(id: widget.jobId!, job: job),
      );
    } else {
      context.read<JobMarketBloc>().add(JobMarketEvent.createJob(job: job));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<JobMarketBloc, JobMarketState>(
      listenWhen: (previous, current) =>
          previous.status != current.status ||
          previous.createJobStatus != current.createJobStatus ||
          previous.updateJobStatus != current.updateJobStatus ||
          previous.jobDetail != current.jobDetail,
      listener: (context, state) {
        if (isEdit &&
            state.status is UILoadSuccess &&
            state.jobDetail != null) {
          _populateFields(state.jobDetail!.job.toModel());
        }

        if (state.createJobStatus is UILoadSuccess) {
          _showPopup(
            context,
            AppPopupType.success,
            'Job Created',
            'The job has been created successfully.',
            onConfirm: () {
              context.pop();
              context.pop(true);
            },
          );
        } else if (state.createJobStatus is UILoadFailed) {
          final msg =
              (state.createJobStatus as UILoadFailed).message ??
              'Failed to create job.';
          _showPopup(context, AppPopupType.error, 'Error', msg);
        }

        if (state.updateJobStatus is UILoadSuccess) {
          _showPopup(
            context,
            AppPopupType.success,
            'Job Updated',
            'The job has been updated successfully.',
            onConfirm: () {
              context.pop();
              context.pop(true);
            },
          );
        } else if (state.updateJobStatus is UILoadFailed) {
          final msg =
              (state.updateJobStatus as UILoadFailed).message ??
              'Failed to update job.';
          _showPopup(context, AppPopupType.error, 'Error', msg);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
            onPressed: () => context.pop(),
          ),
          title: Text(
            isEdit ? 'Edit Job' : 'Create Job',
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: SafeArea(
          child: BlocBuilder<JobMarketBloc, JobMarketState>(
            builder: (context, state) {
              if (isEdit && state.status is UILoading && !_initialized) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              }

              final isSaving =
                  state.createJobStatus is UILoading ||
                  state.updateJobStatus is UILoading;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(AppDimension.space16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WatInputField(
                      label: 'Job Title / Position',
                      hint: 'e.g. Ride Operator',
                      controller: _positionController,
                      errorText: _positionError,
                    ),
                    const SizedBox(height: AppDimension.space16),
                    WatInputField(
                      label: 'Employer / Business Title',
                      hint: 'e.g. Cedar Point',
                      controller: _employerController,
                      errorText: _employerError,
                    ),
                    const SizedBox(height: AppDimension.space16),
                    WatInputField(
                      label: 'Agency Name',
                      hint: 'e.g. OEG',
                      controller: _agencyController,
                      errorText: _agencyError,
                    ),
                    const SizedBox(height: AppDimension.space16),
                    const Text(
                      'Position Type',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppDimension.space4),
                    Container(
                      height: 45,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimension.space16,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundAlt,
                        borderRadius: BorderRadius.circular(
                          AppDimension.radiusSmall,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _positionType,
                          isExpanded: true,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.textSecondary,
                          ),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                _positionType = newValue;
                              });
                            }
                          },
                          items: <String>['Full-time', 'Part-time', 'Seasonal']
                              .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                );
                              })
                              .toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppDimension.space16),
                    Row(
                      children: [
                        Expanded(
                          child: WatInputField(
                            label: 'City',
                            hint: 'e.g. Sandusky',
                            controller: _cityController,
                            errorText: _cityError,
                          ),
                        ),
                        const SizedBox(width: AppDimension.space16),
                        Expanded(
                          child: WatInputField(
                            label: 'State',
                            hint: 'e.g. OH',
                            controller: _stateController,
                            errorText: _stateError,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimension.space16),
                    WatInputField(
                      label: 'Group Location / Housing Location',
                      hint: 'e.g. Sandusky, OH area',
                      controller: _groupLocationController,
                    ),
                    const SizedBox(height: AppDimension.space16),
                    Row(
                      children: [
                        Expanded(
                          child: WatInputField(
                            label: 'Salary Min (\$ / hour)',
                            hint: '15.00',
                            controller: _salaryMinController,
                            errorText: _salaryMinError,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppDimension.space16),
                        Expanded(
                          child: WatInputField(
                            label: 'Salary Max (\$ / hour)',
                            hint: '18.00',
                            controller: _salaryMaxController,
                            errorText: _salaryMaxError,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimension.space16),
                    WatInputField(
                      label: 'Available Slots',
                      hint: 'e.g. 5',
                      controller: _slotsController,
                      errorText: _slotsError,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: AppDimension.space16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Requires US Sponsor Verification',
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Switch(
                          value: _usSponsor,
                          activeThumbColor: AppColors.primary,
                          onChanged: (val) {
                            setState(() {
                              _usSponsor = val;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimension.space16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Job Description',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: AppDimension.space4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimension.space16,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.backgroundAlt,
                            borderRadius: BorderRadius.circular(
                              AppDimension.radiusSmall,
                            ),
                          ),
                          child: TextField(
                            controller: _descriptionController,
                            maxLines: 4,
                            decoration: const InputDecoration(
                              hintText:
                                  'Provide details about the job, role, or requirements...',
                              hintStyle: TextStyle(
                                fontSize: 15,
                                color: AppColors.textSecondary,
                              ),
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(
                              fontSize: 15,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimension.space16),
                    WatInputField(
                      label: 'Info Link / Source URL',
                      hint: 'https://...',
                      controller: _sourceUrlController,
                    ),
                    const SizedBox(height: 32),
                    WatButton(
                      label: isEdit ? 'Save Changes' : 'Create Job Posting',
                      isLoading: isSaving,
                      onPressed: _saveJob,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showPopup(
    BuildContext context,
    AppPopupType type,
    String title,
    String message, {
    VoidCallback? onConfirm,
  }) {
    AppPopup.show<void>(
      context: context,
      type: type,
      title: title,
      message: message,
      buttons: [
        AppPopupButton(
          label: 'OK',
          onPressed: onConfirm ?? () => Navigator.pop(context),
        ),
      ],
    );
  }
}
