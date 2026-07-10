import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wat_project_frontend/data/entities/mission/mission_entity.dart';
import 'package:wat_project_frontend/data/mappers/mission_mapper.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/pagination_response.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';
import 'package:wat_project_frontend/domain/models/paged_model.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/domain/repositories/mission_repository.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/bloc/mission_task_bloc.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/widgets/mission_card.dart';
import 'package:wat_project_frontend/presentation/widgets/error_page.dart';
import 'package:wat_project_frontend/presentation/widgets/list_bloc.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

// ---------------------------------------------------------------------------
// Feed type enum — controls which API endpoint is used
// ---------------------------------------------------------------------------

enum MissionFeedType {
  /// GET /missions  — all missions
  all,

  /// GET /user-missions  — missions the current user has joined
  my,

  /// GET /missions/explore  — explore / discovery feed
  explore,
}

class MissionCardList extends StatefulWidget {
  const MissionCardList({
    super.key,
    this.feedType = MissionFeedType.all,
    this.pageSize = 10,
    this.padding,
    this.missions,
    this.minHeight,
    this.emptyMessage,
  });

  /// Which mission feed to load.
  final MissionFeedType feedType;

  /// Number of items fetched per page.
  final int pageSize;

  /// Optional padding around the list.
  final EdgeInsetsGeometry? padding;

  /// Optional initial items to display (turns off initial network fetch).
  final List<MissionModel>? missions;

  /// Optional minimum height for the list.
  final double? minHeight;

  /// Optional message to display when the list is empty.
  final String? emptyMessage;

  @override
  State<MissionCardList> createState() => _MissionCardListState();
}

class _MissionCardListState extends State<MissionCardList> {
  late final MissionRepository _repository;
  late final ListBloc<MissionModel> _listBloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Prefer RepositoryProvider if available, otherwise fall back to GetIt.
    _repository =
        context.read<MissionRepository?>() ?? getIt<MissionRepository>();

    _listBloc = ListBloc<MissionModel>(
      fetchCallback: (page, pageSize) async {
        final response = await _loadPage(page);
        final models = response.data.map((e) => e.toModel()).toList();
        final totalPages =
            response.pagination?.totalPages ??
            (models.length == pageSize ? page + 1 : page);

        return PagedModel<MissionModel>.fromResponse(
          updatedItems: models,
          serverCurrentPage: page,
          totalPages: totalPages,
          pageSize: pageSize,
        );
      },
      pageSize: widget.pageSize,
      initialItems: widget.missions,
      hasMore: widget.missions == null,
    );

    if (widget.missions == null) {
      _listBloc.add(const ListFetchNextPage());
      _scrollController.addListener(_onScroll);
    }
  }

  @override
  void didUpdateWidget(covariant MissionCardList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.missions != null && widget.missions != oldWidget.missions) {
      _listBloc.add(ListResetItems(widget.missions!, hasMore: false));
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    _listBloc.close();
    super.dispose();
  }

  // ── Scroll listener ──────────────────────────────────────────────────────

  void _onScroll() {
    final pos = _scrollController.position;
    if (pos.pixels >= pos.maxScrollExtent - 250) {
      _listBloc.add(const ListFetchNextPage());
    }
  }

  /// Delegates to the correct repository method based on [widget.feedType].
  Future<PaginationResponse<MissionEntity>> _loadPage(int page) {
    switch (widget.feedType) {
      case MissionFeedType.my:
        return _repository.listMyMissions(
          page: page,
          pageSize: widget.pageSize,
        );
      case MissionFeedType.explore:
        return _repository.listExploreMissions(
          page: page,
          pageSize: widget.pageSize,
        );
      case MissionFeedType.all:
        return _repository.listMissions(page: page, pageSize: widget.pageSize);
    }
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  Widget _buildMissionCard(MissionModel mission) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => context.push('/missions/detail', extra: mission.missionId),
        borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
        child: MissionCard(
          mission: mission,
          onJoinTap:
              (mission.userMission == null ||
                  mission.userMission?.status == UserMissionStatus.notStarted)
               ? () {
                  context.read<MissionTaskBloc>().add(
                    JoinMissionRequested(mission.missionId),
                  );
                }
              : null,
        ),
      ),
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: widget.minHeight ?? 200.0),
      child: BlocBuilder<ListBloc<MissionModel>, ListState<MissionModel>>(
        bloc: _listBloc,
        builder: (context, state) {
          final missions = state.pagedModel.items;
          final hasMore = widget.missions == null && state.pagedModel.hasMore;
          final isLoading = state.status == const UIStatus.loading();
          final isFailed = state.status is UILoadFailed;
          final errorMessage = state.status.mapOrNull(
            loadFailed: (f) =>
                f.message ?? 'Failed to load missions. Please try again.',
          );

          // Initial loading
          if (missions.isEmpty && isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Initial error (no items yet)
          if (missions.isEmpty && isFailed) {
            return ErrorView(
              message:
                  errorMessage ?? 'Failed to load missions. Please try again.',
              onRetry: () => _listBloc.add(const ListFetchNextPage()),
            );
          }

          // Empty state
          if (missions.isEmpty && !hasMore) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  widget.emptyMessage ?? 'No missions available.',
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
              ),
            );
          }

          final listWidget = ListView.builder(
            controller: _scrollController,
            padding:
                widget.padding ??
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: missions.length + (widget.missions == null ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < missions.length) {
                return _buildMissionCard(missions[index]);
              }

              // Bottom sentinel row
              if (isLoading) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (isFailed) {
                return _RetryRow(
                  onRetry: () => _listBloc.add(const ListFetchNextPage()),
                );
              }

              if (!hasMore) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: Text(
                      "You've seen all missions 🎉",
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          );

          if (widget.missions != null) {
            return listWidget;
          }

          return RefreshIndicator(
            onRefresh: () async {
              _listBloc.add(const ListRefresh());
              // Wait until loading finishes or fails
              await _listBloc.stream.firstWhere(
                (state) => state.status != const UIStatus.loading(),
              );
            },
            child: listWidget,
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Private helper widgets
// ---------------------------------------------------------------------------

class _RetryRow extends StatelessWidget {
  const _RetryRow({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: TextButton.icon(
          onPressed: onRetry,
          icon: const Icon(Icons.refresh),
          label: const Text('Load more'),
        ),
      ),
    );
  }
}
