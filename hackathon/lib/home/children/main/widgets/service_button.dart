import 'package:flutter/material.dart';
import 'package:hackathon/gen/assets.gen.dart';
import 'package:hackathon/gen/colors.gen.dart';
import 'package:hackathon/text_styles.dart';

class ServiceButton extends StatelessWidget {
  const ServiceButton({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorName.backgroundOtherOrange,
              ColorName.hyperlinkOrange,
            ],
            stops: [0, 0.25],
          ),
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent),
        onPressed: () {},
        child: SizedBox(
          width: width * 0.95,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
            child: Row(children: [
              Assets.icons.mosruCircleLogo.svg(),
              SizedBox(width: width * 0.05),
              Expanded(
                child: Text(
                  text,
                  style:
                      TextStyles.white14.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
