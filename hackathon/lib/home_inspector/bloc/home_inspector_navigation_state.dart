part of 'home_inspector_navigation_bloc.dart';

abstract class HomeInspectorNavigationState extends Equatable {
  const HomeInspectorNavigationState();

  @override
  List<Object> get props => [];
}

class HomeNavigationInitial extends HomeInspectorNavigationState {}

class ApplicationPageLoading extends HomeInspectorNavigationState {}

class ApplicationPageLoaded extends HomeInspectorNavigationState {
  final List<ApplicationUser> applications;
  const ApplicationPageLoaded(this.applications);
  @override
  List<Object> get props => [applications];
}

class ApplicationPageFailed extends HomeInspectorNavigationState {}

class ApprovedPageLoading extends HomeInspectorNavigationState {}

class ApprovedPageLoaded extends HomeInspectorNavigationState {
  final List<ApplicationUser> applications;
  const ApprovedPageLoaded(this.applications);
  @override
  List<Object> get props => [applications];
}

class ApprovedPageFailed extends HomeInspectorNavigationState {}
