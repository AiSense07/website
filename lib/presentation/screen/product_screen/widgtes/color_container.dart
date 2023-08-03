import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../utils/app_color.dart';
import '../../../widgets/custom_widgets.dart';
import '../../../widgets/loader/image_loader.dart';

class ColorContainer extends StatelessWidget {
  final String img;
  final String? toolTip;
  final Size size;

  const ColorContainer({Key? key, required this.img, this.toolTip, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: toolTip == null
          ? null
          : BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.black54),
            ),
      child: CustomInkWell(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Tooltip(
              richMessage: TextSpan(text: toolTip ?? ''),
              decoration: BoxDecoration(
                color: AppColor.btnColor,
                borderRadius: BorderRadius.circular(5),
              ),
              waitDuration: const Duration(milliseconds: 100),
              child: Container(
                width: toolTip != null ? null : 80,
                height: toolTip != null ? null : 80,
                padding: const EdgeInsets.all(5),
                margin: toolTip != null ? null : const EdgeInsets.only(right: 10, bottom: 5),
                decoration: toolTip != null
                    ? null
                    : BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black54),
                      ),
                child: CachedNetworkImage(
                  imageUrl: img,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => ImageLoader(
                    height: (size.width > 760 ? contentSize(size, 60, size.width * 0.05) : 46),
                    width: (size.width > 760 ? contentSize(size, 60, size.width * 0.05) : 46),
                    radius: 5,
                  ),
                  errorWidget: (context, url, error) =>
                      error ??
                      const Icon(
                        Icons.image_not_supported_outlined,
                      ),
                ),
              ),
            ),
            if (toolTip == null)
              const SizedBox(
                width: 80,
                child: Text(
                  "Marble White",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "pop",
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    height: 1,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
