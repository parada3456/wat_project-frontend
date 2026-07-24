import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/core/widgets/pixel_border_container.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/bloc/calendar_bloc/calendar_bloc.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

class MissionCalendar extends StatelessWidget {
  final List<MissionModel> missions;

  const MissionCalendar({super.key, required this.missions});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      builder: (context, state) {
        final year = state.focusedMonth.year;
        final month = state.focusedMonth.month;
        final daysInMonth = DateUtils.getDaysInMonth(year, month);
        final firstDayOffset = DateTime(year, month, 1).weekday % 7;
        final totalSlots = daysInMonth + firstDayOffset;

        final weekDays = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];

        return Container(
          padding: const EdgeInsets.all(AppDimension.space16),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Calendar Month Selector Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('MMMM yyyy').format(state.focusedMonth),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left),
                        onPressed: () {
                          context.read<CalendarBloc>().add(
                            const PreviousMonthRequested(),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.chevron_right),
                        onPressed: () {
                          context.read<CalendarBloc>().add(
                            const NextMonthRequested(),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: AppDimension.space16),

              // Weekdays Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: weekDays.map((day) {
                  return SizedBox(
                    width: 32,
                    child: Center(
                      child: Text(
                        day,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: AppDimension.space8),

              // Days Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: totalSlots,
                itemBuilder: (context, index) {
                  if (index < firstDayOffset) {
                    return const SizedBox.shrink();
                  }

                  final day = index + 1 - firstDayOffset;
                  final isDeadline = missions.any(
                    (m) =>
                        m.userMission?.calculatedDueDate != null &&
                        m.userMission!.calculatedDueDate!.day == day &&
                        m.userMission!.calculatedDueDate!.month == month &&
                        m.userMission!.calculatedDueDate!.year == year,
                  );

                  final isSelected =
                      state.selectedDate != null &&
                      state.selectedDate!.day == day &&
                      state.selectedDate!.month == month &&
                      state.selectedDate!.year == year;

                  return GestureDetector(
                    onTap: () {
                      final selectedDate = DateTime(year, month, day);
                      context.read<CalendarBloc>().add(
                        DateSelected(selectedDate),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary
                            : (isDeadline
                                  ? AppColors.primary.withOpacity(0.1)
                                  : Colors.transparent),
                        shape: BoxShape.circle,
                        border: isSelected
                            ? Border.all(color: AppColors.primary)
                            : (isDeadline
                                  ? Border.all(color: AppColors.primary)
                                  : null),
                      ),
                      child: Center(
                        child: Text(
                          '$day',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: (isSelected || isDeadline)
                                ? FontWeight.w700
                                : FontWeight.w400,
                            color: isSelected
                                ? Colors.white
                                : (isDeadline
                                      ? AppColors.primary
                                      : AppColors.textPrimary),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
