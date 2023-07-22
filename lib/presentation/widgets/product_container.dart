import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:three_connects/presentation/widgets/rating_star.dart';

import '../../utils/app_color.dart';
import 'custom_image.dart';

class ProductContainer extends StatefulWidget {
  final int index;

  const ProductContainer({Key? key, required this.index}) : super(key: key);

  @override
  State<ProductContainer> createState() => _ProductContainerState();
}

class _ProductContainerState extends State<ProductContainer> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {},
      onHover: (value) {
        setState(() {
          if (value) {
            selectedIndex = widget.index;
          } else {
            selectedIndex = -1;
          }
        });
      },
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: selectedIndex == widget.index ? Colors.black26 : Colors.transparent),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomNetworkImage(
              onTap: () {},
              src: "https://www.3dnatives.com/en/wp-content/uploads/sites/2/2021/06/filamentcove.jpeg",
              fit: BoxFit.cover,
              width: 280,
              height: 260,
              placeholder: Image.asset(
                "assets/sabjiwaala.jpeg",
                width: 280,
                height: 260,
                fit: BoxFit.fill,
              ),
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
                      width: size.width > 380 ? null : size.width * 0.1,
                      child: Text(
                        "3.5 ( ${widget.index} )",
                        maxLines: 1,
                        style: GoogleFonts.oxygen(
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                          letterSpacing: 0.7,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  "Company Name big is there",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.oxygen(
                    fontWeight: FontWeight.w700,
                    fontSize: size.width > 615 ? 18 : 16,
                    letterSpacing: 0.7,
                  ),
                ),
                Text(
                  "product small title",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.oxygen(fontSize: 13),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Product full description with all details of products and customer can easily understand',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    letterSpacing: 0.7,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      "₹ 1200",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.oxygen(
                        fontWeight: FontWeight.bold,
                        color: AppColor.btnColor,
                        fontSize: size.width > 615 ? 18 : 16,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "₹ 1350",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.oxygen(
                        color: Colors.black54,
                        fontSize: size.width > 615 ? 15 : 13,
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