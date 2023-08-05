import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:three_connects/presentation/screen/product_screen/desc_widget.dart';
import 'package:three_connects/presentation/screen/product_screen/image_widget.dart';
import 'package:three_connects/presentation/screen/product_screen/widgtes/tech_container.dart';
import 'package:three_connects/presentation/widgets/appbar.dart';
import 'package:three_connects/presentation/widgets/common_text.dart';
import 'package:three_connects/presentation/widgets/footer.dart';
import 'package:three_connects/utils/app_color.dart';
import 'package:three_connects/utils/helper.dart';
import '../../widgets/custom_widgets.dart';

class ProductScreen extends StatefulWidget {
  final String productId;

  const ProductScreen({Key? key, required this.productId}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    log("size width ${size.width}");
    return Scaffold(
      body: SafeArea(
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
              SizedBox(
                width: size.width > 1150 ? 800 : size.width - 30,
                child: ListView.builder(
                  itemCount: desc.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Texts.headingText(
                            text: desc[index]['title'] ?? '',
                            fontFamily: "bold",
                          ),
                          const SizedBox(height: 10),
                          Texts.headingText(
                            text: desc[index]['text'] ?? '',
                            color: AppColor.primary,
                            fontSize: 15,
                            maxLine: 10,
                            height: 1.5
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              const FooterBoard(false)
            ],
          ),
        ),
      ),
    );
  }
}
