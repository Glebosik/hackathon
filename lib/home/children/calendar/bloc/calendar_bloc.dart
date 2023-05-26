import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:table_calendar/table_calendar.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final FirestoreRepository firestoreRepository;
  CalendarBloc({required this.firestoreRepository}) : super(CalendarInitial()) {
    on<CalendarEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<CalendarLoad>((event, emit) async {
      emit(CalendarLoading());
      try {
        final map = await firestoreRepository.getFreeSlots(event.knoId);
        // ignore: prefer_collection_literals
        LinkedHashMap<DateTime, List<FreeSlot>> events = LinkedHashMap(
          equals: isSameDay,
          hashCode: getHashCode,
        )..addAll(map);
        emit(CalendarLoaded(events));
      } catch (e) {
        emit(CalendarFailed(event.knoId));
      }
    });
  }
  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }
}
