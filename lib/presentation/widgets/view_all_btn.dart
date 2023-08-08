import 'dart:developer';

import 'package:flutter/material.dart';

import '../../utils/app_color.dart';
import 'common_text.dart';
import 'custom_widgets.dart';

class ViewAllBtn extends StatefulWidget {
  const ViewAllBtn({Key? key}) : super(key: key);

  @override
  State<ViewAllBtn> createState() => _ViewAllBtnState();
}

class _ViewAllBtnState extends State<ViewAllBtn> {
  bool isView = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: contentSize(size, 1250, size.width),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomInkWell(
            onTap: () {},
            onHover: (value) {
              setState(() {
                isView = value;
              });
              log(value.toString());
            },
            child: Container(
              margin: const EdgeInsets.only(right: 20,bottom: 15),
              padding: const EdgeInsets.only(top: 3, right: 5,left: 5),
              decoration: BoxDecoration(
                color: isView ? AppColor.primary :Colors.white ,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: AppColor.primary),
              ),
              child: Texts.small13Text(
                size: size,
                text: "View all",
                fontSize: 10,
                color: isView ? Colors.white : AppColor.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
