import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/domain/models/job_models.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/presentation/job_market/bloc/job_market_bloc.dart';
import 'package:wat_project_frontend/presentation/job_market/widgets/job_card.dart';
import 'package:wat_project_frontend/core/widgets/app_popup.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_input_field.dart';
import 'package:wat_project_frontend/domain/services/auth_manager.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class JobSearchPage extends StatefulWidget {
  const JobSearchPage({super.key});

  @override
  State<JobSearchPage> createState() => _JobSearchPageState();
}

class _JobSearchPageState extends State<JobSearchPage> {
  final _searchController = TextEditingController();
  late final JobMarketBloc _bloc;
  List<JobPostingModel> _allJobs = [];
  List<JobPostingModel> _filteredJobs = [];

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.instance<JobMarketBloc>();
    _bloc.add(const JobMarketEvent.listJobs(filters: {}));
    _searchController.addListener(_onSearch);
  }

  void _onSearch() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredJobs = _allJobs.where((j) {
        return (j.position ?? '').toLowerCase().contains(query) ||
            (j.employerTitle ?? '').toLowerCase().contains(query) ||
            (j.locationCity ?? '').toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = AppColors.bg(context);
    final textColor = AppColors.text(context);
    final subtextColor = AppColors.textSub(context);
    final borderColor = AppColors.border(context);

    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<JobMarketBloc, JobMarketState>(
        listenWhen: (previous, current) =>
            previous.status != current.status ||
            previous.addToCartStatus != current.addToCartStatus ||
            previous.jobs != current.jobs,
        listener: (context, state) {
          if (state.status is UILoadSuccess || state.jobs.isNotEmpty) {
            setState(() {
              _allJobs = state.jobs;
              _onSearch();
            });
          }

          if (state.status is UILoadFailed) {
            final msg = (state.status as UILoadFailed).message ?? 'An error occurred loading jobs.';
            _showPopup(context, AppPopupType.error, 'Error', msg);
          }

          if (state.addToCartStatus is UILoadSuccess) {
            _showPopup(context, AppPopupType.success, 'Added to Cart', 'Job has been saved to your cart.');
            _bloc.add(const JobMarketEvent.listJobs(filters: {}));
          } else if (state.addToCartStatus is UILoadFailed) {
            final msg = (state.addToCartStatus as UILoadFailed).message ?? 'Failed to add job to cart.';
            _showPopup(context, AppPopupType.error, 'Error', msg);
          }
        },
        child: Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            title: const Text('JOB BOARD'),
            actions: [
              IconButton(
                icon: AppAssets.img(
                  AppAssets.iconCart,
                  size: 20,
                  color: textColor,
                ),
                onPressed: () => context.push('/jobs/cart'),
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                // Search panel
                Container(
                  padding: const EdgeInsets.all(AppDimension.space16),
                  color: isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt,
                  child: WatInputField(
                    label: 'Search Jobs',
                    hint: 'Position, city, or employer...',
                    controller: _searchController,
                    suffixIcon: AppAssets.img(
                      AppAssets.iconSearch,
                      size: 20,
                      color: subtextColor,
                    ),
                  ),
                ),
                // Results list
                Expanded(
                  child: BlocBuilder<JobMarketBloc, JobMarketState>(
                    builder: (context, state) {
                      if (state.status is UILoading && _allJobs.isEmpty) {
                        return const Center(
                          child: PixelLoadingDots(color: AppColors.primary),
                        );
                      }

                      if (_filteredJobs.isEmpty) {
                        return Center(
                          child: Text(
                            'NO JOBS FOUND.',
                            style: GoogleFonts.notoSansThai(
                              fontSize: 12,
                              color: subtextColor,
                            ),
                          ),
                        );
                      }

                      return ListView.separated(
                        padding: const EdgeInsets.all(AppDimension.space16),
                        itemCount: _filteredJobs.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: AppDimension.space16),
                        itemBuilder: (context, index) {
                          final job = _filteredJobs[index];
                          return JobCard(
                            job: job,
                            onTap: () => context.push('/jobs/${job.jobId}'),
                            onAddToCart: () => _bloc.add(
                              JobMarketEvent.addJobToCart(jobId: job.jobId),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: GetIt.instance<AuthSessionManager>().isAdmin
              ? GestureDetector(
                  onTap: () => context.push('/jobs/create'),
                  child: Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      border: Border.all(
                        color: borderColor,
                        width: AppDimension.pixelBorderWidth,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: borderColor.withValues(alpha: 0.8),
                          offset: const Offset(4, 4),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: AppAssets.img(
                      AppAssets.iconAdd,
                      size: 24,
                      color: AppColors.black,
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }

  void _showPopup(BuildContext context, AppPopupType type, String title, String message) {
    AppPopup.show<void>(
      context: context,
      type: type,
      title: title,
      message: message,
      buttons: [
        AppPopupButton(
          label: 'OK',
          onPressed: () => context.pop(),
        )
      ],
    );
  }
}