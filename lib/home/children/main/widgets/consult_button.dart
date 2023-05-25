import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon/gen/colors.gen.dart';

class ConsultButton extends StatelessWidget {
  const ConsultButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: ColorName.green),
      onPressed: () {},
      child: SizedBox(
        width: width * 0.95,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 14, 0, 14),
          child: Row(children: [
            Expanded(
              child: Text(
                'Запись на консультирование',
                style: GoogleFonts.inter().copyWith(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ]),
        ),
      ),
    );
  }
}
