import 'package:intl/intl.dart';

class FreeSlot {
  final DateTime start;
  final DateTime end;

  const FreeSlot(this.start, this.end);

  @override
  String toString() {
    return "${DateFormat.MMMMd('ru_RU').format(start)} ${DateFormat.jm('ru').format(start)}";
  }

  String toDayMonth() {
    return "${DateFormat.MMMMd('ru_RU').format(start)}";
  }

  String toStartTime() {
    return "${DateFormat.jm('ru').format(start)}";
  }

  String toInterval() {
    return "${DateFormat.jm('ru').format(start)}-${DateFormat.jm('ru').format(end)}";
  }

  String remainginTime() {
    return "${start.difference(DateTime.now()).inDays} дн. ${start.difference(DateTime.now()).inHours % 24} ч. ${start.difference(DateTime.now()).inMinutes % 60} мин.";
  }
}
