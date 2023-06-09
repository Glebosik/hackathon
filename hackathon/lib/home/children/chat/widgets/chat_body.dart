import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:hackathon/gen/colors.gen.dart';
import 'package:hackathon/home/children/chat/bloc/message.dart';
import 'package:hackathon/home/children/chat/widgets/pdf_screen.dart';
import 'package:hackathon/text_styles.dart';
import 'package:hackathon/utils/route_transitions.dart';

class ChatBody extends StatelessWidget {
  ChatBody({
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
                child: Linkify(
                  onOpen: (link) {
                    Navigator.push(
                        context,
                        createRoute(PDFScreen(
                          url: link.url,
                        )));
                  },
                  text: messages[index].text,
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
