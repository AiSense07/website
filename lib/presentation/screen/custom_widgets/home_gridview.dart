import 'dart:developer';

import 'package:flutter/material.dart';
import '../../widgets/custom_widgets.dart';
import '../../widgets/product_container.dart';

class HomeGrid extends StatefulWidget {
  const HomeGrid({Key? key}) : super(key: key);

  @override
  State<HomeGrid> createState() => _HomeGridState();
}

class _HomeGridState extends State<HomeGrid> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        setState(() {
          isMax = true;
        });
      } else if (controller.position.pixels == controller.position.minScrollExtent) {
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

  double scroll = 0;
  bool isMax = false;
  bool isMin = true;

  double elevation = 4.0;
  double scale = 1.0;
  Offset translate = const Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    log("${size.width}");
    return SizedBox(
      // height: size.width > 500 ? 950 : 680,
      width: contentSize(size, 1250, size.width),
      child: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: size500(size, 25, 15)),
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        shrinkWrap: true,
        // scrollDirection: Axis.horizontal,
        itemCount: 4,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: size.width > 900
              ? 4
              : size.width > 730
                  ? 3
                  : size.width > 320
                      ? 2
                      : 1,
          childAspectRatio: contentSize(
            size,
            0.55,
            size.width > 900
                ? size.width * 0.00045
                : size.width > 730
                    ? size.width * 0.00057
                    : size.width > 500
                        ? size.width * 0.00088
                        : size.width > 320
                            ? size.width * 0.0012
                            : size.width * 0.0022,
          ),
          mainAxisSpacing: contentSize(size, 15, 5),
          crossAxisSpacing: contentSize(size, 20, 5),
        ),
        itemBuilder: (context, index) {
          return ProductContainer(index: index, path: '');
        },
      ),
    );
  }
}
