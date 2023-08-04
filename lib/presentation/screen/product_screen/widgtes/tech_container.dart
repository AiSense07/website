import 'package:flutter/material.dart';

import '../../../widgets/common_text.dart';
import '../../../widgets/custom_widgets.dart';

class TechContainer extends StatelessWidget {
  final int index;
  final List<Map<String, String>> list;

  const TechContainer({Key? key, required this.index, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.centerRight,
            width: size.width > 900 ? contentSize(size, 300, 200) : size.width * 0.4,
            child: Texts.headingText(
                text: "${list[index]['title'] ?? ''} :",
                fontSize: size500(size, 14, 13),
                maxLine: 3,
                fontFamily: "w600",
                color: Colors.white,
                textAlign: TextAlign.end),
          ),
          Container(
            margin: const EdgeInsets.only(left: 8),
            alignment: Alignment.centerLeft,
            width: size.width > 900 ? contentSize(size, 300, 200) : size.width * 0.4,
            child: Texts.headingText(
              text: list[index]['text'] ?? '',
              fontFamily: 'light',
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
