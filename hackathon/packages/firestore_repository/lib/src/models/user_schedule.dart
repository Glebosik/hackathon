import 'package:equatable/equatable.dart';

import 'user.dart';

class UserSchedule extends Equatable {
  const UserSchedule({
    this.kno,
    this.inspectionType,
    this.inspectionTopic,
    this.dateStart,
    this.dateEnd,
    this.inspector,
  });

  final String? kno;
  final String? inspectionType;
  final String? inspectionTopic;
  final String? dateStart;
  final String? dateEnd;
  final User? inspector;

  @override
  List<Object?> get props =>
      [kno, inspectionType, inspectionTopic, dateStart, dateEnd, inspector];
}
