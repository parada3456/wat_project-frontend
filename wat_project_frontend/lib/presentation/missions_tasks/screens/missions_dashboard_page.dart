import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/bloc/mission_task_bloc.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/widgets/mission_card_list.dart';
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
  String _selectedTab = 'my_mission'; // 'my_mission' or 'explore'
  String _selectedView = 'list'; // 'list' or 'calendar'
  String _selectedFilter = 'all'; // 'all', 'recommended', or 'personal'

  // Calendar states
  DateTime _currentMonth = DateTime(
    2026,
    5,
  ); // Default to May 2026 to match wireframe
  DateTime _selectedDate = DateTime(2026, 5, 16);

  final List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  final List<String> _weekdays = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];

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
    return Scaffold(
      backgroundColor: AppColors.backgroundAlt,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.canPop(),
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
              onPressed: () => context.push('/missions/create'),
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
    final feedType = _selectedTab == 'my_mission'
        ? MissionFeedType.my
        : MissionFeedType.explore;

    return Column(
      children: [
        // Header controls (tabs + filter + toggle)
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
        // Lazy-loading card list — keyed so it resets when tab or filter changes
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
    // Only show missions with deadlines in the current month on the calendar grid
    final currentMonthMissions = myMissions.where((m) {
      final dueDate = m.userMission?.calculatedDueDate;
      if (dueDate == null) return false;
      return dueDate.year == _currentMonth.year &&
          dueDate.month == _currentMonth.month;
    }).toList();

    // Show missions due on the selected day in the list underneath the calendar
    final selectedDayMissions = myMissions.where((m) {
      final dueDate = m.userMission?.calculatedDueDate;
      if (dueDate == null) return false;
      return _isSameDay(dueDate, _selectedDate);
    }).toList();

    return Column(
      children: [
        // Header controls
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
              // Selected date header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_selectedDate.day} ${_getMonthName(_selectedDate.month)}',
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
        // Lazy-loading mission list for the selected day
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
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
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
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: _selectedTab == 'my_mission'
                      ? Colors.white
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: _selectedTab == 'my_mission'
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [],
                ),
                alignment: Alignment.center,
                child: Text(
                  'My mission',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: _selectedTab == 'my_mission'
                        ? Colors.black
                        : Colors.grey[600],
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
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: _selectedTab == 'explore'
                      ? Colors.white
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: _selectedTab == 'explore'
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [],
                ),
                alignment: Alignment.center,
                child: Text(
                  'Explore',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: _selectedTab == 'explore'
                        ? Colors.black
                        : Colors.grey[600],
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Filter pills
        Row(
          children: [
            _buildFilterPill(
              'recommended',
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
            _buildFilterPill('personal', _selectedFilter == 'personal', () {
              setState(() {
                _selectedFilter = _selectedFilter == 'personal'
                    ? 'all'
                    : 'personal';
              });
            }),
          ],
        ),

        // List/Calendar Switcher
        Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
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
                  decoration: BoxDecoration(
                    color: _selectedView == 'list'
                        ? Colors.white
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.list_alt,
                    size: 20,
                    color: _selectedView == 'list'
                        ? Colors.black
                        : Colors.grey[600],
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
                  decoration: BoxDecoration(
                    color: _selectedView == 'calendar'
                        ? Colors.white
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.calendar_month,
                    size: 20,
                    color: _selectedView == 'calendar'
                        ? Colors.black
                        : Colors.grey[600],
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.textPrimary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.textPrimary : Colors.grey[300]!,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : Colors.grey[700],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarCard(List<MissionModel> myMissions) {
    final daysInMonth = _daysInMonth(_currentMonth);
    final firstWeekday = _firstWeekdayOfMonth(_currentMonth);
    final totalCells = firstWeekday + daysInMonth;

    return Container(
      padding: const EdgeInsets.all(AppDimension.space16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Calendar Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_months[_currentMonth.month - 1]} ${_currentMonth.year}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.chevron_left,
                      color: AppColors.textPrimary,
                    ),
                    onPressed: _prevMonth,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.chevron_right,
                      color: AppColors.textPrimary,
                    ),
                    onPressed: _nextMonth,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppDimension.space16),

          // Weekdays header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _weekdays
                .map(
                  (day) => Expanded(
                    child: Center(
                      child: Text(
                        day,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: AppDimension.space12),

          // Grid view of days
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
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

    // Find missions due on this date
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

    Color? bgColor;
    Color textColor = AppColors.textPrimary;
    Border? border;

    if (isSelected) {
      border = Border.all(color: Colors.amber[700]!, width: 2);
    }

    if (hasOverdue) {
      bgColor = Colors.red[500];
      textColor = Colors.white;
    } else if (hasActive) {
      bgColor = Colors.grey[300];
      textColor = Colors.black87;
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
          shape: BoxShape.circle,
          border: border,
        ),
        alignment: Alignment.center,
        child: Text(
          '$day',
          style: TextStyle(
            fontSize: 14,
            fontWeight: (isSelected || dayMissions.isNotEmpty)
                ? FontWeight.bold
                : FontWeight.normal,
            color: textColor,
          ),
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }
}
