import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hackathon/gen/colors.gen.dart';
import 'package:hackathon/home/children/chat/bloc/message.dart';
import 'package:hackathon/text_styles.dart';

class ChatBodyWaiting extends StatelessWidget {
  ChatBodyWaiting({
    super.key,
    required this.messages,
  });

  final List<Message> messages;
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.jumpTo(controller.position.maxScrollExtent);
    });
    return Expanded(
      child: ListView.builder(
        controller: controller,
        itemCount: messages.length + 1,
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        itemBuilder: (context, index) {
          if (index != messages.length) {
            return Container(
              padding: const EdgeInsets.only(
                  left: 14, right: 14, top: 10, bottom: 10),
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
                  child: Linkify(
                    text: messages[index].text,
                    style: (messages[index].isUser
                        ? TextStyles.black14.copyWith(color: Colors.white)
                        : TextStyles.black14.copyWith(color: Colors.black)),
                  ),
                ),
              ),
            );
          } else {
            return Container(
              padding: const EdgeInsets.only(
                  left: 14, right: 14, top: 10, bottom: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: ColorName.backgroundOrange),
                    padding: const EdgeInsets.all(16),
                    child: const SizedBox(
                      width: 32,
                      child: SpinKitThreeBounce(
                        size: 16,
                        color: ColorName.orange,
                      ),
                    )),
              ),
            );
          }
        },
      ),
    );
  }
}
