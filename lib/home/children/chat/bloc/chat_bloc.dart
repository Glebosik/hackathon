import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hackathon/home/children/chat/bloc/message.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class MyChatBloc extends Bloc<MyChatEvent, MyChatState> {
  late Socket connection;
  List<Message> messages = [];

  MyChatBloc() : super(const ChatInitial([])) {
    on<MyChatEvent>(
      (event, emit) {},
    );

    on<ChatInit>(
      (event, emit) async {
        emit(ChatInitial(messages));
        try {
          connection = await Socket.connect('176.119.147.26', 3777,
              timeout: const Duration(seconds: 5));
          connection.listen((event) {
            add(ChatMessageReceive(event));
          });
          emit(ChatInitialized(messages));
        } on SocketException catch (e) {
          emit(ChatInitializationFailed(messages));
          print('Socket failed to connect');
          print('Exception: ${e.message}');
        }
      },
    );

    on<ChatMessageSend>(
      (event, emit) {
        messages.add(event.message);
        emit(ChatMessageSent(messages));
        try {
          connection.write(event.message.text);
        } catch (e) {
          print('ChatMessageSendFailed: $e');
        }
      },
    );

    on<ChatMessageReceive>(
      (event, emit) {
        messages.add(Message(
            text: utf8.decode(event.data),
            timestamp: DateTime.now(),
            isUser: false));
        emit(ChatMessageReceived(messages));
      },
    );

    on<ChatClose>(
      (event, emit) {
        try {
          connection.close();
        } on SocketException catch (e) {
          print('Socket failed to close');
          print('Exception: ${e.message}');
        }
      },
    );
  }
}
