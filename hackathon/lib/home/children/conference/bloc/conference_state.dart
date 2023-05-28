part of 'conference_bloc.dart';

abstract class ConferenceState extends Equatable {
  const ConferenceState();

  @override
  List<Object> get props => [];
}

class ConferenceInitial extends ConferenceState {}

class ConferenceLoading extends ConferenceState {}

class ConferenceReady extends ConferenceState {
  const ConferenceReady(this.token, this.channel, this.appId);

  final String token;
  final String channel;
  final String appId;

  @override
  List<Object> get props => [token, channel, appId];
}

class ConferenceFail extends ConferenceState {}
