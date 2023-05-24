import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon/gen/colors.gen.dart';

class ConsultButton extends StatelessWidget {
  const ConsultButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: ColorName.green),
      onPressed: () {},
      child: ListTile(
          title: Text(
            'Запись на консультирование',
            style: GoogleFonts.inter().copyWith(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          )),
    );
  }
}
