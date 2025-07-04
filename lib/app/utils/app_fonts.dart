import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class AppFonts {
  static TextStyle regular({Color? color, double? fontSize}) =>
      GoogleFonts.montserrat(
        fontWeight: FontWeight.w400,
        color: color,
        fontSize: fontSize,
      );

  static TextStyle medium({Color? color, double? fontSize}) =>
      GoogleFonts.montserrat(
        fontWeight: FontWeight.w500,
        color: color,
        fontSize: fontSize,
      );

  static TextStyle bold({Color? color, double? fontSize}) =>
      GoogleFonts.montserrat(
        fontWeight: FontWeight.bold,
        color: color,
        fontSize: fontSize,
      );

  static TextStyle semiBold({Color? color, double? fontSize}) =>
      GoogleFonts.montserrat(
        fontWeight: FontWeight.w600,
        color: color,
        fontSize: fontSize,
      );
}
