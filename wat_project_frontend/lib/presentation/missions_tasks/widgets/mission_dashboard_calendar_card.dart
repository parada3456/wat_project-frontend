import 'package:flutter/material.dart';
import 'package:wat_project_frontend/core/utils/date_formatter.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

class MissionDashboardCalendarCard extends StatelessWidget {
  final DateTime currentMonth;
  final DateTime selectedDate;
  final List<MissionModel> myMissions;
  final VoidCallback onPrevMonth;
  final VoidCallback onNextMonth;
  final ValueChanged<DateTime> onSelectDate;

  const MissionDashboardCalendarCard({
    super.key,
    required this.currentMonth,
    required this.selectedDate,
    required this.myMissions,
    required this.onPrevMonth,
    required this.onNextMonth,
    required this.onSelectDate,
  });

  static final List<String> _months = [
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

  static final List<String> _weekdays = [
    'Su',
    'Mo',
    'Tu',
    'We',
    'Th',
    'Fr',
    'Sa',
  ];

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateFormatter.daysInMonth(currentMonth);
    final firstWeekday = DateFormatter.firstWeekdayOfMonth(currentMonth);
    final totalCells = firstWeekday + daysInMonth;

    return Container(
      padding: const EdgeInsets.all(AppDimension.space16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_months[currentMonth.month - 1]} ${currentMonth.year}',
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
                    onPressed: onPrevMonth,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.chevron_right,
                      color: AppColors.textPrimary,
                    ),
                    onPressed: onNextMonth,
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
              return _buildDayCell(day);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDayCell(int day) {
    final date = DateTime(currentMonth.year, currentMonth.month, day);
    final isSelected = DateFormatter.isSameDay(date, selectedDate);

    final dayMissions = myMissions
        .where(
          (m) =>
              m.userMission?.calculatedDueDate != null &&
              DateFormatter.isSameDay(m.userMission!.calculatedDueDate, date),
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
      onTap: () => onSelectDate(date),
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
}
