import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wat_project_frontend/data/mappers/mission_mapper.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';
import 'package:wat_project_frontend/domain/models/paged_model.dart';
import 'package:wat_project_frontend/domain/repositories/mission_repository.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/bloc/mission_task_bloc.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/widgets/mission_card.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/widgets/mission_segmented_tab.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/widgets/mission_filter_and_toggle_row.dart';
import 'package:wat_project_frontend/presentation/widgets/paginated_list_view.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

class MissionDashboardListView extends StatelessWidget {
  final String selectedTab;
  final String selectedFilter;
  final String exploreSort;
  final String exploreTypeFilter;
  final String selectedView;
  final ValueChanged<String> onTabChanged;
  final ValueChanged<String> onFilterChanged;
  final ValueChanged<String> onExploreSortChanged;
  final ValueChanged<String> onExploreTypeFilterChanged;
  final ValueChanged<String> onViewChanged;

  const MissionDashboardListView({
    super.key,
    required this.selectedTab,
    required this.selectedFilter,
    required this.exploreSort,
    required this.exploreTypeFilter,
    required this.selectedView,
    required this.onTabChanged,
    required this.onFilterChanged,
    required this.onExploreSortChanged,
    required this.onExploreTypeFilterChanged,
    required this.onViewChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isMyMissions = selectedTab == 'my_mission';
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
                selectedTab: selectedTab,
                onTabChanged: onTabChanged,
              ),
              const SizedBox(height: AppDimension.space16),
              MissionFilterAndToggleRow(
                selectedTab: selectedTab,
                selectedFilter: selectedFilter,
                exploreSort: exploreSort,
                exploreTypeFilter: exploreTypeFilter,
                selectedView: selectedView,
                onFilterChanged: onFilterChanged,
                onExploreSortChanged: onExploreSortChanged,
                onExploreTypeFilterChanged: onExploreTypeFilterChanged,
                onViewChanged: onViewChanged,
              ),
            ],
          ),
        ),
        Expanded(
          child: PaginatedListView<MissionModel>(
            key: ValueKey(
              '$selectedTab-$selectedFilter-$exploreSort-$exploreTypeFilter',
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
                if (exploreTypeFilter == 'mandatory') {
                  models = models.where((m) => m.isMandatory).toList();
                } else if (exploreTypeFilter == 'optional') {
                  models = models.where((m) => !m.isMandatory).toList();
                }

                if (exploreSort != 'none') {
                  models.sort((a, b) {
                    final dateA = a.userMission?.calculatedDueDate;
                    final dateB = b.userMission?.calculatedDueDate;
                    if (dateA == null && dateB == null) return 0;
                    if (dateA == null) return exploreSort == 'asc' ? 1 : -1;
                    if (dateB == null) return exploreSort == 'asc' ? -1 : 1;
                    return exploreSort == 'asc'
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
}
