part of 'home_navigation_bloc.dart';

abstract class HomeNavigationState extends Equatable {
  const HomeNavigationState();

  @override
  List<Object> get props => [];
}

class HomeNavigationInitial extends HomeNavigationState {}

class MainPageLoading extends HomeNavigationState {}

class MainPageLoaded extends HomeNavigationState {}

class ChatPageLoading extends HomeNavigationState {}

class ChatPageLoaded extends HomeNavigationState {}

class ConsultPageLoading extends HomeNavigationState {}

class ConsultPageLoaded extends HomeNavigationState {
  final List<Application> applications;
  const ConsultPageLoaded(this.applications);
  @override
  List<Object> get props => [applications];
}

class ConsultPageFailed extends HomeNavigationState {}

class ProfilePageLoading extends HomeNavigationState {}

class ProfilePageLoaded extends HomeNavigationState {
  final User user;
  const ProfilePageLoaded(this.user);
  @override
  List<Object> get props => [user];
}

class ProfilePageFailed extends HomeNavigationState {}
