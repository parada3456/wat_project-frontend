import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/bloc/mission_task_bloc.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/widgets/mission_card.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
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
  String _selectedFilter = 'ALL';

  final List<String> _filters = ['ALL', 'MANDATORY', 'COMPLETED', 'OVERDUE'];

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
    final textColor = AppColors.text(context);
    final subtextColor = AppColors.textSub(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: AppColors.bg(context),
      appBar: AppBar(
        leading: IconButton(
          icon: AppAssets.img(AppAssets.iconBack, size: 20, color: textColor),
          onPressed: () => context.pop(),
        ),
        title: const Text('SEARCH QUESTS'),
      ),
      body: SafeArea(
        child: BlocBuilder<MissionTaskBloc, MissionTaskState>(
          builder: (context, state) {
            if (state.missions.isEmpty && state.status is UILoading) {
              return const Center(
                child: PixelLoadingDots(color: AppColors.primary),
              );
            }

            if (state.status is UILoadFailed) {
              final message = (state.status as UILoadFailed).message ?? 'Failed to load missions';
              return Center(
                child: Text(
                  message.toUpperCase(),
                  style: GoogleFonts.notoSansThai(fontSize: 7, color: AppColors.error),
                ),
              );
            }

            final query = _searchController.text.trim().toLowerCase();
            final filteredMissions = state.missions.where((dm) {
              final matchesQuery =
                  query.isEmpty ||
                  dm.title.toLowerCase().contains(query) ||
                  (dm.description?.toLowerCase().contains(query) ?? false);

              bool matchesFilter = true;
              if (_selectedFilter == 'MANDATORY') {
                matchesFilter = dm.isMandatory;
              } else if (_selectedFilter == 'COMPLETED') {
                matchesFilter =
                    dm.userMission?.status == UserMissionStatus.completed;
              } else if (_selectedFilter == 'OVERDUE') {
                matchesFilter =
                    dm.userMission?.status == UserMissionStatus.overdue;
              }

              return matchesQuery && matchesFilter;
            }).toList();

            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppDimension.space16),
                  color: isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt,
                  child: Column(
                    children: [
                      WatInputField(
                        label: 'QUERY',
                        hint: 'Type keyword...',
                        controller: _searchController,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: AppAssets.img(
                            AppAssets.iconSearch,
                            size: 16,
                            color: subtextColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppDimension.space16),
                      SizedBox(
                        height: 36,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: _filters.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: AppDimension.space8),
                          itemBuilder: (context, index) {
                            final filter = _filters[index];
                            final isSelected = _selectedFilter == filter;
                            final borderColor = AppColors.border(context);

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
                                      : (isDark ? AppColors.darkSurface : AppColors.lightSurface),
                                  border: Border.all(
                                    color: isSelected ? AppColors.primary : borderColor,
                                    width: AppDimension.pixelBorderWidth,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    filter,
                                    style: GoogleFonts.notoSansThai(
                                      fontSize: 6,
                                      color: isSelected
                                          ? AppColors.black
                                          : textColor,
                                      fontWeight: FontWeight.bold,
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
                      ? Center(
                          child: Text(
                            'NO QUESTS FOUND.',
                            style: GoogleFonts.notoSansThai(
                              fontSize: 7,
                              color: subtextColor,
                            ),
                          ),
                        )
                      : ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(AppDimension.space16),
                          itemCount: filteredMissions.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: AppDimension.space12),
                          itemBuilder: (context, index) {
                            final dm = filteredMissions[index];

                            return InkWell(
                              onTap: () => context.push(
                                '/missions/detail',
                                extra: dm.missionId,
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
