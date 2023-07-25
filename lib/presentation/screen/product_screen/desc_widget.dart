import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:three_connects/presentation/screen/product_screen/widgtes/color_container.dart';
import 'package:three_connects/presentation/widgets/custom_btn.dart';
import 'package:three_connects/utils/helper.dart';

import '../../../utils/app_color.dart';
import '../../widgets/common_text.dart';
import '../../widgets/custom_widgets.dart';
import '../../widgets/rating_star.dart';

class DescWidget extends StatefulWidget {
  const DescWidget({Key? key}) : super(key: key);

  @override
  State<DescWidget> createState() => _DescWidgetState();
}

class _DescWidgetState extends State<DescWidget> {
  bool isExpand = false;
  ScrollController controller = ScrollController();
  TextEditingController count = TextEditingController(text: "1");
  int counts = 1;
  FocusNode focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      width: contentSize(size, 650, sizes(size, size.width * 0.45, size.width)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Texts.small13Text(size: size, text: "Company name"),
          Texts.big26Text(text: "Product small name", fontWeight: FontWeight.bold),
          const SizedBox(height: 2),
          Texts.headingText(
            text: "Allround PLA filament at an unbeatable price in Black",
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
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              Texts.big26Text(
                text: "₹ 1200",
                fontFamily: "oxy",
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(width: 5),
              Text(
                "₹ 1350",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: "oxy",
                  color: Colors.black54,
                  fontSize: size.width > 615 ? 15 : 13,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
          Texts.small13Text(
            size: size,
            text: "( ${(100 - (1250 / 1350) * 100).roundToDouble()} % off )",
            color: AppColor.btnColor,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 25),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Texts.headingText(text: "Content :", fontWeight: FontWeight.bold),
              Texts.headingText(text: " 1.50 mm / 1000 g", color: Colors.black54, fontSize: 15),
            ],
          ),
          const SizedBox(height: 25),
          Texts.headingText(text: "Colors :", fontWeight: FontWeight.bold),
          size.width > 730
              ? GridView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  itemCount: color.length <= 5
                      ? color.length
                      : isExpand
                          ? color.length
                          : 5,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: size.width > 1300
                        ? 8
                        : size.width > 1150
                            ? 7
                            : size.width > 950
                                ? 6
                                : 5,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) {
                    return ColorContainer(img: color[index], toolTip: "White Marble ${index + 1}");
                  },
                )
              : SizedBox(
                  height: 145,
                  child: Scrollbar(
                    controller: controller,
                    interactive: true,
                    thumbVisibility: true,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      controller: controller,
                      itemCount: color.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ColorContainer(img: color[index]);
                      },
                    ),
                  ),
                ),
          CustomInkWell(
            onTap: () {
              setState(() {
                isExpand = !isExpand;
              });
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 8),
              margin: const EdgeInsets.only(top: 10, bottom: 25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AppColor.primary),
                color: AppColor.primary.withOpacity(0.1),
              ),
              child: Texts.small13Text(
                size: size,
                text: isExpand ? "Show Less" : "Show More",
                fontSize: 15,
              ),
            ),
          ),
          Texts.headingText(
            text: "In Stock",
            fontWeight: FontWeight.bold,
            color: AppColor.btnColor,
          ),
          RichText(
            text: TextSpan(
              text: "Delivery in 5 days, ",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColor.primary,
                fontSize: 16,
              ),
              children: [
                TextSpan(
                  text: "if you order by ${DateFormat("EEEE, dd MMM").format(
                    DateTime.now().add(const Duration(days: 5)),
                  )}.",
                  style: TextStyle(
                    fontFamily: "oxy",
                    fontWeight: FontWeight.w100,
                    color: AppColor.primary.withOpacity(0.5),
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 25),
          Texts.headingText(text: "Quantity :", fontWeight: FontWeight.bold),
          Row(
            children: [
              PlusMinBtn(
                  onTap: () {
                    if (counts != 1) {
                      setState(() {
                        count.text = (counts - 1).toString();
                        counts--;
                      });
                    }
                  },
                  icon: Icons.remove,
                  isLow: counts == 1),
              Container(
                height: 40,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColor.primary),
                ),
                child: TextField(
                  focusNode: focus,
                  controller: count,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.phone,
                  onTapOutside: (_) {
                    setState(() {
                      if (int.parse(count.text) > 100) {
                        counts = 100;
                        count.text = "100";
                      } else if (int.parse(count.text) <= 0) {
                        counts = 0;
                        count.text = "0";
                      } else {
                        counts = int.parse(count.text);
                      }
                      focus.unfocus();
                    });
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  ),
                ),
              ),
              PlusMinBtn(
                  onTap: () {
                    if (counts < 100) {
                      setState(() {
                        count.text = (counts + 1).toString();
                        counts++;
                      });
                    }
                  },
                  icon: Icons.add,
                  isLow: counts >= 100),
            ],
          )
        ],
      ),
    );
  }
}
