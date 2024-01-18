import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

///Color
const Color primaryColor = Color(0xff477680);
const Color primaryLightColor = Color.fromARGB(255, 176, 224, 234);
const Color primaryDarkColor = Color(0xff321911);
const Color ratingColor = Color(0xffffc207);
const Color unratedColor = Color(0xffA9A9A9);
const Color favorite = Colors.redAccent;

///Typography
final TextTheme textTheme = TextTheme(
  titleLarge: GoogleFonts.montserrat(
      fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  titleMedium: GoogleFonts.montserrat(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  titleSmall: GoogleFonts.montserrat(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
);

const TextStyle textPrimary = TextStyle(color: primaryColor);
const TextStyle textWhite = TextStyle(color: Colors.white);
const TextStyle textBlack = TextStyle(color: Color(0xff3A3E3E));
TextStyle textGrey = TextStyle(color: Colors.grey[600]);
