import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon/gen/colors.gen.dart';

final theme = ThemeData(
  textTheme: GoogleFonts.interTextTheme(),
  primaryColor: ColorName.orange,
  colorScheme: const ColorScheme.light(
    primary: ColorName.orange,
    background: ColorName.backgroundOrange,
    secondary: Colors.black,
  ),
  scaffoldBackgroundColor: ColorName.white,
  inputDecorationTheme: InputDecorationTheme(
    focusColor: ColorName.orange,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  appBarTheme: AppBarTheme(
    titleTextStyle: GoogleFonts.inter().copyWith(
        fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
    foregroundColor: Colors.black,
    backgroundColor: ColorName.white,
    elevation: 0,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(ColorName.orange),
      shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      overlayColor: MaterialStateProperty.all(ColorName.backgroundOrange),
      foregroundColor: MaterialStateProperty.all<Color>(ColorName.orange),
      shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
    ),
  ),
);
