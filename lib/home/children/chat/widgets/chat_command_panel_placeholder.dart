import 'package:flutter/material.dart';
import 'package:hackathon/gen/assets.gen.dart';
import 'package:hackathon/gen/colors.gen.dart';
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
              iconSize: width * 0.13,
              splashRadius: 20,
              onPressed: null,
              icon: Assets.icons.chatActions.svg(
                  height: width * 0.13,
                  colorFilter: const ColorFilter.linearToSrgbGamma()),
            ),
            SizedBox(
              width: width * 0.6,
              child: IgnorePointer(
                child: TextField(
                  textCapitalization: TextCapitalization.sentences,
                  readOnly: true,
                  controller: null,
                  decoration: InputDecoration(
                    fillColor: ColorName.backgroundOtherOrange,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelStyle: TextStyles.black14.copyWith(color: Colors.grey),
                    labelText: textFieldLabel,
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(width * 0.05,
                        height * 0.015, width * 0.05, height * 0.015),
                  ),
                ),
              ),
            ),
            IconButton(
              iconSize: width * 0.13,
              splashRadius: 20,
              onPressed: null,
              icon: Assets.icons.recordMessage.svg(
                  height: width * 0.13,
                  colorFilter: const ColorFilter.linearToSrgbGamma()),
            ),
          ],
        ),
      ),
    );
  }
}
