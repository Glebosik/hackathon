part of 'check_in_bloc.dart';

abstract class CheckInState extends Equatable {
  const CheckInState();

  @override
  List<Object> get props => [];
}

class CheckInInitial extends CheckInState {}

class CheckKnoLoading extends CheckInState {}

class CheckInKnoLoaded extends CheckInState {
  const CheckInKnoLoaded(this.knos);
  final List<Kno> knos;
  @override
  List<Object> get props => [knos];
}

class CheckKnoLoadingFail extends CheckInState {}
