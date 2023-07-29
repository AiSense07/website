import 'package:flutter/material.dart';

import '../../../../utils/app_color.dart';
import '../../../widgets/cached_imge.dart';
import '../../../widgets/custom_widgets.dart';

class ColorContainer extends StatelessWidget {
  final String img;
  final String? toolTip;
  final Size size;

  const ColorContainer({Key? key, required this.img, this.toolTip, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black54),
              ),
              child: CacheImage(img: img),
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
                  fontFamily: "oxy",
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  height: 1,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
