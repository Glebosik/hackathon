import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon/gen/assets.gen.dart';
import 'package:hackathon/gen/colors.gen.dart';

class ServiceCard extends StatelessWidget {
  ServiceCard({
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
          padding: EdgeInsets.all(width * 0.02),
          child: Row(
            children: [
              leading.svg(width: width * 0.2),
              SizedBox(width: width * 0.05),
              SizedBox(
                width: width * 0.50,
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
                      child: Text(
                        subtitle,
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
