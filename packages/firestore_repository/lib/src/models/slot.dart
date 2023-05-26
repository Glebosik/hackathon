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

  String toInterval() {
    return "${DateFormat.jm('ru').format(start)}-${DateFormat.jm('ru').format(end)}";
  }
}
