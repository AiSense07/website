import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:three_connects/presentation/screen/cart_modual/cart_screen.dart';

import 'package:three_connects/presentation/screen/custom_widgets/home_gridview.dart';
import 'package:three_connects/presentation/widgets/appbar.dart';
import 'package:three_connects/presentation/widgets/cached_imge.dart';
import 'package:three_connects/presentation/widgets/custom_widgets.dart';
import 'package:three_connects/presentation/widgets/footer.dart';
import 'package:three_connects/utils/app_image.dart';
import '../../utils/app_color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController scroll = ScrollController();
  final FocusNode _focusNode = FocusNode();

  void _handleKeyEvent(RawKeyEvent event) {
    var offset = scroll.offset;
    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      setState(() {
        if (kReleaseMode) {
          scroll.animateTo(
            offset - 15,
            duration: const Duration(milliseconds: 3),
            curve: Curves.ease,
          );
        } else {
          scroll.animateTo(
            offset - 15,
            duration: const Duration(milliseconds: 3),
            curve: Curves.ease,
          );
        }
      });
    } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      setState(() {
        if (kReleaseMode) {
          scroll.animateTo(
            offset + 15,
            duration: const Duration(milliseconds: 3),
            curve: Curves.ease,
          );
        } else {
          scroll.animateTo(
            offset + 15,
            duration: const Duration(milliseconds: 3),
            curve: Curves.ease,
          );
        }
      });
    }
  }

  int _current = 0;
  final CarouselController _controller = CarouselController();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.minScrollExtent) {
        setState(() {
          isMax = false;
        });
      } else {
        if (!isMax) {
          setState(() {
            isMax = true;
          });
        }
      }
    });
    super.initState();
  }

  bool isMax = false;

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      endDrawer: const CartScreen(),
      floatingActionButton: isMax
          ? FloatingActionButton(
              backgroundColor: AppColor.primary,
              onPressed: () {
                scroll.animateTo(
                  scroll.position.minScrollExtent,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.linear,
                );
              },
              child:
                  const Icon(Icons.arrow_upward_rounded, color: Colors.white),
            )
          : const SizedBox(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RawKeyboardListener(
          onKey: _handleKeyEvent,
          autofocus: true,
          focusNode: _focusNode,
          child: ListView(
            controller: scroll,
            children: [
              const CommonAppbar(isShadow: false),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CarouselSlider(
                    carouselController: _controller,
                    options: CarouselOptions(
                        height: sizes(size, 500, size.width * 0.7),
                        autoPlay: false,
                        enlargeCenterPage: false,
                        viewportFraction: 1.1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                    items: [0, 1, 2].map(
                      (index) {
                        return Container(
                          margin: const EdgeInsets.only(
                              bottom: 5, right: 15, left: 15),
                          width: size.width,
                          color: AppColor.background,
                          child: CacheImage(
                            height: sizes(size, 500, size.width * 0.7),
                            width: size.width,
                            img:
                                "https://www.3dnatives.com/en/wp-content/uploads/"
                                "sites/2/2021/06/filamentcove.jpeg",
                          ),
                        );
                      },
                    ).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [0, 1, 2].asMap().entries.map((entry) {
                      return InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                          width: 10.0,
                          height: 10.0,
                          padding: const EdgeInsets.all(1),
                          margin: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade200,
                            border: Border.all(color: Colors.black26),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 2,
                                  spreadRadius: 2)
                            ],
                          ),
                          child: CircleAvatar(
                            backgroundColor: _current == entry.key
                                ? AppColor.primary
                                : Colors.grey.shade200,
                          ),
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
              const SizedBox(height: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: contentSize(size, 1250, size.width),
                    padding: EdgeInsets.symmetric(
                        horizontal: sizes(size, 20, 15), vertical: 10),
                    child: const Text(
                      "Deals of the week !",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const HomeGrid()
                ],
              ),
              Container(
                width: size.width,
                color: AppColor.btnColor,
                margin: EdgeInsets.symmetric(vertical: sizes(size, 60, 30)),
                padding: EdgeInsets.symmetric(
                  horizontal: contentSize(size, (size.width - 1250) / 2,
                      sizes(size, 25, size.width > 450 ? 30 : 10)),
                  vertical: sizes(size, 25, 15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (size.width > 450)
                      CircleAvatar(
                        radius: sizes(size, 50, 30),
                        backgroundColor: Colors.white,
                        child: Image.asset(
                          AppImage.email,
                          width: sizes(size, 60, 30),
                        ),
                      ),
                    if (size.width > 450) SizedBox(width: sizes(size, 30, 15)),
                    SizedBox(
                      width: sizes(
                          size,
                          500,
                          size.width > 450
                              ? size.width - 135
                              : size.width - 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Subscribe now to stay informed and updated "
                            "about exclusive offers and new products.",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                    width: sizes(
                                        size,
                                        400,
                                        size.width > 450
                                            ? size.width - 250
                                            : size.width - 70),
                                    height: 50,
                                    child: TextField(
                                      controller: controller,
                                      decoration: const InputDecoration(
                                        hintText: "Enter your email...",
                                        border: InputBorder.none,
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 15),
                                      ),
                                    )),
                                Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(6),
                                      bottomRight: Radius.circular(6),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Text(
                                    size.width > 500 ? "Subscribe" : "📨",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: contentSize(size, 1250, size.width),
                    padding: EdgeInsets.symmetric(
                        horizontal: sizes(size, 20, 15), vertical: 10),
                    child: const Text(
                      "New Arrivals !",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const HomeGrid()
                ],
              ),
              const SizedBox(height: 50),
              const FooterBoard(false)
            ],
          ),
        ),
      ),
    );
  }
}
