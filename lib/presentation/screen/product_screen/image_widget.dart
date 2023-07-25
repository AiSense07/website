import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:three_connects/presentation/widgets/cached_imge.dart';

import '../../../utils/helper.dart';
import '../../widgets/custom_btn.dart';
import '../../widgets/custom_widgets.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          width: contentSize(size, 600, sizes(size, size.width * 0.45, size.width * 0.9)),
          child: CarouselSlider(
            carouselController: _controller,
            items: images
                .map((e) => CacheImage(
                      height: imgHeight(size),
                      width: imgWidth(size),
                      img: e,
                    ))
                .toList(),
            options: CarouselOptions(
                height: imgHeight(size),
                autoPlay: false,
                enlargeCenterPage: false,
                viewportFraction: 1.1,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
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
                    scroll -= scrollSize(size);
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
              height: contentSize(
                size,
                86,
                sizes(size, size.width * 0.05 + 26, size.width * 0.08 + 26),
              ),
              width: contentSize(
                size,
                450,
                sizes(size, size.width * 0.3, size.width * 0.7),
              ),
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
                    child: CacheImage(
                      height: productCarouselSize(size),
                      width: productCarouselSize(size),
                      img: images[index],
                    ),
                  ),
                ),
              ),
            ),
            if (!isMax &&
                images.length >
                    contentSize(
                        size,
                        5,
                        size.width > 1040
                            ? 4
                            : size.width > 730
                                ? 3
                                : size.width > 460
                                    ? 5
                                    : 4))
              SlidingBtn(
                  isRight: true,
                  rad: sizes(size, 30, 25),
                  iconSize: sizes(size, 18, 15),
                  size: size,
                  onTap: () {
                    setState(() {
                      scroll += scrollSize(size);
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
    );
  }
}
