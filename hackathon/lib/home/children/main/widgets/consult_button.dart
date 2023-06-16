import 'package:flutter/material.dart';
import 'package:hackathon/gen/colors.gen.dart';
import 'package:hackathon/home/children/check_in/check_in_view.dart';
import 'package:hackathon/text_styles.dart';
import 'package:hackathon/utils/route_transitions.dart';

class ConsultButton extends StatelessWidget {
  const ConsultButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            ColorName.green,
            ColorName.greenLight,
          ]),
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent),
        onPressed: () {
          Navigator.of(context).push(createRoute(const CheckInView()));
        },
        child: SizedBox(
          width: width * 0.95,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 0, 14),
            child: Row(children: [
              Expanded(
                child: Text(
                  'Запись на консультирование',
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
