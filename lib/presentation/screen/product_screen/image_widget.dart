import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

import '../../../utils/helper.dart';
import '../../widgets/custom_btn.dart';
import '../../widgets/custom_widgets.dart';
import '../../widgets/loader/image_loader.dart';

class ImageWidget extends StatefulWidget {
  const ImageWidget({Key? key}) : super(key: key);

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
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
    return SizedBox(
      width: contentSize(size, 500, sizes(size, size.width * 0.4, size.width)),
      height: contentSize(size, 600, sizes(size, size.width * 0.45 + 30, size.width * 0.8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CarouselSlider(
            carouselController: _controller,
            items: images
                .map((e) => ImageNetwork(
                      fitWeb: BoxFitWeb.cover,
                      height: contentSize(size, 500, sizes(size, size.width * 0.4, size.width * 0.6)),
                      width: contentSize(size, 500, sizes(size, size.width * 0.4, size.width * 0.8)),
                      image: e,
                      onLoading: ImageLoader(
                        height: contentSize(size, 500, sizes(size, size.width * 0.4, size.width * 0.6)),
                        width: contentSize(size, 500, sizes(size, size.width * 0.4, size.width * 0.8)),
                        radius: 15,
                      ),
                      onError: const Icon(Icons.image_not_supported_outlined),
                    ))
                .toList(),
            options: CarouselOptions(
                height: contentSize(size, 500, sizes(size, size.width * 0.4, size.width * 0.6)),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!isMin)
                SlidingBtn(
                  rad: 30,
                  iconSize: sizes(size, 18, 15),
                  size: size,
                  onTap: () {
                    setState(() {
                      scroll -= contentSize(size, 76, sizes(size, size.width * 0.05 + 26, size.width * 0.02 + 26));
                    });
                    scrollController.animateTo(
                      scroll,
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.linear,
                    );
                  },
                  icon: Icons.arrow_back_ios_new_outlined,
                  marg: 5,
                )
              else
                const SizedBox(width: 30),
              SizedBox(
                height: contentSize(size, 76, sizes(size, size.width * 0.05 + 26, size.width * 0.08 + 26)),
                width: contentSize(size, 450, sizes(size, size.width * 0.3, size.width * 0.7)),
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
                        height: contentSize(size, 50, sizes(size, size.width * 0.05, size.width * 0.08)),
                        width: contentSize(size, 50, sizes(size, size.width * 0.05, size.width * 0.08)),
                        image: images[index],
                        onLoading: ImageLoader(
                          height: contentSize(size, 50, sizes(size, size.width * 0.05, size.width * 0.08)),
                          width: contentSize(size, 50, sizes(size, size.width * 0.05, size.width * 0.08)),
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
                    rad: sizes(size, 30, 25),
                    iconSize: sizes(size, 18, 15),
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
                    icon: Icons.arrow_forward_ios_rounded)
              else
                const SizedBox(width: 30)
            ],
          )
        ],
      ),
    );
  }
}
