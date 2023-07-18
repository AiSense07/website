import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


/// Horizontal padding of the whole app
const double appPaddingX = 10;

int getColorCode(String color) {
  return int.parse(color.replaceAll("#", "0xff"));
}

pushReplacement(BuildContext context, Widget destination) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => destination),
  );
}

push(BuildContext context, Widget destination) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => destination),
  );
}

pop(BuildContext context) {
  Navigator.pop(context);
}

void commonToast(BuildContext context, String msg, {Color? color}) {
  Fluttertoast.showToast(
      toastLength: Toast.LENGTH_LONG,
      msg: msg,
      backgroundColor: color ?? Colors.black,
      textColor: Colors.white);
}

void logLongString(String s) {
  if (s.isEmpty) return;
  const int n = 1000;
  int startIndex = 0;
  int endIndex = n;
  while (startIndex < s.length) {
    if (endIndex > s.length) endIndex = s.length;
    print(s.substring(startIndex, endIndex));
    startIndex += n;
    endIndex = startIndex + n;
  }
}

double responsivePaddingWidth(
    BoxConstraints constraints, BuildContext context) {
  if (constraints.maxWidth <= 500) {
    return appPaddingX;
  } else {
    return MediaQuery.of(context).size.width * 0.09;
  }
}

double responsivePaddingWidthAppBar(
    BoxConstraints constraints, BuildContext context) {
  if (constraints.maxWidth <= 500) {
    return appPaddingX;
  } else {
    return MediaQuery.of(context).size.width * 0.08;
  }
}

double responsivePaddingWidthForCategory(
    BoxConstraints constraints, BuildContext context) {
  if (constraints.maxWidth <= 500) {
    return appPaddingX;
  } else {
    return MediaQuery.of(context).size.width * 0.05;
  }
}

double responsivePaddingWidthForSafety(
    BoxConstraints constraints, BuildContext context) {
  if (constraints.maxWidth <= 500) {
    return appPaddingX;
  } else {
    return MediaQuery.of(context).size.width * 0.02;
  }
}

bool responsiveBoolean(BoxConstraints constraints, BuildContext context) {
  if (constraints.maxWidth <= 500) {
    return true;
  } else {
    return false;
  }
}

double footerHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

