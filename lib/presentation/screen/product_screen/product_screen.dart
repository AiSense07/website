import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:three_connects/presentation/screen/product_screen/desc_widget.dart';
import 'package:three_connects/presentation/screen/product_screen/image_widget.dart';
import 'package:three_connects/presentation/widgets/appbar.dart';
import 'package:three_connects/presentation/widgets/common_text.dart';
import 'package:three_connects/presentation/widgets/rating_star.dart';
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
          Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                width: contentSize(size, 1250, size.width),
                child: size.width > 730
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [ImageWidget(), DescWidget()],
                      )
                    : const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [ImageWidget(), DescWidget()],
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
