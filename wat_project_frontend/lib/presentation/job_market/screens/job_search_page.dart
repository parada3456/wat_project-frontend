import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wat_project_frontend/core/widgets/app_popup.dart';
import 'package:wat_project_frontend/domain/models/paged_model.dart';
import 'package:wat_project_frontend/presentation/widgets/paginated_list_view.dart';
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
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

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
            final msg =
                (state.status as UILoadFailed).message ??
                'An error occurred loading jobs.';
            _showPopup(context, AppPopupType.error, 'Error', msg);
          }

          if (state.addToCartStatus is UILoadSuccess) {
            _showPopup(
              context,
              AppPopupType.success,
              'Added to Cart',
              'Job has been saved to your cart.',
            );
            // Refresh list after dynamic cart mutation updates status signatures
            _bloc.add(const JobMarketEvent.listJobs(filters: {}));
          } else if (state.addToCartStatus is UILoadFailed) {
            final msg =
                (state.addToCartStatus as UILoadFailed).message ??
                'Failed to add job to cart.';
            _showPopup(context, AppPopupType.error, 'Error', msg);
          }
        },
        child: Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            title: const Text(
              'Job & Reviews',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
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
                        return const Center(child: CircularProgressIndicator());
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

                      return PaginatedListView<JobPostingModel>(
                        padding: const EdgeInsets.all(AppDimension.space16),
                        fetchPage: (page, pageSize) async {
                          return PagedModel<JobPostingModel>.fromResponse(
                            updatedItems: _filteredJobs,
                            serverCurrentPage: page,
                            totalPages: 1,
                            pageSize: pageSize,
                          );
                        },
                        initialItems: _filteredJobs,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: AppDimension.space16),
                        emptyMessage: 'No jobs found.',
                        itemBuilder: (context, job) {
                          return JobCard(
                            job: job,
                            onTap: () async {
                              final res =
                                  await context.push<bool>('/jobs/${job.jobId}');
                              if (res == true && context.mounted) {
                                _bloc.add(
                                  const JobMarketEvent.listJobs(filters: {}),
                                );
                              }
                            },
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
              ? FloatingActionButton(
                  backgroundColor: AppColors.primary,
                  child: const Icon(Icons.add, color: AppColors.white),
                  onPressed: () async {
                    final res = await context.push<bool>('/jobs/create');
                    if (res == true && context.mounted) {
                      _bloc.add(const JobMarketEvent.listJobs(filters: {}));
                    }
                  },
                )
              : null,
        ),
      ),
    );
  }

  void _showPopup(
    BuildContext context,
    AppPopupType type,
    String title,
    String message,
  ) {
    AppPopup.show<void>(
      context: context,
      type: type,
      title: title,
      message: message,
      buttons: [
        AppPopupButton(label: 'OK', onPressed: () => context.pop(context)),
      ],
    );
  }
}
