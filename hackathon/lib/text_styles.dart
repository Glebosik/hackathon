import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class TextStyles {
  TextStyles._();
  static TextStyle white18 =
      GoogleFonts.inter().copyWith(color: Colors.white, fontSize: 18);

  static TextStyle black18 =
      GoogleFonts.inter().copyWith(color: Colors.black, fontSize: 18);

  static TextStyle black18bold = GoogleFonts.inter()
      .copyWith(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold);

  static TextStyle white18bold = GoogleFonts.inter()
      .copyWith(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);

  static TextStyle white16 =
      GoogleFonts.inter().copyWith(color: Colors.white, fontSize: 16);

  static TextStyle black16 =
      GoogleFonts.inter().copyWith(color: Colors.black, fontSize: 16);

  static TextStyle black16bold = GoogleFonts.inter()
      .copyWith(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold);

  static TextStyle white16bold = GoogleFonts.inter()
      .copyWith(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold);

  static TextStyle white14 =
      GoogleFonts.inter().copyWith(color: Colors.white, fontSize: 14);

  static TextStyle black14 =
      GoogleFonts.inter().copyWith(color: Colors.black, fontSize: 14);

  static TextStyle black14bold = GoogleFonts.inter()
      .copyWith(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold);

  static TextStyle white14bold = GoogleFonts.inter()
      .copyWith(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold);

  static TextStyle white12 =
      GoogleFonts.inter().copyWith(color: Colors.white, fontSize: 12);

  static TextStyle black12 =
      GoogleFonts.inter().copyWith(color: Colors.black, fontSize: 12);

  static TextStyle black12bold = GoogleFonts.inter()
      .copyWith(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold);

  static TextStyle white12bold = GoogleFonts.inter()
      .copyWith(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold);

  static TextStyle white10 =
      GoogleFonts.inter().copyWith(color: Colors.white, fontSize: 10);

  static TextStyle black10 =
      GoogleFonts.inter().copyWith(color: Colors.black, fontSize: 10);

  static TextStyle black10bold = GoogleFonts.inter()
      .copyWith(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold);

  static TextStyle white10bold = GoogleFonts.inter()
      .copyWith(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold);
}
