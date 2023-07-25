import 'package:flutter/material.dart';
import 'package:three_connects/presentation/widgets/cached_imge.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    Key? key,
    required this.src,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
  }) : super(key: key);
  final String src;
  final BoxFit fit;
  final Widget? placeholder;
  final double width, height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: src == ""
          ? placeholder ??
              Image.asset(
                "assets/placeholder2.jpeg",
                width: width,
                height: height,
              )
          : CacheImage(
              img: src,
              height: height,
              width: width,
              error: placeholder ?? Image.asset("assets/placeholder2.jpeg"),
            ),
    );
  }
}
