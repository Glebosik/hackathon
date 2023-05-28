part of 'check_in_bloc.dart';

abstract class CheckInEvent extends Equatable {
  const CheckInEvent();

  @override
  List<Object> get props => [];
}

class CheckInFetchKno extends CheckInEvent {}

class CheckInSelectKno extends CheckInEvent {
  const CheckInSelectKno(this.kno);
  final String kno;
  @override
  List<Object> get props => [kno];
}

class CheckInSelectType extends CheckInEvent {
  const CheckInSelectType(this.type);
  final String type;
  @override
  List<Object> get props => [type];
}

class CheckInSelectTopic extends CheckInEvent {
  const CheckInSelectTopic(this.topic);
  final String topic;
  @override
  List<Object> get props => [topic];
}
