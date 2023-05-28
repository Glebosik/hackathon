import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon/gen/assets.gen.dart';
import 'package:hackathon/gen/colors.gen.dart';

//TODO: ДОРАБОТАТЬ
class ServiceCard extends StatelessWidget {
  const ServiceCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.leading,
  });

  final SvgGenImage leading;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Card(
        color: ColorName.backgroundOrange,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: EdgeInsets.fromLTRB(width * 0.02, 20, width * 0.02, 20),
          child: Row(
            children: [
              leading.svg(width: width * 0.2),
              SizedBox(width: width * 0.05),
              SizedBox(
                width: width * 0.65,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter()
                          .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: height * 0.01),
                    Flexible(
                      child: AutoSizeText(
                        subtitle,
                        minFontSize: 12,
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.inter()
                            .copyWith(fontSize: 14, color: Colors.black54),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
