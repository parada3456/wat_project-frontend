

part of 'calendar_bloc.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object?> get props => [];
}

class PreviousMonthRequested extends CalendarEvent {
  const PreviousMonthRequested();
}

class NextMonthRequested extends CalendarEvent {
  const NextMonthRequested();
}

class DateSelected extends CalendarEvent {
  final DateTime date;
  const DateSelected(this.date);

  @override
  List<Object?> get props => [date];
}