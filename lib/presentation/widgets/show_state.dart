import 'package:flutter/material.dart';
import 'package:three_connects/presentation/widgets/common_text.dart';
import 'package:three_connects/presentation/widgets/custom_widgets.dart';

import '../../utils/helper.dart';

class ShowState extends StatelessWidget {
  final Function(int index) onTap;

  const ShowState({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Colors.white,
      title: Texts.headingText(
        text: "Select State",
        fontSize: 22,
        fontWeight: FontWeight.w600
      ),
      actions: [
        InkWell(
          onTap: () {
            pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Texts.headingText(text: "Cancel",fontWeight: FontWeight.w600),
          ),
        ),
      ],
      content: SizedBox(
        width: 350,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: statesListTitles.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: (){
                onTap(index);
                pop(context);
              },
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                height: 35,
                child: Texts.headingText(text: statesListTitles[index],fontSize: 15),
              ),
            );
          },
        ),
      ),
    );
  }
}
