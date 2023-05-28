import 'package:equatable/equatable.dart';

class Message extends Equatable {
  const Message(
      {required this.text, required this.timestamp, required this.isUser});
  final String text;
  final DateTime timestamp;
  final bool isUser;

  @override
  List<Object?> get props => [text, timestamp, isUser];
}
