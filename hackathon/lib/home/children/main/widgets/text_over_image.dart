import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class TextOverImage extends StatelessWidget {
  const TextOverImage(
      {super.key, required this.image, required this.text, required this.link});

  final Image image;
  final String text;
  final String link;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        launchUrl(Uri.parse(link));
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: height * 0.180,
              height: height * 0.160,
              alignment: Alignment.center,
              child: image,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.black, Colors.transparent],
                      stops: [0.0, 0.5],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter)),
              width: height * 0.180,
              height: height * 0.160,
              alignment: Alignment.center,
            ),
          ),
          Container(
            padding: EdgeInsets.all(width * 0.02),
            width: height * 0.180,
            height: height * 0.160,
            alignment: Alignment.bottomLeft,
            child: Text(
              text,
              style: GoogleFonts.inter().copyWith(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          )
        ],
      ),
    );
  }
}
