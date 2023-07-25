import 'package:flutter/material.dart';

import '../../widgets/common_text.dart';
import '../../widgets/custom_widgets.dart';
import '../../widgets/rating_star.dart';

class DescWidget extends StatefulWidget {
  const DescWidget({Key? key}) : super(key: key);

  @override
  State<DescWidget> createState() => _DescWidgetState();
}

class _DescWidgetState extends State<DescWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  SizedBox(
      width: contentSize(size, 700, size.width * 0.45),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Texts.small13Text(size: size, text: "Company name"),
          Texts.big26Text(text: "Product small name", fontWeight: FontWeight.bold),
          const SizedBox(height: 2),
          Texts.headingText(
            text: "product small description that can be understand by customer",
            maxLine: 2,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
          const SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const RatingStar(rating: 3.5),
              const SizedBox(width: 5),
              Texts.small13Text(size: size, text: "( 15 Customer Reviews )"),
            ],
          )
        ],
      ),
    );
  }
}
