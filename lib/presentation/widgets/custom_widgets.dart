import 'package:flutter/material.dart';

double sizes(Size size, double size1, double size2) {
  return size.width > 700 ? size1 : size2;
}

double contentSize(Size size, double size1, double size2) {
  return size.width > 1300 ? size1 : size2;
}