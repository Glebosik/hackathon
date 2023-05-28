import 'package:equatable/equatable.dart';

import 'models.dart';

class ApplicationUser extends Equatable {
  final User user;
  final Application application;
  const ApplicationUser({required this.user, required this.application});

  @override
  List<Object?> get props => [user, application];
}
