import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:three_connects/presentation/widgets/common_text.dart';
import 'package:three_connects/utils/app_color.dart';

import '../../../utils/helper.dart';
import '../../widgets/loader/image_loader.dart';
import 'address_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isLoad = false;
  int qnty = 1;
  int totalPrice = 0;
  bool isCart = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
      width: size.width > 500 ? 450 : size.width,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 12,
              right: 15,
              left: 10,
              bottom: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (!isCart)
                      IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onPressed: () {
                          setState(() {
                            isCart = true;
                          });
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                    Texts.headingText(
                      text: isCart ? "My cart" : "Address details",
                      fontFamily: "bold",
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {
                      pop(context);
                    },
                    icon: const Icon(Icons.close)),
              ],
            ),
          ),
          Container(
            width: size.width * 0.9,
            height: 2,
            color: Colors.black.withOpacity(0.1),
          ),
          isCart
              ? cartScreen(size)
              : AddressScreen(
                  userId: "1",
                  isCartScreen: true,
                  length: 1,
                  totalPrice: totalPrice,
                  widget: const SizedBox(),
                ),
        ],
      ),
    );
  }

  cartScreen(Size size) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Texts.headingText(
                          text: "Order Summary",
                          fontFamily: 'medium',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        ListView.builder(
                          itemCount: 2,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Container(
                                  width: size.width,
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          color: null,
                                          height: size.width > 450 ? 100 : size.width * 0.2,
                                          width: size.width > 450 ? 100 : size.width * 0.2,
                                          imageUrl: "https://c-3d.niceshops.com/upload/"
                                              "image/product/large/default/"
                                              "30155_a9ec5c37.256x256.webp",
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) => Image.asset(
                                            "assets/sabjiwaala.jpeg",
                                            fit: BoxFit.cover,
                                          ),
                                          placeholder: (context, url) => ImageLoader(
                                              height: size.width > 450 ? 100 : size.width * 0.2,
                                              width: size.width > 450 ? 100 : size.width * 0.2,
                                              radius: 10),
                                        ),
                                      ),
                                      SizedBox(width: size.width < 350 ? size.width * 0.01 : 10),
                                      SizedBox(
                                        width: size.width > 450 ? 250 : size.width * 0.6,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Texts.headingText(
                                              text: "Product Name",
                                              fontFamily: 'medium',
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            Texts.small13Text(
                                                text: "this is product description, by this "
                                                    "user can understand product easily",
                                                fontFamily: 'medium',
                                                fontSize: 12,
                                                size: size,
                                                maxLine: 2,
                                                height: 1.3,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black.withOpacity(0.5)),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Texts.headingText(
                                                      text: "₹ 1000.00/kg",
                                                      fontFamily: 'medium',
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  width: size.width > 450 ? 80 : size.width * 0.18,
                                                  padding: const EdgeInsets.symmetric(
                                                      horizontal: 5, vertical: 2),
                                                  decoration: BoxDecoration(
                                                      color: AppColor.primary,
                                                      borderRadius: BorderRadius.circular(5)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      InkWell(
                                                        child: Container(
                                                          alignment: Alignment.center,
                                                          width: size.width > 450
                                                              ? 25
                                                              : size.width * 0.04,
                                                          child: Text(
                                                            "-",
                                                            style: TextStyle(
                                                                fontSize: size.width > 450
                                                                    ? 15
                                                                    : size.width * 0.038,
                                                                fontWeight: FontWeight.w600,
                                                                color: Colors.white),
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        "1",
                                                        style: TextStyle(
                                                            fontSize: size.width > 450
                                                                ? 16
                                                                : size.width * 0.038,
                                                            fontWeight: FontWeight.w600,
                                                            color: Colors.white),
                                                      ),
                                                      InkWell(
                                                        child: Container(
                                                          alignment: Alignment.center,
                                                          width: size.width > 450
                                                              ? 25
                                                              : size.width * 0.04,
                                                          child: Text(
                                                            "+",
                                                            style: TextStyle(
                                                                fontSize: size.width > 450
                                                                    ? 15
                                                                    : size.width * 0.038,
                                                                fontWeight: FontWeight.w600,
                                                                color: Colors.white),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        Texts.headingText(
                          text: "Bill Summary",
                          fontFamily: 'medium',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        Container(
                          width: size.width,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              billTexts(
                                  size: size, title: "Order Total", desc: "2000.00", isBold: true),
                              billTexts(size: size, title: "Delivery charges", desc: "00.00"),
                              billTexts(size: size, title: "Service charges", desc: "00.00"),
                              billTexts(
                                  size: size, title: "Grand Total", desc: "2000.00", isBold: true),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          cartContainer(
              context: context,
              length: 1,
              totalPrice: "2000",
              onTap: () {
                setState(() {
                  isCart = false;
                });
              },
              size: size)
        ],
      ),
    );
  }

  Widget billTexts(
      {required String title, required String desc, bool isBold = false, required Size size}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Texts.headingText(
            text: title,
            fontFamily: 'medium',
            fontSize: isBold ? 15 : 13,
            height: 1.4,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
          ),
          Texts.headingText(
            text: "$desc/-",
            fontFamily: 'medium',
            fontSize: isBold ? 15 : 13,
            height: 1.4,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
          ),
        ],
      ),
    );
  }
}

Widget cartContainer({
  required int length,
  required Function onTap,
  required Size size,
  required BuildContext context,
  bool isAddressScreen = false,
  double? bottomPad,
  required String totalPrice,
}) {
  return Container(
    width: size.width,
    padding: EdgeInsets.only(
      top: 10,
      right: 15,
      left: 15,
      bottom: MediaQuery.of(context).padding.bottom / 2 + 10,
    ),
    decoration: const BoxDecoration(
        borderRadius:
            BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
        color: AppColor.primary),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Texts.headingText(
                text: "$length item in cart",
                fontFamily: 'medium',
                fontSize: 13,
                height: 1.4,
                color: Colors.white),
            Texts.headingText(
                text: "₹ $totalPrice.00/-",
                fontFamily: 'medium',
                fontSize: 15,
                height: 1.4,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ],
        ),
        InkWell(
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            onTap();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Text(
              "Proceed to pay",
              style: TextStyle(fontSize: size.width > 450 ? 16 : size.width * 0.04),
            ),
          ),
        )
      ],
    ),
  );
}
