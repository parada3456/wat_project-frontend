import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/bloc/mission_task_bloc.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/widgets/mission_card.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_input_field.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class MissionsSearchPage extends StatelessWidget {
  const MissionsSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MissionTaskBloc>(
      create: (context) =>
          getIt<MissionTaskBloc>()..add(const MissionsTasksListRequested()),
      child: const MissionsSearchView(),
    );
  }
}

class MissionsSearchView extends StatefulWidget {
  const MissionsSearchView({super.key});

  @override
  State<MissionsSearchView> createState() => _MissionsSearchViewState();
}

class _MissionsSearchViewState extends State<MissionsSearchView> {
  final _searchController = TextEditingController();
  String _selectedFilter = 'All';

  final List<String> _filters = ['All', 'Mandatory', 'Completed', 'Overdue'];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Search Missions',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<MissionTaskBloc, MissionTaskState>(
          builder: (context, state) {
            if (state.missions.isEmpty && state.status is UILoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }

            if (state.status is UILoadFailed) {
              final message = (state.status as UILoadFailed).message;
              return Center(child: Text(message ?? 'Failed to load missions'));
            }

            // Filter missions locally based on search text and selected filter
            final query = _searchController.text.trim().toLowerCase();
            final filteredMissions = state.missions.where((dm) {
              final matchesQuery =
                  query.isEmpty ||
                  dm.title.toLowerCase().contains(query) ||
                  (dm.description?.toLowerCase().contains(query) ?? false);

              bool matchesFilter = true;
              if (_selectedFilter == 'Mandatory') {
                matchesFilter = dm.isMandatory;
              } else if (_selectedFilter == 'Completed') {
                matchesFilter =
                    dm.userMission?.status == UserMissionStatus.completed;
              } else if (_selectedFilter == 'Overdue') {
                matchesFilter =
                    dm.userMission?.status == UserMissionStatus.overdue;
              }

              return matchesQuery && matchesFilter;
            }).toList();

            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppDimension.space16),
                  color: AppColors.background,
                  child: Column(
                    children: [
                      WatInputField(
                        label: 'Search',
                        hint: 'Search missions...',
                        controller: _searchController,
                        suffixIcon: const Icon(
                          Icons.search,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: AppDimension.space16),
                      SizedBox(
                        height: 40,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: _filters.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: AppDimension.space8),
                          itemBuilder: (context, index) {
                            final filter = _filters[index];
                            final isSelected = _selectedFilter == filter;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedFilter = filter;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppDimension.space16,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.surfaceAlt,
                                  borderRadius: BorderRadius.circular(
                                    AppDimension.radiusExtraLarge,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    filter,
                                    style: TextStyle(
                                      color: isSelected
                                          ? AppColors.white
                                          : AppColors.textSecondary,
                                      fontWeight: isSelected
                                          ? FontWeight.w700
                                          : FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      context.read<MissionTaskBloc>().add(
                        const MissionsTasksListRequested(),
                      );
                    },
                    child: filteredMissions.isEmpty
                        ? const Center(
                            child: Text('No matching missions found.'),
                          )
                        : ListView.separated(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(AppDimension.space16),
                            itemCount: filteredMissions.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: AppDimension.space16),
                            itemBuilder: (context, index) {
                              final dm = filteredMissions[index];

                              return InkWell(
                                onTap: () => context.push(
                                  '/missions/detail',
                                  extra: dm.missionId,
                                ),
                                borderRadius: BorderRadius.circular(
                                  AppDimension.radiusMedium,
                                ),
                                child: MissionCard(mission: dm),
                              );
                            },
                          ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
