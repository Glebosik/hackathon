part of 'chat_bloc.dart';

abstract class MyChatEvent extends Equatable {
  const MyChatEvent();

  @override
  List<Object> get props => [];
}

class ChatInit extends MyChatEvent {}

class ChatMessageSend extends MyChatEvent {
  final Message message;
  const ChatMessageSend(this.message);
}

class ChatMessageReceive extends MyChatEvent {
  final Uint8List data;
  const ChatMessageReceive(this.data);
}

class ChatClose extends MyChatEvent {}
