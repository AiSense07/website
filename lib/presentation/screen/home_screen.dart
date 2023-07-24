import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_network/image_network.dart';
import 'package:three_connects/presentation/screen/custom_widgets/home_gridview.dart';
import 'package:three_connects/presentation/widgets/appbar.dart';
import 'package:three_connects/presentation/widgets/custom_widgets.dart';
import 'package:three_connects/presentation/widgets/footer.dart';
import 'package:three_connects/utils/app_image.dart';
import '../../utils/app_color.dart';
import '../widgets/loader/image_loader.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  TextEditingController controller = TextEditingController();
  ScrollController scroll = ScrollController();

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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
      backgroundColor: Colors.white,
      body: ListView(
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
                      child: ImageNetwork(
                        fitWeb: BoxFitWeb.cover,
                        height: sizes(size, 500, size.width * 0.7),
                        width: size.width,
                        image: "https://www.3dnatives.com/en/wp-content/uploads/sites/2/2021/06/filamentcove.jpeg",
                        onLoading: ImageLoader(
                          height: sizes(size, 500, size.width * 0.7),
                          width: size.width,
                          radius: 15,
                        ),
                        onError: const Icon(Icons.image_not_supported_outlined),
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
                        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2, spreadRadius: 2)],
                      ),
                      child: CircleAvatar(
                        backgroundColor: _current == entry.key ? AppColor.primary : Colors.grey.shade200,
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
                padding: EdgeInsets.symmetric(horizontal: sizes(size, 20, 15), vertical: 10),
                child: Text(
                  "Deals of the week",
                  style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w700),
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
              horizontal: contentSize(size, (size.width - 1250) / 2, sizes(size, 25, size.width > 450 ? 30 : 10)),
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
                  width: sizes(size, 500, size.width > 450 ? size.width - 135 : size.width - 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Subscribe now to stay informed and updated "
                        "about exclusive offers and new products.",
                        style: GoogleFonts.poppins(
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
                                width: sizes(size, 400, size.width > 450 ? size.width - 250 : size.width - 70),
                                height: 50,
                                child: TextField(
                                  controller: controller,
                                  decoration: InputDecoration(
                                    hintText: "Enter your email...",
                                    border: InputBorder.none,
                                    hintStyle: GoogleFonts.poppins(color: Colors.white),
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                  ),
                                )),
                            Container(
                              alignment: Alignment.center,
                              height: 40,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(6),
                                  bottomRight: Radius.circular(6),
                                ),
                                color: Colors.white,
                              ),
                              child: Text(
                                size.width > 500 ? "Subscribe" : "📨",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: AppColor.primary,
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
                padding: EdgeInsets.symmetric(horizontal: sizes(size, 20, 15), vertical: 10),
                child: Text(
                  "New in the shop",
                  style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w700),
                ),
              ),
              const HomeGrid()
            ],
          ),
          const SizedBox(height: 50),
          const FooterBoard(false)
        ],
      ),
    );
  }
}
