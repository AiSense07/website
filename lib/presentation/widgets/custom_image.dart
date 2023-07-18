import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

import 'loader/image_loader.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    Key? key,
    required this.src,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
    this.placeholder, this.onTap,
  }) : super(key: key);
  final String src;
  final BoxFit fit;
  final Widget? placeholder;
  final Function? onTap;
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
          : ImageNetwork(
              onTap: () {
                if (onTap != null) {
                  onTap!();
                }
              },
              fitWeb: BoxFitWeb.cover,
              height: height,
              width: width,
              image: src,
              onLoading: ImageLoader(height: height, width: width, radius: 15),
              onError: placeholder ?? Image.asset("assets/placeholder2.jpeg"),
            ),
    );
  }
}
