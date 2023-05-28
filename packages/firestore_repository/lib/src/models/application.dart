import 'package:equatable/equatable.dart';

class Application extends Equatable {
  const Application({
    required this.dateStart,
    required this.dateEnd,
    required this.inspectionTopic,
    required this.inspectionType,
    required this.inspectorId,
    required this.knoId,
    required this.knoName,
    required this.status,
    required this.applicantId,
  });

  final DateTime dateStart;
  final DateTime dateEnd;
  final String inspectionType;
  final String inspectionTopic;
  final String inspectorId;
  final String knoId;
  final String knoName;
  final String status;
  final String applicantId;

  factory Application.fromFirestore(Map data) {
    return Application(
      applicantId: data['applicantId'],
      dateStart: data['dateStart'].toDate(),
      dateEnd: data['dateEnd'].toDate(),
      inspectionType: data['inspectionType'],
      inspectionTopic: data['inspectionTopic'],
      inspectorId: data['inspectorId'],
      knoId: data['kno'],
      knoName: data['knoName'],
      status: data['status'],
    );
  }

  factory Application.fromFirestoreInspector(Map data, String status) {
    return Application(
      applicantId: data['applicantId'],
      dateStart: data['dateStart'].toDate(),
      dateEnd: data['dateEnd'].toDate(),
      inspectionType: data['inspectionType'],
      inspectionTopic: data['inspectionTopic'],
      inspectorId: data['inspectorId'],
      knoId: data['kno'],
      knoName: data['knoName'],
      status: status,
    );
  }

  @override
  List<Object?> get props => [
        dateStart,
        dateEnd,
        inspectionTopic,
        inspectionType,
        inspectorId,
        knoId,
        knoName,
        status,
        applicantId,
      ];
}
