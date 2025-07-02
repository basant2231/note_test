import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle headline({Color? color, double? fontSize}) =>
      GoogleFonts.montserrat(
        fontWeight: FontWeight.bold,
        color: color ?? AppColors.primary,
        fontSize: fontSize ?? 24,
      );

  static TextStyle body({Color? color, double? fontSize}) =>
      GoogleFonts.montserrat(
        fontWeight: FontWeight.w400,
        color: color ?? AppColors.text,
        fontSize: fontSize ?? 16,
      );

  static TextStyle subtitle({Color? color, double? fontSize}) =>
      GoogleFonts.montserrat(
        fontWeight: FontWeight.w500,
        color: color ?? AppColors.subtitle,
        fontSize: fontSize ?? 14,
      );
}
