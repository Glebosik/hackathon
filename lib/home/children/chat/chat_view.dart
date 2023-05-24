import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late Socket _socket;
  String _message = "Waiting for server";

  @override
  void initState() {
    _startConnection();
    super.initState();
  }

  void _startConnection() async {
    try {
      _socket = await Socket.connect('176.119.147.26', 3777);
      _socket.listen((event) {
        print(utf8.decode(event));
        messageReceived(utf8.decode(event));
      });
    } on SocketException catch (e) {
      print('Socket failed to connect');
      print('Exception: ${e.message}');
    }
  }

  void messageReceived(String msg) {
    setState(() {
      _message = msg;
    });
  }

  @override
  void dispose() {
    super.dispose();
    try {
      _socket.close();
    } catch (e) {
      print('Failed to close socket');
    }
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    return StreamBuilder<Object>(
        stream: null,
        builder: (context, snapshot) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_message),
              ElevatedButton(
                  onPressed: () {
                    print(uid);
                    try {
                      _socket.add(utf8.encode('[CLIENT_TOKEN]: $uid'));
                    } catch (e) {
                      print('Socket not connected');
                    }
                  },
                  child: const Text('Hello'))
            ],
          ));
        });
  }
}
