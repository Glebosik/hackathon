import 'package:equatable/equatable.dart';

class Kno extends Equatable {
  const Kno(this.id, this.name, this.inspectors, this.inspectionTypes);

  final String id;
  final String name;
  final List<String> inspectors;
  final Map<String, List<String>> inspectionTypes;

  @override
  List<Object?> get props => [name, inspectors, inspectionTypes];
}
