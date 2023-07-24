import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:three_connects/presentation/widgets/appbar.dart';
import 'package:three_connects/presentation/widgets/common_text.dart';
import 'package:three_connects/utils/helper.dart';

import '../../widgets/custom_btn.dart';
import '../../widgets/custom_widgets.dart';
import '../../widgets/loader/image_loader.dart';

class ProductScreen extends StatefulWidget {
  final String productId;

  const ProductScreen({Key? key, required this.productId}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int _current = 0;

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        setState(() {
          isMax = true;
        });
      } else if (scrollController.position.pixels == scrollController.position.minScrollExtent) {
        setState(() {
          isMin = true;
        });
      } else {
        setState(() {
          isMax = false;
          isMin = false;
        });
      }
    });
    super.initState();
  }

  final CarouselController _controller = CarouselController();
  ScrollController scrollController = ScrollController();

  double scroll = 0;
  bool isMax = false;
  bool isMin = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    log("size width ${size.width}");
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CommonAppbar(),
          const SizedBox(height: 15),
          SizedBox(
            width: contentSize(size, 1250, size.width),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: contentSize(size, 500, size.width * 0.4),
                  height: contentSize(size, 600, size.width * 0.45 + 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CarouselSlider(
                        carouselController: _controller,
                        items: images
                            .map((e) => ImageNetwork(
                                  fitWeb: BoxFitWeb.cover,
                                  height: contentSize(size, 500, size.width * 0.4),
                                  width: contentSize(size, 500, size.width * 0.4),
                                  image: e,
                                  onLoading: ImageLoader(
                                    height: contentSize(size, 500, size.width * 0.4),
                                    width: contentSize(size, 500, size.width * 0.4),
                                    radius: 15,
                                  ),
                                  onError: const Icon(Icons.image_not_supported_outlined),
                                ))
                            .toList(),
                        options: CarouselOptions(
                            height: contentSize(size, 500, size.width * 0.4),
                            autoPlay: false,
                            enlargeCenterPage: false,
                            viewportFraction: 1.1,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            }),
                      ),
                      Row(
                        children: [
                          if (!isMin)
                            SlidingBtn(
                              rad: 25,
                              iconSize: 18,
                              size: size,
                              onTap: () {
                                setState(() {
                                  scroll -= contentSize(size, 76, size.width * 0.05 + 26);
                                });
                                scrollController.animateTo(
                                  scroll,
                                  duration: const Duration(milliseconds: 350),
                                  curve: Curves.linear,
                                );
                              },
                              icon: Icons.arrow_back_ios_new,
                              marg: 5,
                            ) else const SizedBox(width: 30),
                          SizedBox(
                            height: contentSize(size, 76, size.width * 0.05 + 26),
                            width: contentSize(size, 450, size.width * 0.3),
                            child: ListView.builder(
                              controller: scrollController,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: images.length,
                              itemBuilder: (context, index) => InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                onTap: () => _controller.animateToPage(index),
                                child: Container(
                                  margin: const EdgeInsets.all(8),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: _current == index ? Colors.black : Colors.black12),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: ImageNetwork(
                                    onTap: () => _controller.animateToPage(index),
                                    fitWeb: BoxFitWeb.cover,
                                    height: contentSize(size, 50, size.width * 0.05),
                                    width: contentSize(size, 50, size.width * 0.05),
                                    image: images[index],
                                    onLoading: ImageLoader(
                                      height: contentSize(size, 50, size.width * 0.05),
                                      width: contentSize(size, 50, size.width * 0.05),
                                      radius: 15,
                                    ),
                                    onError: const Icon(Icons.image_not_supported_outlined),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (!isMax)
                            SlidingBtn(
                                rad: 25,
                                iconSize: 18,
                                size: size,
                                onTap: () {
                                  setState(() {
                                    scroll += contentSize(size, 76, size.width * 0.05 + 26);
                                  });
                                  scrollController.animateTo(
                                    scroll,
                                    duration: const Duration(milliseconds: 350),
                                    curve: Curves.linear,
                                  );
                                },
                                icon: Icons.arrow_forward_ios_rounded)else const SizedBox(width: 30)
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: contentSize(size, 700, size.width * 0.45),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Texts.small13Text(size: size, text: "Company name"),
                      Texts.big24Text(text: "Product small name", fontWeight: FontWeight.bold),
                      const SizedBox(height: 2),
                      Texts.headingText(
                        text: "product small description that can be understand by customer",
                        maxLine: 2,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
