part of 'home_navigation_bloc.dart';

abstract class HomeNavigationEvent extends Equatable {
  const HomeNavigationEvent();

  @override
  List<Object> get props => [];
}

class PageTapped extends HomeNavigationEvent {
  final int index;

  const PageTapped(this.index);
  @override
  List<Object> get props => [index];
}

class UpdateApplications extends HomeNavigationEvent {}
