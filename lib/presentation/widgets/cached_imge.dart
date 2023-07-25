import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'loader/image_loader.dart';

class CacheImage extends StatelessWidget {
  final String img;
  final double? height;
  final double? width;
  final Widget? error;

  const CacheImage({
    Key? key,
    required this.img,
    this.height,
    this.width,
    this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: img,
      height: height,
      width: width,
      fit: BoxFit.cover,
      placeholder: (context, url) => ImageLoader(
        height: height ?? 50,
        width: width ?? 50,
        radius: 5,
      ),
      errorWidget: (context, url, error) => error ?? const Icon(Icons.image_not_supported_outlined),
    );
  }
}
