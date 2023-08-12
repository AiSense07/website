import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:three_connects/presentation/screen/custom_widgets/home_gridview.dart';
import 'package:three_connects/presentation/screen/product_screen/desc_widget.dart';
import 'package:three_connects/presentation/screen/product_screen/image_widget.dart';
import 'package:three_connects/presentation/screen/product_screen/widgtes/tech_container.dart';
import 'package:three_connects/presentation/widgets/appbar.dart';
import 'package:three_connects/presentation/widgets/common_text.dart';
import 'package:three_connects/presentation/widgets/enddrawer.dart';
import 'package:three_connects/presentation/widgets/footer.dart';
import 'package:three_connects/utils/app_color.dart';
import 'package:three_connects/utils/helper.dart';
import '../../widgets/custom_widgets.dart';
import '../cart_modual/cart_screen.dart';

class ProductScreen extends StatefulWidget {
  final String productId;

  const ProductScreen({Key? key, required this.productId}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool isLoad = true;

  @override
  void initState() {
    log("message");
    Future.delayed(
      const Duration(seconds: 1),
      () {
        setState(() {
          isLoad = false;
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    log("size width ${size.width}");
    return Scaffold(
      endDrawer: const EndDrawer(),
      body: isLoad
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const CommonAppbar(),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: contentSize(size, 1250, size.width),
                      child: size.width > 730
                          ? const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ImageWidget(),
                                DescWidget(),
                              ],
                            )
                          : const Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ImageWidget(),
                                DescWidget(),
                              ],
                            ),
                    ),
                    Container(
                      color: AppColor.primary,
                      width: size.width,
                      padding: EdgeInsets.symmetric(
                        horizontal: contentSize(
                          size,
                          (size.width - 1250) / 2,
                          sizes(size, 25, size.width > 450 ? 30 : 10),
                        ),
                        vertical: sizes(size, 25, 15),
                      ),
                      child: Column(
                        children: [
                          Texts.headingText(
                            fontFamily: 'bold',
                            text: "Product information & technical details",
                            color: Colors.white,
                            maxLine: 2,
                            textAlign: TextAlign.center,
                            fontSize: sizes(size, 23, size500(size, 20, 18)),
                          ),
                          if (size.width <= 900)
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: tech.length,
                              padding: const EdgeInsets.only(top: 15),
                              itemBuilder: (context, index) {
                                return TechContainer(index: index, list: tech);
                              },
                            ),
                          if (size.width > 900)
                            Row(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: tech.length,
                                    padding: const EdgeInsets.only(top: 15),
                                    itemBuilder: (context, index) {
                                      return TechContainer(index: index, list: tech);
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: tech.length,
                                    padding: const EdgeInsets.only(top: 15),
                                    itemBuilder: (context, index) {
                                      return TechContainer(index: index, list: tech);
                                    },
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30, bottom: 15),
                      width: size.width > 1150 ? 800 : size.width - 30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Texts.big26Text(
                            text: "Description",
                            fontFamily: "bold",
                          ),
                          const Divider(),
                          ListView.builder(
                            itemCount: desc.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Texts.headingText(
                                        text: desc[index]['title'] ?? '',
                                        fontFamily: "bold",
                                        fontSize: sizes(size, 16, 15)),
                                    const SizedBox(height: 10),
                                    Texts.headingText(
                                        text: desc[index]['text'] ?? '',
                                        color: Colors.black,
                                        fontSize: sizes(size, 15, 15),
                                        fontFamily: "light",
                                        maxLine: 10,
                                        height: 1.5)
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15,bottom: 15),
                      width: contentSize(size, 1250, size.width),
                      alignment: Alignment.topLeft,
                      child: Texts.big26Text(
                        text: "Related Products",
                        fontFamily: "bold",
                      ),
                    ),
                    const HomeGrid(),
                    const SizedBox(height: 25),
                    const FooterBoard(false)
                  ],
                ),
              ),
            ),
    );
  }
}
