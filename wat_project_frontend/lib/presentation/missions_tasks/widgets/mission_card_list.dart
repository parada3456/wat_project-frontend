import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
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
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

enum MissionFeedType {
  all,
  my,
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

  final MissionFeedType feedType;
  final int pageSize;
  final EdgeInsetsGeometry? padding;
  final List<MissionModel>? missions;
  final double? minHeight;
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

  void _onScroll() {
    final pos = _scrollController.position;
    if (pos.pixels >= pos.maxScrollExtent - 250) {
      _listBloc.add(const ListFetchNextPage());
    }
  }

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

  Widget _buildMissionCard(MissionModel mission) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => context.push('/missions/detail', extra: mission.missionId),
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

  @override
  Widget build(BuildContext context) {
    final subtextColor = AppColors.textSub(context);

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

          if (missions.isEmpty && isLoading) {
            return const Center(child: PixelLoadingDots(color: AppColors.primary));
          }

          if (missions.isEmpty && isFailed) {
            return ErrorPage(
              message:
                  (errorMessage ?? 'Failed to load missions. Please try again.').toUpperCase(),
              onRetry: () => _listBloc.add(const ListFetchNextPage()),
            );
          }

          if (missions.isEmpty && !hasMore) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  (widget.emptyMessage ?? 'No missions available.').toUpperCase(),
                  style: GoogleFonts.pressStart2p(
                    fontSize: 7,
                    color: subtextColor,
                  ),
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

              if (isLoading) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Center(child: PixelLoadingDots(color: AppColors.primary)),
                );
              }

              if (isFailed) {
                return _RetryRow(
                  onRetry: () => _listBloc.add(const ListFetchNextPage()),
                );
              }

              if (!hasMore) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: Text(
                      "YOU'VE SEEN ALL MISSIONS 🎉",
                      style: GoogleFonts.pressStart2p(
                        fontSize: 6,
                        color: subtextColor,
                      ),
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

class _RetryRow extends StatelessWidget {
  const _RetryRow({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: WatButton(
          label: 'LOAD MORE',
          width: 140,
          onPressed: onRetry,
        ),
      ),
    );
  }
}
