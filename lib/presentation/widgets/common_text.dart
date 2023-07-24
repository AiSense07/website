import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Texts {
  static commonText({
    required Size size,
    required String text,
    FontWeight? fontWeight,
    int? maxLine,
    Color? color,
  }) =>
      Text(
        text,
        maxLines: maxLine,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.poppins(
          color: color,
          fontWeight: fontWeight,
          fontSize: size.width > 615 ? 15 : 15,
          letterSpacing: 0.7,
        ),
      );

  static small13Text({
    required Size size,
    required String text,
    FontWeight? fontWeight,
    int? maxLine,
    Color? color,
  }) =>
      Text(
        text,
        maxLines: maxLine,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.poppins(
          color: color,
          fontWeight: fontWeight,
          fontSize: 13,
          letterSpacing: 0.7,
        ),
      );

  static headingText({
    required String text,
    FontWeight? fontWeight,
    int? maxLine,
    Color? color,
  }) =>
      Text(
        text,
        maxLines: maxLine,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.poppins(
          color: color,
          fontWeight: fontWeight,
          fontSize: 18,
          letterSpacing: 0.7,
        ),
      );

  static big24Text({
    required String text,
    FontWeight? fontWeight,
    int? maxLine,
    Color? color,
  }) =>
      Text(
        text,
        maxLines: maxLine,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.poppins(
          color: color,
          height: 1,
          fontWeight: fontWeight,
          fontSize: 24,
          letterSpacing: 0.7,
        ),
      );
}
