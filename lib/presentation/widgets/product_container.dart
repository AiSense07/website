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
  bool btnSelect = false;

  double elevation = 4.0;
  double scale = 1.0;

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
            elevation = 2;
            scale = 1.03;
          } else {
            selectedIndex = -1;
            elevation = 4;
            scale = 1.0;
          }
        });
      },
      child: Transform.scale(
        scale: scale,
        child: Material(
          shadowColor: selectedIndex == widget.index ? Colors.black12 : Colors.transparent,
          color: selectedIndex == widget.index ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          elevation: elevation,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(
                color: selectedIndex == widget.index ? Colors.black26 : Colors.transparent,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CustomNetworkImage(
                      src: product[widget.index],
                      fit: BoxFit.contain,
                      width: size500(size, 280, size.width > 320 ? 180 : size.width),
                      height: size500(size, 260, size.width > 320 ? 150 : size.width * 0.6),
                      placeholder: Image.asset(
                        "assets/sabjiwaala.jpeg",
                        width: size500(size, 280, size.width > 320 ? 180 : size.width),
                        height: size500(size, 260, size.width > 320 ? 150 : size.width * 0.6),
                        fit: BoxFit.fill,
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
                        if (size.width < 400 && size.width > 320)
                          const Icon(Icons.star,color: AppColor.btnColor,size: 18)
                        else
                          RatingStar(
                            rating: 3.5,
                            size: (size.width < 440 && size.width > 320) ? 13.5 : 18,
                          ),
                        const SizedBox(width: 7),
                        SizedBox(
                          child: Texts.small13Text(
                            size: size,
                            text: "3.5 ( ${widget.index}000 )",
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
                    CustomInkWell(
                      onTap: () {},
                      onHover: (value) {
                        setState(() {
                          if (value) {
                            btnSelect = value;
                          } else {
                            btnSelect = false;
                          }
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 12),
                        width: size.width,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color:
                                selectedIndex == widget.index ? Colors.transparent : Colors.black,
                          ),
                          color: selectedIndex != widget.index
                              ? Colors.white
                              : btnSelect
                                  ? AppColor.btnColor
                                  : AppColor.primary,
                        ),
                        child: Texts.small13Text(
                          size: size,
                          text: "Add to cart",
                          color: selectedIndex != widget.index ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
