part of 'calendar_bloc.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object> get props => [];
}

class CalendarLoad extends CalendarEvent {
  final String knoId;
  const CalendarLoad(this.knoId);
  @override
  List<Object> get props => [knoId];
}
