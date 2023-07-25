import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:three_connects/utils/app_color.dart';

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
          color: color ?? AppColor.primary,
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
    double? fontSize,
    double? height,
    Color? color,
  }) =>
      Text(
        text,
        maxLines: maxLine,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontFamily: "oxy",
          color: color ?? AppColor.primary,
          fontWeight: fontWeight,
          fontSize: fontSize ?? 13,
          height: height,
        ),
      );

  static headingText({
    required String text,
    double? fontSize,
    String? fontFamily,
    FontWeight? fontWeight,
    int? maxLine,
    Color? color,
  }) =>
      Text(
        text,
        maxLines: maxLine,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontFamily: fontFamily ?? "pts",
          color: color ?? AppColor.primary,
          fontWeight: fontWeight,
          fontSize: fontSize ?? 18,
          height: 1.1,
        ),
      );

  static big26Text({
    required String text,
    String? fontFamily,
    FontWeight? fontWeight,
    int? maxLine,
    Color? color,
  }) =>
      Text(
        text,
        maxLines: maxLine,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontFamily: fontFamily ?? "pts",
          color: color ?? AppColor.primary,
          height: 1,
          fontWeight: fontWeight,
          fontSize: 26,
        ),
      );
}
