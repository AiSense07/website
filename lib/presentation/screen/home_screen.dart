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
import 'package:three_connects/presentation/widgets/title.dart';
import 'package:three_connects/presentation/widgets/view_all_btn.dart';
import 'package:three_connects/utils/helper.dart';
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
              child: const Icon(Icons.arrow_upward_rounded, color: Colors.white),
            )
          : const SizedBox(),
      backgroundColor: AppColor.background,
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
                          margin: const EdgeInsets.only(bottom: 5, right: 15, left: 15),
                          width: size.width,
                          color: AppColor.background,
                          child: CacheImage(
                            height: sizes(size, 500, size.width * 0.7),
                            width: size.width,
                            img: "https://www.3dnatives.com/en/wp-content/uploads/"
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
                          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade200,
                            border: Border.all(color: Colors.black26),
                            boxShadow: const [
                              BoxShadow(color: Colors.black12, blurRadius: 2, spreadRadius: 2)
                            ],
                          ),
                          child: CircleAvatar(
                            backgroundColor:
                                _current == entry.key ? AppColor.primary : Colors.grey.shade200,
                          ),
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
              const SizedBox(height: 40),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CommonTitle(title: "Deals of the week !"),
                  ViewAllBtn(),
                  HomeGrid(),
                ],
              ),
              const SizedBox(height: 100),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CommonTitle(title: "New Arrivals !"),
                  ViewAllBtn(),
                  HomeGrid(),
                ],
              ),
              const SizedBox(height: 100),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CommonTitle(title: "Shop by Brand"),
                  SizedBox(
                    width: contentSize(size, 1250, size.width),
                    child: GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: size500(size, 25, 15)),
                      shrinkWrap: true,
                      itemCount: brand.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: size.width > 1300
                              ? 8
                              : size.width > 1150
                                  ? 7
                                  : size.width > 750
                                      ? 6
                                      : size.width > 500
                                          ? 5
                                          : 3,
                          crossAxisSpacing: 15,
                          childAspectRatio: 1.2),
                      itemBuilder: (context, index) {
                        return CustomInkWell(
                          onTap: (){},
                          child: Image.network(brand[index]),
                        );
                      },
                    ),
                  ),
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
