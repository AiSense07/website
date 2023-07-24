import 'package:flutter/material.dart';

import '../../utils/app_color.dart';

class SlidingBtn extends StatefulWidget {
  final Size size;
  final Function onTap;
  final IconData icon;
  final double? rad;
  final double? marg;
  final bool isRight;
  final double? iconSize;

  const SlidingBtn({
    Key? key,
    required this.size,
    required this.onTap,
    required this.icon,
    this.rad,
    this.isRight = false,
    this.iconSize, this.marg,
  }) : super(key: key);

  @override
  State<SlidingBtn> createState() => _SlidingBtnState();
}

class _SlidingBtnState extends State<SlidingBtn> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        widget.onTap();
      },
      onHover: (value) {
        if (value) {
          setState(() {
            isHover = value;
          });
        } else {
          setState(() {
            isHover = false;
          });
        }
      },
      child: Container(
        padding: EdgeInsets.only(right: widget.isRight ? 5 : 0),
        margin: widget.isRight ? EdgeInsets.only(left: widget.marg ?? 15) : EdgeInsets.only(right: widget.marg ?? 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isHover ? AppColor.primary : Colors.white,
          border: Border.all(color: AppColor.primary),
        ),
        width: widget.rad ?? 50,
        height: widget.rad ?? 50,
        child: Icon(
          widget.icon,
          color: isHover ? Colors.white : AppColor.primary,
          size: widget.iconSize,
        ),
      ),
    );
  }
}
