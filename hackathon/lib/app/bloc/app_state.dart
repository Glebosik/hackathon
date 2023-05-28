part of 'app_bloc.dart';

enum AppStatus {
  authenticatedInspector,
  authenticatedUser,
  unauthenticated,
}

final class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.user = User.empty,
  });

  const AppState.authenticatedUser(User user)
      : this._(status: AppStatus.authenticatedUser, user: user);

  const AppState.authenticatedInspector(User user)
      : this._(status: AppStatus.authenticatedInspector, user: user);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  final AppStatus status;
  final User user;

  @override
  List<Object> get props => [status, user];
}
