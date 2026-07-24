import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/domain/models/job/job_posting_model.dart';
import 'package:wat_project_frontend/domain/models/paged_model.dart';
import 'package:wat_project_frontend/data/sources/api/job_api_client.dart';
import 'package:wat_project_frontend/presentation/job_market/bloc/job_market_bloc.dart';
import 'package:wat_project_frontend/presentation/job_market/widgets/job_card.dart';
import 'package:wat_project_frontend/presentation/widgets/paginated_list_view.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

class JobCardList extends StatefulWidget {
  const JobCardList({
    super.key,
    this.pageSize = 10,
    this.limit,
    this.padding,
    this.emptyMessage,
    this.filters = const {},
  });

  final int pageSize;
  final int? limit;

  final EdgeInsetsGeometry? padding;
  final String? emptyMessage;

  final Map<String, dynamic> filters;

  @override
  State<JobCardList> createState() => _JobCardListState();
}

class _JobCardListState extends State<JobCardList> {
  late final JobApiService _api;

  @override
  void initState() {
    super.initState();
    _api = getIt<JobApiService>();
  }

  Future<PagedModel<JobPostingModel>> _fetchPage(
    int page,
    int pageSize,
  ) async {
    final queryParams = Map<String, dynamic>.from(widget.filters)
      ..['page'] = page
      ..['page_size'] = pageSize;

    final response = await _api.listJobs(queryParams);
    final models = response.data.map((e) => e.toModel()).toList();
    final totalPages = response.pagination?.totalPages ??
        (models.length == pageSize ? page + 1 : page);

    return PagedModel<JobPostingModel>.fromResponse(
      updatedItems: models,
      serverCurrentPage: page,
      totalPages: totalPages,
      pageSize: pageSize,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PaginatedListView<JobPostingModel>(
      fetchPage: _fetchPage,
      pageSize: widget.pageSize,
      limit: widget.limit,
      padding: widget.padding,
      emptyMessage: widget.emptyMessage ?? 'No jobs available.',
      separatorBuilder: (_, _) =>
          const SizedBox(height: AppDimension.space16),
      itemBuilder: (context, job) => JobCard(
        job: job,
        onTap: () => context.push('/jobs/${job.jobId}'),
        onAddToCart: () {
          try {
            context.read<JobMarketBloc>().add(
              JobMarketEvent.addJobToCart(jobId: job.jobId),
            );
          } catch (_) {
            // JobMarketBloc may not be in tree; silently ignore
          }
        },
      ),
    );
  }
}
