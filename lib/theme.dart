import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon/gen/colors.gen.dart';

var borderWithoutBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide(
      width: 0,
      color: ColorName.backgroundOrange,
    ));

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
    isDense: true,
    floatingLabelStyle: const TextStyle(color: Colors.black87),
    filled: true,
    fillColor: ColorName.backgroundOrange,
    focusColor: ColorName.orange,
    enabledBorder: borderWithoutBorder,
    disabledBorder: borderWithoutBorder,
    focusedBorder: borderWithoutBorder,
    border: borderWithoutBorder,
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
