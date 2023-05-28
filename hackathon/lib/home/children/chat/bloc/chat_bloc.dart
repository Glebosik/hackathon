import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hackathon/home/children/chat/bloc/message.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class MyChatBloc extends Bloc<MyChatEvent, MyChatState> {
  Socket? connection;
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
          connection!.write(
              '[CLIENT_TOKEN]: ${FirebaseAuth.instance.currentUser!.uid}');
          connection!.flush();
          if (messages.isEmpty) {
            connection!.listen((event) {
              add(ChatMessageReceive(event));
            });
          } else {
            connection!.listen((event) {
              add(ChatMessageReceiveNoWelcome(event));
            });
          }
          emit(ChatInitialized(messages));
        } on SocketException catch (_) {
          emit(ChatInitializationFailed(messages));
        }
      },
    );

    on<ChatReconnect>((event, emit) async {
      if (connection != null) {
        try {
          connection!.destroy();
          connection = await Socket.connect('176.119.147.26', 3777,
              timeout: const Duration(seconds: 5));
          connection!.listen((event) {
            add(ChatMessageReceiveContinue(event));
          });
          connection!.write(
              '[CLIENT_TOCKEN]: ${FirebaseAuth.instance.currentUser!.uid}');
        } on SocketException catch (_) {
          emit(ChatInitializationFailed(messages));
        }
      }
    });

    on<ChatMessageSend>(
      (event, emit) {
        if (connection != null) {
          messages.add(event.message);
          emit(ChatMessageSent(messages));
          try {
            connection!.write(event.message.text);
            connection!.flush();
            // ignore: empty_catches
          } catch (e) {}
        }
      },
    );

    on<ChatMessageReceive>(
      (event, emit) {
        final receivedText = utf8.decode(event.data);
        if (receivedText == 'Соединяю Вас с оператором') {
          messages.add(Message(
              text:
                  'Ваш вопрос недостаточно ясен, возможно, вы хотите записаться на консультацию?',
              timestamp: DateTime.now(),
              isUser: false));
          emit(ChatBotDisconnected(messages));
        } else {
          messages.add(Message(
              text: utf8.decode(event.data),
              timestamp: DateTime.now(),
              isUser: false));
          emit(ChatMessageReceived(messages));
        }
      },
    );

    on<ChatMessageReceiveNoWelcome>(
      (event, emit) {
        final receivedText = utf8.decode(event.data);
        if (receivedText == 'Соединяю Вас с оператором') {
          messages.add(Message(
              text:
                  'Ваш вопрос недостаточно ясен, возможно, вы хотите записаться на консультацию?',
              timestamp: DateTime.now(),
              isUser: false));
          emit(ChatBotDisconnected(messages));
        } else if (receivedText ==
            'Здравствуйте, я Ваш персональный робот-помощник. Какой у Вас вопрос?') {
          emit(ChatMessageReceived(messages));
        } else {
          messages.add(Message(
              text: utf8.decode(event.data),
              timestamp: DateTime.now(),
              isUser: false));
          emit(ChatMessageReceived(messages));
        }
      },
    );

    on<ChatMessageReceiveContinue>(
      (event, emit) {
        final receivedText = utf8.decode(event.data);
        if (receivedText == 'Соединяю Вас с оператором') {
          messages.add(Message(
              text:
                  'Ваш вопрос недостаточно ясен, возможно, вы хотите записаться на консультацию?',
              timestamp: DateTime.now(),
              isUser: false));
          emit(ChatBotDisconnected(messages));
        } else if (receivedText ==
            'Здравствуйте, я Ваш персональный робот-помощник. Какой у Вас вопрос?') {
          messages.add(Message(
              text: 'Попробуйте выразиться точнее и я постараюсь вам помочь.',
              timestamp: DateTime.now(),
              isUser: false));
          emit(ChatMessageReceived(messages));
        } else {
          messages.add(Message(
              text: utf8.decode(event.data),
              timestamp: DateTime.now(),
              isUser: false));
          emit(ChatMessageReceived(messages));
        }
      },
    );

    on<ChatClose>(
      (event, emit) async {
        if (connection != null) {
          try {
            connection!.destroy();
          } on Exception catch (_) {}
        }
      },
    );
  }
}
