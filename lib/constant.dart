import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum Status { empty, loading, success, failed }

const Color primaryColor = Color(0xfff7a027);
const Color backgroundColor = Color(0xfffaf9fb);
const Color cardColor = Colors.white;
const Color textColor = Color(0xff0f0e0e);
const Color mutedColor = Color(0xffa2a3ac);

class CustomTextTheme {
  static final heading1 = GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w600);
  static final heading2 = GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600);
  static final heading3 = GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500);
  static final heading4 = GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500);
  static final heading5 = GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500);
  static final heading6 = GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500);

  static final body1 = GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400);
  static final body2 = GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400);

  static final caption = GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w400);
  static final label = GoogleFonts.poppins(fontSize: 8, fontWeight: FontWeight.w400);
}
