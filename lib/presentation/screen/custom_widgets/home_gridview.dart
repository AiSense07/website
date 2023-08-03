import 'package:flutter/material.dart';
import 'package:three_connects/presentation/widgets/custom_btn.dart';
import 'package:three_connects/utils/helper.dart';

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.width > 500 ? 950 : 680,
      width: contentSize(size, 1250, size.width),
      child: Stack(
        children: [
          GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: size500(size, 25, 15)),
            physics: const AlwaysScrollableScrollPhysics(),
            controller: controller,
            scrollDirection: Axis.horizontal,
            itemCount: product.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: size.width > 500 ?1.55 : 1.8,
              mainAxisSpacing: 15,
              crossAxisSpacing: 20,
            ),
            itemBuilder: (context, index) {
              return ProductContainer(index: index, path: '');
            },
          ),
          if (!isMax)
            Align(
              alignment: Alignment.centerRight,
              child: SlidingBtn(
                  size: size,
                  onTap: () {
                    setState(() {
                      scroll += size.width > 640 ? 630 : 315;
                    });
                    controller.animateTo(
                      scroll,
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.linear,
                    );
                  },
                  icon: Icons.arrow_forward_ios_rounded),
            ),
          if (!isMin)
            Align(
              alignment: Alignment.centerLeft,
              child: SlidingBtn(
                size: size,
                onTap: () {
                  setState(() {
                    scroll -= size.width > 640 ? 630 : 315;
                  });
                  controller.animateTo(
                    scroll,
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.linear,
                  );
                },
                icon: Icons.arrow_back_ios_new,
                isRight: true,
              ),
            )
        ],
      ),
    );
  }
}
