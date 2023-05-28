part of 'home_inspector_navigation_bloc.dart';

abstract class HomeInspectorNavigationEvent extends Equatable {
  const HomeInspectorNavigationEvent();

  @override
  List<Object> get props => [];
}

class PageTapped extends HomeInspectorNavigationEvent {
  final int index;

  const PageTapped(this.index);
  @override
  List<Object> get props => [index];
}

class UpdateApplications extends HomeInspectorNavigationEvent {}

class UpdateApproved extends HomeInspectorNavigationEvent {}

class UpdateApprovedAndGoToScreen extends HomeInspectorNavigationEvent {}
