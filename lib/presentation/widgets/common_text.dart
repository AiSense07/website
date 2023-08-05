import 'package:flutter/material.dart';

import 'package:three_connects/utils/app_color.dart';

class Texts {
  static normal({
    required Size size,
    required String text,
    FontWeight? fontWeight,
    String? fontFamily,
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
          fontFamily: fontFamily ?? "pop",
          color: color ?? Colors.black,
          fontWeight: fontWeight,
          fontSize: fontSize ?? 14,
          height: height,
        ),
      );

  static small13Text({
    required Size size,
    required String text,
    String? fontFamily,
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
          fontFamily: fontFamily ?? "pop",
          color: color ?? Colors.black,
          fontWeight: fontWeight,
          fontSize: fontSize ?? 13,
          height: height,
        ),
      );

  static headingText({
    required String text,
    double? fontSize,
    double? height,
    String? fontFamily,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    int? maxLine,
    Color? color,
  }) =>
      Text(
        text,
        maxLines: maxLine,
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign,
        style: TextStyle(
          fontFamily: fontFamily ?? "pop",
          color: color ?? Colors.black,
          fontWeight: fontWeight,
          fontSize: fontSize ?? 18,
          height: height ?? 1.1,
        ),
      );

  static big26Text({
    required String text,
    FontWeight? fontWeight,
    String? fontFamily,
    int? maxLine,
    Color? color,
  }) =>
      Text(
        text,
        maxLines: maxLine,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontFamily: fontFamily ?? "pop",
          color: color ?? Colors.black,
          height: 1,
          fontWeight: fontWeight ?? FontWeight.bold,
          fontSize: 26,
        ),
      );
}
