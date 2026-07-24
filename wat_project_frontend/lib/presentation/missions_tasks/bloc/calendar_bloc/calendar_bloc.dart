

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';


class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc({required DateTime initialMonth})
    : super(
        CalendarState(
          focusedMonth: DateTime(initialMonth.year, initialMonth.month, 1),
          selectedDate: DateTime.now(),
        ),
      ) {
    on<PreviousMonthRequested>(_onPreviousMonthRequested);
    on<NextMonthRequested>(_onNextMonthRequested);
    on<DateSelected>(_onDateSelected);
  }

  void _onPreviousMonthRequested(
    PreviousMonthRequested event,
    Emitter<CalendarState> emit,
  ) {
    final prevMonth = DateTime(
      state.focusedMonth.year,
      state.focusedMonth.month - 1,
      1,
    );
    emit(state.copyWith(focusedMonth: prevMonth, clearSelectedDate: true));
  }

  void _onNextMonthRequested(
    NextMonthRequested event,
    Emitter<CalendarState> emit,
  ) {
    final nextMonth = DateTime(
      state.focusedMonth.year,
      state.focusedMonth.month + 1,
      1,
    );
    emit(state.copyWith(focusedMonth: nextMonth, clearSelectedDate: true));
  }

  void _onDateSelected(DateSelected event, Emitter<CalendarState> emit) {
    emit(state.copyWith(selectedDate: event.date));
  }
}