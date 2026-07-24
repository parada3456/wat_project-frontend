import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/presentation/job_market/bloc/job_market_bloc.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

class JobComparePage extends StatefulWidget {
  final List<String> jobIds;
  const JobComparePage({super.key, required this.jobIds});

  @override
  State<JobComparePage> createState() => _JobComparePageState();
}

class _JobComparePageState extends State<JobComparePage> {
  late final JobMarketBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.instance<JobMarketBloc>();
    _bloc.add(const JobMarketEvent.listJobs(filters: {}));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
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
            'Job Comparison',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: BlocBuilder<JobMarketBloc, JobMarketState>(
          builder: (context, state) {
            if (state.status is UILoading && state.jobs.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            final selectedJobs = state.jobs
                .where((j) => widget.jobIds.contains(j.jobId))
                .toList();

            if (selectedJobs.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(AppDimension.space32),
                  child: Text(
                    'No matching jobs found to compare.',
                    style: TextStyle(color: AppColors.textSecondary),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppDimension.space16),
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppDimension.radiusMedium,
                    ),
                  ),
                  color: AppColors.background,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppDimension.space16,
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: 24,
                        headingRowColor: WidgetStateProperty.all(
                          AppColors.backgroundAlt,
                        ),
                        columns: [
                          const DataColumn(
                            label: Text(
                              'Attribute',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          ...selectedJobs.map(
                            (job) => DataColumn(
                              label: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 150,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      job.position ?? 'Unknown Position',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primary,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      job.employerTitle ?? 'Unknown Employer',
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: AppColors.textSecondary,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                        rows: [
                          DataRow(
                            cells: [
                              const DataCell(
                                Text(
                                  'Employer',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                              ...selectedJobs.map(
                                (j) => DataCell(Text(j.employerTitle ?? 'N/A')),
                              ),
                            ],
                          ),
                          DataRow(
                            cells: [
                              const DataCell(
                                Text(
                                  'Agency',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                              ...selectedJobs.map(
                                (j) => DataCell(Text(j.agencyName ?? 'Direct')),
                              ),
                            ],
                          ),
                          DataRow(
                            cells: [
                              const DataCell(
                                Text(
                                  'Min Salary',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                              ...selectedJobs.map(
                                (j) => DataCell(
                                  Text(
                                    '\$${j.salaryRangeMin.toStringAsFixed(2)}/hr',
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          DataRow(
                            cells: [
                              const DataCell(
                                Text(
                                  'Max Salary',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                              ...selectedJobs.map(
                                (j) => DataCell(
                                  Text(
                                    '\$${j.salaryRangeMax.toStringAsFixed(2)}/hr',
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          DataRow(
                            cells: [
                              const DataCell(
                                Text(
                                  'Position Type',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                              ...selectedJobs.map(
                                (j) => DataCell(Text(j.positionType ?? 'N/A')),
                              ),
                            ],
                          ),
                          DataRow(
                            cells: [
                              const DataCell(
                                Text(
                                  'Visa Sponsor',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                              ...selectedJobs.map(
                                (j) => DataCell(
                                  Icon(
                                    j.usSponsor
                                        ? Icons.check_circle
                                        : Icons.cancel,
                                    color: j.usSponsor
                                        ? Colors.green
                                        : Colors.red,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          DataRow(
                            cells: [
                              const DataCell(
                                Text(
                                  'Location',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                              ...selectedJobs.map(
                                (j) => DataCell(
                                  Text(
                                    '${j.locationCity ?? ''}, ${j.locationState ?? ''}',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          DataRow(
                            cells: [
                              const DataCell(
                                Text(
                                  'Group Location',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                              ...selectedJobs.map(
                                (j) => DataCell(Text(j.groupLocation ?? 'N/A')),
                              ),
                            ],
                          ),
                          DataRow(
                            cells: [
                              const DataCell(
                                Text(
                                  'Available Slots',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                              ...selectedJobs.map(
                                (j) => DataCell(Text('${j.availableSlots}')),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
