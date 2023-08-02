import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:three_connects/presentation/screen/product_screen/desc_widget.dart';
import 'package:three_connects/presentation/screen/product_screen/image_widget.dart';
import 'package:three_connects/presentation/widgets/appbar.dart';
import 'package:three_connects/presentation/widgets/footer.dart';
import 'package:three_connects/utils/app_color.dart';
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
      body: SingleChildScrollView(
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
            ),
            const FooterBoard(false)
          ],
        ),
      ),
    );
  }
}
