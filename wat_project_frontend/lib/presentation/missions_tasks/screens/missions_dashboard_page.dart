import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/core/widgets/pixel_border_container.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/bloc/mission_task_bloc.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/widgets/mission_card_list.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

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
  String _selectedTab = 'my_mission';
  String _selectedView = 'list';
  String _selectedFilter = 'all';

  DateTime _currentMonth = DateTime(2026, 5);
  DateTime _selectedDate = DateTime(2026, 5, 16);

  final List<String> _months = [
    'JANUARY', 'FEBRUARY', 'MARCH', 'APRIL', 'MAY', 'JUNE',
    'JULY', 'AUGUST', 'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER'
  ];
  final List<String> _weekdays = ['SU', 'MO', 'TU', 'WE', 'TH', 'FR', 'SA'];

  int _daysInMonth(DateTime date) {
    final firstOfNextMonth = DateTime(date.year, date.month + 1, 1);
    return firstOfNextMonth.subtract(const Duration(days: 1)).day;
  }

  int _firstWeekdayOfMonth(DateTime date) {
    final firstDay = DateTime(date.year, date.month, 1);
    return firstDay.weekday % 7;
  }

  bool _isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) return false;
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = AppColors.text(context);

    return Scaffold(
      backgroundColor: AppColors.bg(context),
      appBar: AppBar(
        leading: IconButton(
          icon: AppAssets.img(AppAssets.iconBack, size: 20, color: textColor),
          onPressed: () => context.pop(),
        ),
        title: const Text('MISSION BOARD'),
        actions: [
          IconButton(
            icon: AppAssets.img(AppAssets.iconSearch, size: 20, color: textColor),
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
                child: PixelLoadingDots(color: AppColors.primary),
              );
            }

            if (state.status is UILoadFailed &&
                state.missions.isEmpty &&
                state.exploreMissions.isEmpty) {
              final message = (state.status as UILoadFailed).message ?? 'Failed to load missions';
              return Center(
                child: Text(
                  message.toUpperCase(),
                  style: GoogleFonts.pressStart2p(fontSize: 7, color: AppColors.error),
                ),
              );
            }

            return _selectedView == 'list'
                ? _buildListView()
                : _buildCalendarView(state.missions, state);
          },
        ),
      ),
      floatingActionButton: _selectedView == 'list'
          ? FloatingActionButton(
              onPressed: () => context.push('/missions/create'),
              backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
              elevation: 4,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              child: AppAssets.img(AppAssets.iconAdd, size: 20, color: textColor),
            )
          : null,
    );
  }

  Widget _buildListView() {
    final feedType = _selectedTab == 'my_mission'
        ? MissionFeedType.my
        : MissionFeedType.explore;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimension.space16,
            vertical: AppDimension.space16,
          ),
          child: Column(
            children: [
              _buildSegmentedTab(),
              const SizedBox(height: AppDimension.space16),
              _buildFilterAndToggleRow(),
            ],
          ),
        ),
        Expanded(
          child: MissionCardList(
            key: ValueKey('$_selectedTab-$_selectedFilter'),
            feedType: feedType,
            pageSize: 10,
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimension.space16,
              vertical: 8,
            ),
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
      return _isSameDay(dueDate, _selectedDate);
    }).toList();

    final textColor = AppColors.text(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimension.space16,
            vertical: AppDimension.space16,
          ),
          child: Column(
            children: [
              _buildSegmentedTab(),
              const SizedBox(height: AppDimension.space16),
              _buildFilterAndToggleRow(),
              const SizedBox(height: 20),
              _buildCalendarCard(currentMonthMissions),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_selectedDate.day} ${_getMonthName(_selectedDate.month)}',
                    style: GoogleFonts.pressStart2p(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  WatButton(
                    label: 'New Mission',
                    width: 130,
                    onPressed: () => context.push('/missions/create'),
                  ),
                ],
              ),
              const SizedBox(height: AppDimension.space16),
            ],
          ),
        ),
        Expanded(
          child: MissionCardList(
            key: ValueKey('calendar-my-${_selectedDate.toIso8601String()}'),
            feedType: MissionFeedType.my,
            pageSize: 10,
            missions: selectedDayMissions,
            emptyMessage: 'No missions today',
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimension.space16,
              vertical: 8,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSegmentedTab() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = AppColors.border(context);

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt,
        border: Border.all(color: borderColor, width: AppDimension.pixelBorderWidth),
      ),
      padding: const EdgeInsets.all(2),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTab = 'my_mission';
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                color: _selectedTab == 'my_mission'
                    ? AppColors.primary
                    : Colors.transparent,
                alignment: Alignment.center,
                child: Text(
                  'MY QUESTS',
                  style: GoogleFonts.pressStart2p(
                    fontSize: 7,
                    fontWeight: FontWeight.bold,
                    color: _selectedTab == 'my_mission'
                        ? AppColors.black
                        : AppColors.textSub(context),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTab = 'explore';
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                color: _selectedTab == 'explore'
                    ? AppColors.primary
                    : Colors.transparent,
                alignment: Alignment.center,
                child: Text(
                  'EXPLORE',
                  style: GoogleFonts.pressStart2p(
                    fontSize: 7,
                    fontWeight: FontWeight.bold,
                    color: _selectedTab == 'explore'
                        ? AppColors.black
                        : AppColors.textSub(context),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterAndToggleRow() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = AppColors.border(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _buildFilterPill(
              'RECOMMENDED',
              _selectedFilter == 'recommended',
              () {
                setState(() {
                  _selectedFilter = _selectedFilter == 'recommended'
                      ? 'all'
                      : 'recommended';
                });
              },
            ),
            const SizedBox(width: 8),
            _buildFilterPill('PERSONAL', _selectedFilter == 'personal', () {
              setState(() {
                _selectedFilter = _selectedFilter == 'personal'
                    ? 'all'
                    : 'personal';
              });
            }),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt,
            border: Border.all(color: borderColor, width: AppDimension.pixelBorderWidth),
          ),
          padding: const EdgeInsets.all(2),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedView = 'list';
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  color: _selectedView == 'list'
                      ? AppColors.primary
                      : Colors.transparent,
                  child: AppAssets.img(
                    AppAssets.iconMenu,
                    size: 16,
                    color: _selectedView == 'list'
                        ? AppColors.black
                        : AppColors.textSub(context),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedView = 'calendar';
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  color: _selectedView == 'calendar'
                      ? AppColors.primary
                      : Colors.transparent,
                  child: AppAssets.img(
                    AppAssets.iconCalendar,
                    size: 16,
                    color: _selectedView == 'calendar'
                        ? AppColors.black
                        : AppColors.textSub(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterPill(String label, bool isSelected, VoidCallback onTap) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = AppColors.border(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary
              : (isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt),
          border: Border.all(color: isSelected ? AppColors.primary : borderColor, width: AppDimension.pixelBorderWidth),
        ),
        child: Text(
          label,
          style: GoogleFonts.pressStart2p(
            fontSize: 6,
            fontWeight: FontWeight.bold,
            color: isSelected ? AppColors.black : AppColors.text(context),
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarCard(List<MissionModel> myMissions) {
    final daysInMonth = _daysInMonth(_currentMonth);
    final firstWeekday = _firstWeekdayOfMonth(_currentMonth);
    final totalCells = firstWeekday + daysInMonth;
    final textColor = AppColors.text(context);
    final subtextColor = AppColors.textSub(context);

    return PixelBorderContainer(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_months[_currentMonth.month - 1]} ${_currentMonth.year}',
                style: GoogleFonts.pressStart2p(
                  fontSize: 7,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: AppAssets.img(
                      AppAssets.iconBack,
                      size: 14,
                      color: textColor,
                    ),
                    onPressed: _prevMonth,
                  ),
                  IconButton(
                    icon: RotatedBox(
                      quarterTurns: 2,
                      child: AppAssets.img(
                        AppAssets.iconBack,
                        size: 14,
                        color: textColor,
                      ),
                    ),
                    onPressed: _nextMonth,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppDimension.space16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _weekdays
                .map(
                  (day) => Expanded(
                    child: Center(
                      child: Text(
                        day,
                        style: GoogleFonts.pressStart2p(
                          fontSize: 6,
                          fontWeight: FontWeight.bold,
                          color: subtextColor,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: AppDimension.space12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
            ),
            itemCount: totalCells,
            itemBuilder: (context, index) {
              if (index < firstWeekday) {
                return const SizedBox.shrink();
              }
              final day = index - firstWeekday + 1;
              return _buildDayCell(day, myMissions);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDayCell(int day, List<MissionModel> missions) {
    final date = DateTime(_currentMonth.year, _currentMonth.month, day);
    final isSelected = _isSameDay(date, _selectedDate);

    final dayMissions = missions
        .where(
          (m) =>
              m.userMission?.calculatedDueDate != null &&
              _isSameDay(m.userMission!.calculatedDueDate, date),
        )
        .toList();

    final hasOverdue = dayMissions.any(
      (m) => m.userMission?.status == UserMissionStatus.overdue,
    );
    final hasActive = dayMissions.isNotEmpty && !hasOverdue;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = AppColors.text(context);
    final borderColor = AppColors.border(context);

    Color? bgColor = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    Color cellText = textColor;

    if (hasOverdue) {
      bgColor = AppColors.error.withValues(alpha: 0.15);
      cellText = AppColors.error;
    } else if (hasActive) {
      bgColor = AppColors.success.withValues(alpha: 0.15);
      cellText = AppColors.success;
    }

    if (isSelected) {
      bgColor = AppColors.primary;
      cellText = AppColors.black;
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDate = date;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(
            color: isSelected ? AppColors.primary : borderColor,
            width: AppDimension.pixelBorderWidth,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          '$day',
          style: GoogleFonts.pressStart2p(
            fontSize: 6,
            fontWeight: (isSelected || dayMissions.isNotEmpty)
                ? FontWeight.bold
                : FontWeight.normal,
            color: cellText,
          ),
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    final months = [
      'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
      'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'
    ];
    return months[month - 1];
  }
}
