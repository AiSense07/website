import 'package:flutter/material.dart';
import 'package:three_connects/utils/app_color.dart';

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
      height: 950,
      width: contentSize(size, 1250, size.width),
      child: Stack(
        children: [
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller,
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.55,
              mainAxisSpacing: 15,
              crossAxisSpacing: 20,
            ),
            itemBuilder: (context, index) {
              return ProductContainer(index: index);
            },
          ),
          if (!isMax)
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
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
                child: Container(
                  margin: const EdgeInsets.only(right: 15),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColor.primary),
                  width: 50,
                  height: 50,
                  child: const Icon(Icons.arrow_forward_ios_outlined, color: Colors.white),
                ),
              ),
            ),
          if (!isMin)
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
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
                child: Container(
                  margin: const EdgeInsets.only(left: 15),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColor.primary),
                  width: 50,
                  height: 50,
                  child: const Icon(Icons.arrow_back_ios, color: Colors.white),
                ),
              ),
            )
        ],
      ),
    );
  }
}
