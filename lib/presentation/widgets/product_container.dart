import 'dart:developer';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:three_connects/presentation/widgets/common_text.dart';
import 'package:three_connects/presentation/widgets/rating_star.dart';
import 'package:three_connects/utils/helper.dart';

import '../../utils/app_color.dart';
import 'custom_image.dart';
import 'custom_widgets.dart';

class ProductContainer extends StatefulWidget {
  final int index;
  final String path;

  const ProductContainer({
    Key? key,
    required this.index,
    required this.path,
  }) : super(key: key);

  @override
  State<ProductContainer> createState() => _ProductContainerState();
}

class _ProductContainerState extends State<ProductContainer> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CustomInkWell(
      onTap: () {
        context.beamToNamed("/Home?product=${widget.index}");
      },
      onHover: (value) {
        setState(() {
          if (value) {
            selectedIndex = widget.index;
          } else {
            selectedIndex = -1;
          }
        });
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
              color: selectedIndex == widget.index ? Colors.black26 : Colors.transparent),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                CustomNetworkImage(
                  src: product[widget.index],
                  fit: BoxFit.contain,
                  width: size500(size, 280, size.width > 350 ? 180 : size.width),
                  height: size500(size, 260, size.width > 350 ? 150 : size.width * 0.6),
                  placeholder: Image.asset(
                    "assets/sabjiwaala.jpeg",
                    width: size500(size, 280, size.width > 350 ? 180 : size.width),
                    height: size500(size, 260, size.width > 350 ? 150 : size.width * 0.6),
                    fit: BoxFit.fill,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: CustomInkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColor.primary,
                      ),
                      child: const Icon(Icons.add_shopping_cart, color: Colors.white, size: 16),
                    ),
                  ),
                ),
                if (widget.index % 3 != 1)
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white, borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.all(2),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(color: widget.index % 3 == 0 ? Colors.orange : Colors.red),
                        ),
                        child: Texts.small13Text(
                            size: size,
                            text: widget.index % 3 == 0 ? "Bestseller" : "-${widget.index * 3} %",
                            color: widget.index % 3 == 0 ? Colors.orange : Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: size.width > 500 ? 13 : 10),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const RatingStar(rating: 3.5),
                    const SizedBox(width: 7),
                    SizedBox(
                      width: size.width > 380 || size.width < 350 ? null : size.width * 0.1,
                      child: Texts.small13Text(
                        size: size,
                        text: "3.5 ( ${widget.index} )",
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Texts.headingText(
                  text: "Company Name big is there",
                  fontWeight: FontWeight.w600,
                  fontSize: size.width > 615 ? 18 : size500(size, 19, 15),
                ),
                Texts.small13Text(
                    text: "product small title",
                    maxLine: 2,
                    size: size,
                    fontSize: size500(size, 14, 12)),
                const SizedBox(height: 8),
                Texts.small13Text(
                    size: size,
                    text: "Product full description with all details of "
                        "products and customer can easily understand",
                    maxLine: 3,
                    color: Colors.black54,
                    fontSize: size500(size, 13, 10),
                    fontWeight: FontWeight.w600),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Texts.headingText(
                      text: "₹ 1200",
                      fontWeight: FontWeight.bold,
                      color: AppColor.btnColor,
                      fontSize: size.width > 615 ? 18 : size500(size, 16, 13),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "₹ 1350",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: "pop",
                        color: Colors.black54,
                        fontSize: size.width > 615 ? 15 : size500(size, 13, 10),
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
