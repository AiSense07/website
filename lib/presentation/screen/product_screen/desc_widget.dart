import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:three_connects/presentation/screen/product_screen/widgtes/color_container.dart';
import 'package:three_connects/presentation/widgets/custom_btn.dart';
import 'package:three_connects/utils/helper.dart';

import '../../../utils/app_color.dart';
import '../../widgets/common_text.dart';
import '../../widgets/custom_widgets.dart';
import '../../widgets/loader/image_loader.dart';
import '../../widgets/rating_star.dart';

class DescWidget extends StatefulWidget {
  const DescWidget({Key? key}) : super(key: key);

  @override
  State<DescWidget> createState() => _DescWidgetState();
}

class _DescWidgetState extends State<DescWidget> {
  bool isExpand = false;
  bool isMaxError = false;
  bool isFav = false;
  ScrollController controller = ScrollController();
  TextEditingController count = TextEditingController(text: "1");
  int counts = 1;
  FocusNode focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      width: contentSize(size, 600, sizes(size, size.width * 0.45, size.width)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Texts.small13Text(size: size, text: "Company name"),
          Texts.big26Text(text: "Product small name", fontWeight: FontWeight.bold),
          const SizedBox(height: 5),
          Texts.headingText(
            text: "Allround PLA filament at an unbeatable price in Black",
            maxLine: 2,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
            fontSize: 15,
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
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(width: 5),
              Text(
                "₹ 1350",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: "pop",
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
          Container(
            color: Colors.black12,
            child: ImageLoader(
              height: (size.width > 760 ? contentSize(size, 60, size.width * 0.062) : 46),
              width: (size.width > 760 ? contentSize(size, 60, size.width * 0.062) : 46),
              radius: 5,
            ),
          ),
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
                    crossAxisCount: size.width > 950 ? 6 : 5,
                    crossAxisSpacing: size.width > 950 ? 10 : 5,
                    mainAxisSpacing: size.width > 950 ? 10 : 5,
                  ),
                  itemBuilder: (context, index) {
                    return ColorContainer(
                      img: color[index],
                      toolTip: "White Marble ${index + 1}",
                      size: size,
                    );
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
                        return ColorContainer(
                          img: color[index],
                          size: size,
                        );
                      },
                    ),
                  ),
                ),
          if (size.width > 730)
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
          if (size.width < 730)
            const SizedBox(height: 25),
          Texts.headingText(
            text: "In Stock",
            fontWeight: FontWeight.bold,
            color: AppColor.btnColor,
          ),
          RichText(
            text: TextSpan(
              text: "Delivery in 5 days, ",
              style: const TextStyle(
                fontFamily: "pop",
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
                    fontFamily: "pop",
                    fontWeight: FontWeight.w100,
                    color: AppColor.primary.withOpacity(0.8),
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
                        if (isMaxError) {
                          isMaxError = false;
                        }
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
                        isMaxError = true;
                      } else if (count.text == "" || int.parse(count.text) <= 0) {
                        counts = 1;
                        count.text = "1";
                      } else {
                        counts = int.parse(count.text);
                      }
                      focus.unfocus();
                    });
                  },
                  onSubmitted: (_) {
                    setState(() {
                      if (int.parse(count.text) > 100) {
                        counts = 100;
                        count.text = "100";
                        isMaxError = true;
                      } else if (count.text == "" || int.parse(count.text) <= 0) {
                        counts = 1;
                        count.text = "1";
                      } else {
                        counts = int.parse(count.text);
                      }
                      focus.unfocus();
                    });
                  },
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                      if (isMaxError) {
                        isMaxError = false;
                      }
                    } else {
                      isMaxError = true;
                    }
                  },
                  icon: Icons.add,
                  isLow: counts >= 100),
            ],
          ),
          if (isMaxError)
            Container(
              margin: const EdgeInsets.only(top: 25),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.primary),
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFD7D7F6),
              ),
              child: Texts.headingText(
                  text: "There are only 100 items of this product "
                      "left in our warehouse. More are on the "
                      "way! The delivery date could be affected"
                      " if you order more than this quantity.",
                  maxLine: 100),
            ),
          Row(
            children: [
              CustomInkWell(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  width: contentSize(size, 500, sizes(size, size.width * 0.34, size.width * 0.5)),
                  height: 40,
                  margin: const EdgeInsets.only(top: 10, bottom: 25, right: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColor.primary,
                  ),
                  child: Texts.small13Text(
                    size: size,
                    text: "Add to Cart",
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
              CustomInkWell(
                onTap: () {},
                onHover: (value) {
                  setState(() {
                    isFav = value;
                  });
                },
                child: Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 10, bottom: 25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: !isFav ? Colors.white : AppColor.primary,
                    border: Border.all(color: AppColor.primary),
                  ),
                  child: Icon(
                    Icons.favorite_outline,
                    color: isFav ? Colors.white : AppColor.primary,
                  ),
                ),
              ),
            ],
          ),
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.only(top: 10, bottom: 25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color(0xFFD7D7F6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Texts.headingText(
                    text: "Features & Advantages",
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 8),
                  featuresText(text: "More environmentally friendly", size: size),
                  featuresText(text: "Easy processing", size: size),
                  featuresText(text: "Good rigidity", size: size),
                  featuresText(text: "Good mechanical properties", size: size),
                ],
              )),
        ],
      ),
    );
  }

  featuresText({required String text, required Size size}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 5),
          child: Icon(Icons.circle, size: 5, color: AppColor.primary),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: contentSize(size, 500, sizes(size, size.width * 0.35, size.width * 0.85)),
          child: Texts.headingText(text: text, color: AppColor.primary, fontSize: 15, maxLine: 10),
        ),
      ],
    );
  }
}
