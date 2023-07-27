import 'package:flutter/material.dart';

double sizes(Size size, double size1, double size2) {
  return size.width > 730 ? size1 : size2;
}

double contentSize(Size size, double size1, double size2) {
  return size.width > 1300 ? size1 : size2;
}

double size500(Size size, double size1, double size2) {
  return size.width > 500 ? size1 : size2;
}

double productCarouselSize(Size size) {
  return contentSize(size, 60, sizes(size, size.width * 0.05, size.width * 0.08));
}

double scrollSize(Size size) {
  return contentSize(size, 76, sizes(size, size.width * 0.05 + 26, size.width * 0.08 + 26));
}

double imgWidth(Size size) {
  return contentSize(size, 650, sizes(size, size.width * 0.45, size.width * 0.8));
}

double imgHeight(Size size) {
  return contentSize(size, 550, sizes(size, size.width * 0.4, size.width * 0.6));
}

class CustomInkWell extends StatelessWidget {
  final Widget child;
  final Function onTap;
  final Function(bool value)? onHover;

  const CustomInkWell({Key? key, required this.child, required this.onTap, this.onHover}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        onTap();
      },
      onHover: (value) {
        if (onHover != null) onHover!(value);
      },
      child: child,
    );
  }
}