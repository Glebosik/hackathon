part of 'conference_bloc.dart';

abstract class ConferenceEvent extends Equatable {
  const ConferenceEvent();

  @override
  List<Object> get props => [];
}

class ConferenceStart extends ConferenceEvent {}
