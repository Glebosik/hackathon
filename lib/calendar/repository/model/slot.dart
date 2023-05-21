import 'package:intl/intl.dart';

class Slot {
  final DateTime start;
  final DateTime end;

  const Slot(this.start, this.end);

  @override
  String toString() {
    return "${DateFormat.MMMMd('ru_RU').format(start)} ${DateFormat.jm('ru').format(start)}";
  }
}
