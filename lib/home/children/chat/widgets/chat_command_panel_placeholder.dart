import 'package:flutter/material.dart';
import 'package:hackathon/gen/assets.gen.dart';
import 'package:hackathon/text_styles.dart';

class ChatCommandPanelPlaceholder extends StatelessWidget {
  const ChatCommandPanelPlaceholder({super.key, required this.textFieldLabel});

  final String textFieldLabel;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      child: Card(
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              splashRadius: 20,
              onPressed: null,
              icon: Assets.icons.chatActions.svg(),
            ),
            SizedBox(
              width: width * 0.7,
              child: IgnorePointer(
                child: TextField(
                  textCapitalization: TextCapitalization.sentences,
                  readOnly: true,
                  controller: null,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelStyle: TextStyles.black14.copyWith(color: Colors.grey),
                    labelText: textFieldLabel,
                    contentPadding: EdgeInsets.fromLTRB(width * 0.05,
                        height * 0.02, width * 0.05, height * 0.02),
                  ),
                ),
              ),
            ),
            IconButton(
              splashRadius: 20,
              onPressed: null,
              icon: Assets.icons.recordMessage.svg(),
            ),
          ],
        ),
      ),
    );
  }
}
