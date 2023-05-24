import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatViewSocketIO extends StatefulWidget {
  const ChatViewSocketIO({super.key});

  @override
  State<ChatViewSocketIO> createState() => _ChatViewSocketIOState();
}

class _ChatViewSocketIOState extends State<ChatViewSocketIO> {
  late IO.Socket socket;
  late StreamSocket streamSocket;

  @override
  void initState() {
    streamSocket = StreamSocket();
    connectAndListen();
    super.initState();
  }

  void connectAndListen() {
    socket = IO.io('http://176.119.147.26:3777',
        OptionBuilder().setTransports(['websocket']).build());

    socket.onConnecting((data) {
      print('Connecting: $data');
    });

    socket.onConnectError((data) {
      print('Connection error: $data');
    });

    socket.onConnectTimeout((data) {
      print('Timeout: $data');
    });

    socket.onConnect((data) {
      print('Connected: $data');
      socket.emit('msg', 'test');
    });

    //When an event recieved from server, data is added to the stream
    socket.on('event', (data) => streamSocket.addResponse);
    socket.onDisconnect((_) => print('disconnect'));
  }

  @override
  void dispose() {
    super.dispose();
    socket.dispose();
    streamSocket.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StreamBuilder(
          stream: streamSocket.getResponse,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return Text(snapshot.data ?? 'No Data');
          },
        ),
        ElevatedButton(
            onPressed: () {
              print(uid);
              socket.emit('msg', '[CLIENT_TOKEN]: $uid');
            },
            child: const Text('Hello'))
      ],
    );
  }
}

class StreamSocket {
  final _socketResponse = StreamController<String>();

  void Function(String) get addResponse => _socketResponse.sink.add;

  Stream<String> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}
