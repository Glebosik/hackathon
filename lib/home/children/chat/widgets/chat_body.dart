import 'package:flutter/material.dart';
import 'package:hackathon/gen/colors.gen.dart';
import 'package:hackathon/home/children/chat/bloc/message.dart';
import 'package:hackathon/text_styles.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({
    super.key,
    required this.messages,
  });

  final List<Message> messages;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: messages.length,
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        itemBuilder: (context, index) {
          return Container(
            padding:
                const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
            child: Align(
              alignment: (messages[index].isUser
                  ? Alignment.topRight
                  : Alignment.topLeft),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: (messages[index].isUser
                      ? ColorName.orange
                      : ColorName.backgroundOrange),
                ),
                padding: const EdgeInsets.all(16),
                child: Text(
                  messages[index].text,
                  style: (messages[index].isUser
                      ? TextStyles.black14.copyWith(color: Colors.white)
                      : TextStyles.black14.copyWith(color: Colors.black)),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
