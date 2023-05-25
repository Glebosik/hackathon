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

class ConsultPageLoaded extends HomeNavigationState {}

class ProfilePageLoading extends HomeNavigationState {}

class ProfilePageLoaded extends HomeNavigationState {
  final User user;
  const ProfilePageLoaded(this.user);
  @override
  List<Object> get props => [user];
}

class ProfilePageFail extends HomeNavigationState {}
