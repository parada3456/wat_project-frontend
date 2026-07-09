import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wat_project_frontend/data/entities/mission/mission_entity.dart';
import 'package:wat_project_frontend/data/mappers/mission_mapper.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/pagination_response.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';
import 'package:wat_project_frontend/domain/repositories/mission_repository.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/bloc/mission_task_bloc.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/widgets/mission_card.dart';
import 'package:wat_project_frontend/presentation/widgets/error_page.dart';
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

// ---------------------------------------------------------------------------
// MissionCardList
// ---------------------------------------------------------------------------

/// A lazy-loading, paginated list of [MissionCard] widgets.
///
/// Usage:
/// ```dart
/// MissionCardList(feedType: MissionFeedType.my)
/// MissionCardList(feedType: MissionFeedType.explore, pageSize: 10)
/// ```
///
/// Requires [MissionRepository] to be available in the widget tree
/// (provided via [RepositoryProvider] in your DI setup).
class MissionCardList extends StatefulWidget {
  const MissionCardList({
    super.key,
    this.feedType = MissionFeedType.all,
    this.pageSize = 10,
    this.padding,
  });

  /// Which mission feed to load.
  final MissionFeedType feedType;

  /// Number of items fetched per page.
  final int pageSize;

  /// Optional padding around the list.
  final EdgeInsetsGeometry? padding;

  @override
  State<MissionCardList> createState() => _MissionCardListState();
}

class _MissionCardListState extends State<MissionCardList> {
  late final MissionRepository _repository;
  final ScrollController _scrollController = ScrollController();

  final List<MissionModel> _missions = [];
  int _currentPage = 1;
  int _totalPages = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // Prefer RepositoryProvider if available, otherwise fall back to GetIt.
    _repository = context.read<MissionRepository?>() ?? getIt<MissionRepository>();
    _scrollController.addListener(_onScroll);
    _fetchNextPage();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  // ── Scroll listener ──────────────────────────────────────────────────────

  void _onScroll() {
    final pos = _scrollController.position;
    if (pos.pixels >= pos.maxScrollExtent - 250 && !_isLoading && _hasMore) {
      _fetchNextPage();
    }
  }

  // ── Data fetching ─────────────────────────────────────────────────────────

  Future<void> _fetchNextPage() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await _loadPage(_currentPage);
      final entities = response.data;
      final pagination = response.pagination;

      // Convert entities → domain models
      final models = entities.map((e) => e.toModel()).toList();

      setState(() {
        _missions.addAll(models);
        _currentPage++;
        if (pagination != null) {
          _totalPages = pagination.totalPages;
          _hasMore = _currentPage <= _totalPages;
        } else {
          // Fallback: stop when the server returns fewer items than requested
          _hasMore = models.length == widget.pageSize;
        }
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load missions. Please try again.';
      });
    }
  }

  /// Delegates to the correct repository method based on [widget.feedType].
  Future<PaginationResponse<MissionEntity>> _loadPage(int page) {
    switch (widget.feedType) {
      case MissionFeedType.my:
        return _repository.listMyMissions(
            page: page, pageSize: widget.pageSize);
      case MissionFeedType.explore:
        return _repository.listExploreMissions(
            page: page, pageSize: widget.pageSize);
      case MissionFeedType.all:
        return _repository.listMissions(
            page: page, pageSize: widget.pageSize);
    }
  }

  // ── Pull-to-refresh ───────────────────────────────────────────────────────

  Future<void> _refresh() async {
    setState(() {
      _missions.clear();
      _currentPage = 1;
      _totalPages = 1;
      _hasMore = true;
      _errorMessage = null;
    });
    await _fetchNextPage();
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  String _deadlineFor(MissionModel m) {
    final due = m.userMission?.calculatedDueDate;
    if (due == null) return 'Soon';
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${due.day} ${months[due.month - 1]}';
  }

  Widget _buildMissionCard(MissionModel mission) {
    final totalTasks = mission.tasks.length;
    final completedTasks =
        mission.tasks.where((t) => t.isCompleted == true).length;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: MissionCard(
        title: mission.title,
        deadline: _deadlineFor(mission),
        bonusPoints: mission.basePoints,
        location: mission.location,
        isMandatory: mission.isMandatory,
        isLocked: mission.isLocked,
        status: mission.userMission?.status,
        completedTasks: completedTasks,
        totalTasks: totalTasks,
        onJoinTap: (mission.userMission == null ||
                mission.userMission?.status == UserMissionStatus.notStarted)
            ? () {
                context.read<MissionTaskBloc>().add(
                  JoinMissionRequested(mission.missionId),
                );
              }
            : null,
      ),
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    // Initial loading
    if (_missions.isEmpty && _isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Initial error (no items yet)
    if (_missions.isEmpty && _errorMessage != null) {
      return ErrorView(message: _errorMessage!, onRetry: _fetchNextPage);
    }

    // Empty state
    if (_missions.isEmpty && !_hasMore) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Text(
            'No missions available.',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.builder(
        controller: _scrollController,
        padding: widget.padding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: _missions.length + 1, // +1 for bottom sentinel
        itemBuilder: (context, index) {
          if (index < _missions.length) {
            return _buildMissionCard(_missions[index]);
          }

          // Bottom sentinel row
          if (_isLoading) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          if (_errorMessage != null) {
            return _RetryRow(onRetry: _fetchNextPage);
          }

          if (!_hasMore) {
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
