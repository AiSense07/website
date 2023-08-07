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

  double elevation = 4.0;
  double scale = 1.0;
  Offset translate = Offset(0,0);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
          crossAxisCount: 4,
          childAspectRatio: size.width * 0.00039,
          mainAxisSpacing: 15,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (context, index) {
          return ProductContainer(index: index, path: '');
        },
      ),
    );
  }
}
