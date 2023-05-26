part of 'calendar_bloc.dart';

abstract class CalendarState extends Equatable {
  const CalendarState();

  @override
  List<Object> get props => [];
}

class CalendarInitial extends CalendarState {}

class CalendarLoading extends CalendarState {}

class CalendarLoaded extends CalendarState {
  final LinkedHashMap<DateTime, List<FreeSlot>> events;

  const CalendarLoaded(this.events);
  @override
  List<Object> get props => [events];
}

class CalendarFailed extends CalendarState {
  final String knoId;
  const CalendarFailed(this.knoId);
  @override
  List<Object> get props => [knoId];
}
