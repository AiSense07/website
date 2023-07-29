import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:three_connects/utils/app_color.dart';

class ImageLoader extends StatelessWidget {
  final double? height;
  final double? width;
  final double radius;

  const ImageLoader({
    Key? key,
     this.height,
     this.width,
    required this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.shimmerBaseColor,
      highlightColor: AppColor.shimmerHighlightColor,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: AppColor.background,
        ),
      ),
    );
  }
}
