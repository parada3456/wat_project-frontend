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
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: widget.minHeight ?? 200.0),
      child: PagedListView<MissionModel>(
        bloc: _listBloc,
        itemBuilder: (context, mission) => _buildMissionCard(mission),
        emptyMessage: widget.emptyMessage ?? 'No missions available.',
        noMoreItemsMessage: widget.missions == null ? "YOU'VE SEEN ALL MISSIONS 🎉" : "",
        padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        scrollController: widget.missions == null ? _scrollController : null,
        enablePullToRefresh: widget.missions == null,
      ),
    );
  }
}
