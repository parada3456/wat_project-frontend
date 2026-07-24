import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wat_project_frontend/core/utils/date_formatter.dart';
import 'package:wat_project_frontend/data/mappers/mission_mapper.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';
import 'package:wat_project_frontend/domain/models/paged_model.dart';
import 'package:wat_project_frontend/domain/repositories/mission_repository.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/bloc/mission_task_bloc.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/widgets/mission_card.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/widgets/mission_segmented_tab.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/widgets/mission_filter_and_toggle_row.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/widgets/mission_dashboard_calendar_card.dart';
import 'package:wat_project_frontend/presentation/widgets/paginated_list_view.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

class MissionsDashboardPage extends StatelessWidget {
  const MissionsDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MissionTaskBloc>(
      create: (context) => getIt<MissionTaskBloc>()
        ..add(const MissionsTasksListRequested())
        ..add(const ExploreMissionsRequested()),
      child: const MissionsDashboardView(),
    );
  }
}

class MissionsDashboardView extends StatefulWidget {
  const MissionsDashboardView({super.key});

  @override
  State<MissionsDashboardView> createState() => _MissionsDashboardViewState();
}

class _MissionsDashboardViewState extends State<MissionsDashboardView> {
  String _selectedTab = 'my_mission'; // 'my_mission' or 'explore'
  String _selectedView = 'list'; // 'list' or 'calendar'
  String _selectedFilter = 'all'; // 'all', 'recommended', or 'personal'

  // Explore tab sort and filter state
  String _exploreSort = 'none'; // 'none', 'asc', 'desc'
  String _exploreTypeFilter = 'all'; // 'all', 'mandatory', 'optional'

  // Calendar states
  DateTime _currentMonth = DateTime(2026, 5); // Default to May 2026
  DateTime _selectedDate = DateTime(2026, 5, 16);

  void _nextMonth() {
    setState(() {
      if (_currentMonth.month == 12) {
        _currentMonth = DateTime(_currentMonth.year + 1, 1);
      } else {
        _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
      }
      _selectedDate = DateTime(_currentMonth.year, _currentMonth.month, 1);
    });
  }

  void _prevMonth() {
    setState(() {
      if (_currentMonth.month == 1) {
        _currentMonth = DateTime(_currentMonth.year - 1, 12);
      } else {
        _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
      }
      _selectedDate = DateTime(_currentMonth.year, _currentMonth.month, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundAlt,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'Mission Explorer',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.textPrimary),
            onPressed: () => context.push('/missions/search'),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<MissionTaskBloc, MissionTaskState>(
          builder: (context, state) {
            final isLoading = state.status is UILoading;

            if (isLoading &&
                state.missions.isEmpty &&
                state.exploreMissions.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }

            if (state.status is UILoadFailed &&
                state.missions.isEmpty &&
                state.exploreMissions.isEmpty) {
              final message = (state.status as UILoadFailed).message;
              return Center(child: Text(message ?? 'Failed to load missions'));
            }

            return _selectedView == 'list'
                ? _buildListView()
                : _buildCalendarView(state.missions, state);
          },
        ),
      ),
      floatingActionButton: _selectedView == 'list'
          ? FloatingActionButton.extended(
              onPressed: () async {
                final res = await context.push<bool>('/missions/create');
                if (res == true && context.mounted) {
                  context.read<MissionTaskBloc>()
                    ..add(const MissionsTasksListRequested())
                    ..add(const ExploreMissionsRequested());
                }
              },
              backgroundColor: AppColors.surface,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              icon: const Icon(Icons.add, color: AppColors.textPrimary),
              label: const Text(
                'Add Mission',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildListView() {
    final isMyMissions = _selectedTab == 'my_mission';
    final repo = getIt<MissionRepository>();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimension.space16,
            vertical: AppDimension.space16,
          ),
          child: Column(
            children: [
              MissionSegmentedTab(
                selectedTab: _selectedTab,
                onTabChanged: (tab) => setState(() => _selectedTab = tab),
              ),
              const SizedBox(height: AppDimension.space16),
              MissionFilterAndToggleRow(
                selectedTab: _selectedTab,
                selectedFilter: _selectedFilter,
                exploreSort: _exploreSort,
                exploreTypeFilter: _exploreTypeFilter,
                selectedView: _selectedView,
                onFilterChanged: (f) => setState(() => _selectedFilter = f),
                onExploreSortChanged: (s) => setState(() => _exploreSort = s),
                onExploreTypeFilterChanged: (tf) =>
                    setState(() => _exploreTypeFilter = tf),
                onViewChanged: (v) => setState(() => _selectedView = v),
              ),
            ],
          ),
        ),
        Expanded(
          child: PaginatedListView<MissionModel>(
            key: ValueKey(
              '$_selectedTab-$_selectedFilter-$_exploreSort-$_exploreTypeFilter',
            ),
            pageSize: 10,
            fetchPage: (page, pageSize) async {
              final response = isMyMissions
                  ? await repo.listMyMissions(page: page, pageSize: pageSize)
                  : await repo.listExploreMissions(
                      page: page,
                      pageSize: pageSize,
                    );
              var models = response.data.map((e) => e.toModel()).toList();

              if (!isMyMissions) {
                if (_exploreTypeFilter == 'mandatory') {
                  models = models.where((m) => m.isMandatory).toList();
                } else if (_exploreTypeFilter == 'optional') {
                  models = models.where((m) => !m.isMandatory).toList();
                }

                if (_exploreSort != 'none') {
                  models.sort((a, b) {
                    final dateA = a.userMission?.calculatedDueDate;
                    final dateB = b.userMission?.calculatedDueDate;
                    if (dateA == null && dateB == null) return 0;
                    if (dateA == null) return _exploreSort == 'asc' ? 1 : -1;
                    if (dateB == null) return _exploreSort == 'asc' ? -1 : 1;
                    return _exploreSort == 'asc'
                        ? dateA.compareTo(dateB)
                        : dateB.compareTo(dateA);
                  });
                }
              }

              final totalPages = response.pagination?.totalPages ??
                  (models.length == pageSize ? page + 1 : page);
              return PagedModel<MissionModel>.fromResponse(
                updatedItems: models,
                serverCurrentPage: page,
                totalPages: totalPages,
                pageSize: pageSize,
              );
            },
            itemBuilder: (context, mission) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: () async {
                  final res = await context.push<bool>(
                    '/missions/detail',
                    extra: mission.missionId,
                  );
                  if (res == true && context.mounted) {
                    context.read<MissionTaskBloc>()
                      ..add(const MissionsTasksListRequested())
                      ..add(const ExploreMissionsRequested());
                  }
                },
                borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
                child: MissionCard(
                  mission: mission,
                  onJoinTap: (mission.userMission == null ||
                          mission.userMission?.status ==
                              UserMissionStatus.notStarted)
                      ? () => context.read<MissionTaskBloc>().add(
                            JoinMissionRequested(mission.missionId),
                          )
                      : null,
                ),
              ),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimension.space16,
              vertical: 8,
            ),
            emptyMessage:
                isMyMissions ? 'No missions yet.' : 'Nothing to explore.',
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarView(
    List<MissionModel> myMissions,
    MissionTaskState state,
  ) {
    final currentMonthMissions = myMissions.where((m) {
      final dueDate = m.userMission?.calculatedDueDate;
      if (dueDate == null) return false;
      return dueDate.year == _currentMonth.year &&
          dueDate.month == _currentMonth.month;
    }).toList();

    final selectedDayMissions = myMissions.where((m) {
      final dueDate = m.userMission?.calculatedDueDate;
      if (dueDate == null) return false;
      return DateFormatter.isSameDay(dueDate, _selectedDate);
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimension.space16,
            vertical: AppDimension.space16,
          ),
          child: Column(
            children: [
              MissionSegmentedTab(
                selectedTab: _selectedTab,
                onTabChanged: (tab) => setState(() => _selectedTab = tab),
              ),
              const SizedBox(height: AppDimension.space16),
              MissionFilterAndToggleRow(
                selectedTab: _selectedTab,
                selectedFilter: _selectedFilter,
                exploreSort: _exploreSort,
                exploreTypeFilter: _exploreTypeFilter,
                selectedView: _selectedView,
                onFilterChanged: (f) => setState(() => _selectedFilter = f),
                onExploreSortChanged: (s) => setState(() => _exploreSort = s),
                onExploreTypeFilterChanged: (tf) =>
                    setState(() => _exploreTypeFilter = tf),
                onViewChanged: (v) => setState(() => _selectedView = v),
              ),
              const SizedBox(height: 20),
              MissionDashboardCalendarCard(
                currentMonth: _currentMonth,
                selectedDate: _selectedDate,
                myMissions: currentMonthMissions,
                onPrevMonth: _prevMonth,
                onNextMonth: _nextMonth,
                onSelectDate: (date) => setState(() => _selectedDate = date),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_selectedDate.day} ${DateFormatter.getMonthShortName(_selectedDate.month)}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => context.push('/missions/create'),
                    icon: const Icon(
                      Icons.add,
                      size: 18,
                      color: AppColors.textPrimary,
                    ),
                    label: const Text(
                      'New Mission',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      backgroundColor: AppColors.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimension.space16),
            ],
          ),
        ),
        Expanded(
          child: PaginatedListView<MissionModel>(
            key: ValueKey('calendar-my-${_selectedDate.toIso8601String()}'),
            fetchPage: (page, pageSize) async => PagedModel<MissionModel>(
              items: [],
              nextPage: 1,
              hasMore: false,
              pageSize: 10,
            ),
            initialItems: selectedDayMissions,
            pageSize: 10,
            emptyMessage: 'No missions today',
            itemBuilder: (context, mission) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: () =>
                    context.push('/missions/detail', extra: mission.missionId),
                borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
                child: MissionCard(mission: mission),
              ),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimension.space16,
              vertical: 8,
            ),
          ),
        ),
      ],
    );
  }
}
