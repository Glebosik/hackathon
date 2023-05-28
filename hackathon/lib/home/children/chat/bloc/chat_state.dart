part of 'chat_bloc.dart';

abstract class MyChatState extends Equatable {
  const MyChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends MyChatState {
  final List<Message> messages;
  const ChatInitial(this.messages);
}

class ChatInitialized extends MyChatState {
  final List<Message> messages;
  const ChatInitialized(this.messages);
}

class ChatInitializationFailed extends MyChatState {
  final List<Message> messages;
  const ChatInitializationFailed(this.messages);
}

class ChatMessageReceived extends MyChatState {
  final List<Message> messages;
  const ChatMessageReceived(this.messages);
}

class ChatMessageSent extends MyChatState {
  final List<Message> messages;
  const ChatMessageSent(this.messages);
}

class ChatBotDisconnected extends MyChatState {
  final List<Message> messages;
  const ChatBotDisconnected(this.messages);
}
