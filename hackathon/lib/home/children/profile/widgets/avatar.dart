import 'package:flutter/material.dart';
import 'package:hackathon/gen/colors.gen.dart';
import 'package:hackathon/text_styles.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key, required this.secondName, this.avatarSize = 24.0});

  final String secondName;
  final double? avatarSize;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: avatarSize,
      backgroundColor: ColorName.orange,
      child: secondName.isNotEmpty
          ? Text(
              secondName[0],
              style: TextStyles.white18bold
                  .copyWith(fontSize: avatarSize ?? 24 * 0.5),
            )
          : Icon(Icons.person_outline, size: avatarSize),
    );
  }
}
