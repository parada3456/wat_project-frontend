import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/core/widgets/pixel_border_container.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/presentation/job_market/bloc/job_market_bloc.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

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
    final textColor = AppColors.text(context);
    final subtextColor = AppColors.textSub(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        backgroundColor: AppColors.bg(context),
        appBar: AppBar(
          leading: IconButton(
            icon: AppAssets.img(AppAssets.iconBack, size: 20, color: textColor),
            onPressed: () => context.pop(),
          ),
          title: const Text('JOB COMPARE'),
        ),
        body: BlocBuilder<JobMarketBloc, JobMarketState>(
          builder: (context, state) {
            if (state.status is UILoading && state.jobs.isEmpty) {
              return const Center(child: PixelLoadingDots(color: AppColors.primary));
            }

            final selectedJobs = state.jobs
                .where((j) => widget.jobIds.contains(j.jobId))
                .toList();

            if (selectedJobs.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppDimension.space32),
                  child: Text(
                    'NO MATCHING JOBS TO COMPARE.',
                    style: GoogleFonts.notoSansThai(
                      fontSize: 8,
                      color: subtextColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppDimension.space16),
                child: PixelBorderContainer(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 24,
                      headingRowColor: WidgetStateProperty.all(
                        isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt,
                      ),
                      columns: [
                        DataColumn(
                          label: Text(
                            'ATTRIBUTE',
                            style: GoogleFonts.notoSansThai(
                              fontSize: 6,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                        ),
                        ...selectedJobs.map(
                          (job) => DataColumn(
                            label: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 150),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    (job.position ?? 'UNKNOWN POSITION').toUpperCase(),
                                    style: GoogleFonts.notoSansThai(
                                      fontSize: 6,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    (job.employerTitle ?? 'UNKNOWN').toUpperCase(),
                                    style: GoogleFonts.notoSansThai(
                                      fontSize: 5,
                                      color: subtextColor,
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
                            DataCell(Text('EMPLOYER', style: GoogleFonts.notoSansThai(fontSize: 6, color: textColor))),
                            ...selectedJobs.map((j) => DataCell(Text((j.employerTitle ?? 'N/A').toUpperCase(), style: GoogleFonts.notoSansThai(fontSize: 6, color: textColor)))),
                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(Text('AGENCY', style: GoogleFonts.notoSansThai(fontSize: 6, color: textColor))),
                            ...selectedJobs.map((j) => DataCell(Text((j.agencyName ?? 'DIRECT').toUpperCase(), style: GoogleFonts.notoSansThai(fontSize: 6, color: textColor)))),
                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(Text('MIN SALARY', style: GoogleFonts.notoSansThai(fontSize: 6, color: textColor))),
                            ...selectedJobs.map(
                              (j) => DataCell(
                                Text('\$${j.salaryRangeMin.toStringAsFixed(2)}/HR',
                                    style: GoogleFonts.notoSansThai(fontSize: 6, color: AppColors.success, fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(Text('MAX SALARY', style: GoogleFonts.notoSansThai(fontSize: 6, color: textColor))),
                            ...selectedJobs.map(
                              (j) => DataCell(
                                Text('\$${j.salaryRangeMax.toStringAsFixed(2)}/HR',
                                    style: GoogleFonts.notoSansThai(fontSize: 6, color: AppColors.success, fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(Text('POSITION TYPE', style: GoogleFonts.notoSansThai(fontSize: 6, color: textColor))),
                            ...selectedJobs.map((j) => DataCell(Text((j.positionType ?? 'N/A').toUpperCase(), style: GoogleFonts.notoSansThai(fontSize: 6, color: textColor)))),
                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(Text('SPONSOR', style: GoogleFonts.notoSansThai(fontSize: 6, color: textColor))),
                            ...selectedJobs.map(
                              (j) => DataCell(
                                AppAssets.img(
                                  j.usSponsor ? AppAssets.iconCheck : AppAssets.iconClose,
                                  color: j.usSponsor ? AppColors.success : AppColors.error,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(Text('LOCATION', style: GoogleFonts.notoSansThai(fontSize: 6, color: textColor))),
                            ...selectedJobs.map(
                              (j) => DataCell(
                                Text('${j.locationCity ?? ''}, ${j.locationState ?? ''}'.toUpperCase(), style: GoogleFonts.notoSansThai(fontSize: 6, color: textColor)),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(Text('GROUP LOC', style: GoogleFonts.notoSansThai(fontSize: 6, color: textColor))),
                            ...selectedJobs.map((j) => DataCell(Text((j.groupLocation ?? 'N/A').toUpperCase(), style: GoogleFonts.notoSansThai(fontSize: 6, color: textColor)))),
                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(Text('SLOTS', style: GoogleFonts.notoSansThai(fontSize: 6, color: textColor))),
                            ...selectedJobs.map((j) => DataCell(Text('${j.availableSlots}', style: GoogleFonts.notoSansThai(fontSize: 6, color: textColor)))),
                          ],
                        ),
                      ],
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
