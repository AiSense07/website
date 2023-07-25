import 'package:flutter/material.dart';
import 'package:three_connects/presentation/widgets/custom_widgets.dart';

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
    this.iconSize,
    this.marg,
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
        padding: EdgeInsets.only(right: widget.isRight ? 0 : 2),
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

class PlusMinBtn extends StatefulWidget {
  final Function onTap;
  final IconData icon;
  final bool isLow;

  const PlusMinBtn({
    Key? key,
    required this.onTap,
    required this.icon,
    this.isLow = false,
  }) : super(key: key);

  @override
  State<PlusMinBtn> createState() => _PlusMinBtnState();
}

class _PlusMinBtnState extends State<PlusMinBtn> {
  bool onHover = false;

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: () {
        widget.onTap();
      },
      onHover: (value) {
        setState(() {
          onHover = value;
        });
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: widget.isLow
              ? Colors.black.withOpacity(0.05)
              : onHover
                  ? AppColor.primary
                  : Colors.black.withOpacity(0.15),
        ),
        child: Icon(widget.icon,
            color: widget.isLow
                ? Colors.black26
                : onHover
                    ? Colors.white
                    : Colors.black54),
      ),
    );
  }
}
