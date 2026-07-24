part of 'calendar_bloc.dart';


class CalendarState extends Equatable {
  final DateTime focusedMonth;
  final DateTime? selectedDate;

  const CalendarState({required this.focusedMonth, this.selectedDate});

  CalendarState copyWith({
    DateTime? focusedMonth,
    DateTime? selectedDate,
    bool clearSelectedDate = false,
  }) {
    return CalendarState(
      focusedMonth: focusedMonth ?? this.focusedMonth,
      selectedDate: clearSelectedDate
          ? null
          : (selectedDate ?? this.selectedDate),
    );
  }

  @override
  List<Object?> get props => [focusedMonth, selectedDate];
}
