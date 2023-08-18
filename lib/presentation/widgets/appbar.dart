import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import 'package:three_connects/presentation/screen/sign_up_modual/signup_screen.dart';
import 'package:three_connects/presentation/widgets/common_text.dart';
import 'package:three_connects/presentation/widgets/custom_widgets.dart';
import 'package:three_connects/utils/app_color.dart';
import 'package:three_connects/utils/app_image.dart';
import 'package:three_connects/utils/helper.dart';
import 'package:three_connects/utils/navigation_string.dart';
import 'package:three_connects/utils/value_notifier.dart';

class CommonAppbar extends StatefulWidget {
  final bool isShadow;

  const CommonAppbar({Key? key, this.isShadow = true}) : super(key: key);

  @override
  State<CommonAppbar> createState() => _CommonAppbarState();
}

class _CommonAppbarState extends State<CommonAppbar> {
  String tab = '';
  String route = '';
  String search = "";
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0), () {
      String path = Uri.base.path.split("/").last;
      setState(() {
        route = path == "" ? "Home" : Uri.base.path.replaceAll("%20", " ").replaceAll("/", "");
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          width: size.width,
          alignment: Alignment.center,
          color: AppColor.primary,
          padding: const EdgeInsets.all(8),
          child: Text(
            "For Best offer Whatsapp on 1234567890.",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: size.width > 830
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (size.width > 290) Image.asset(AppImage.logo, width: 80),
                    searchTextField(400, size),
                    loginBtn(() {}, size),
                  ],
                )
              : Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (size.width > 290) Image.asset(AppImage.logo, width: 60),
                        loginBtn(() {}, size),
                      ],
                    ),
                    const SizedBox(height: 15),
                    searchTextField(size.width - 180, size),
                  ],
                ),
        ),
        Container(
          height: 42,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: widget.isShadow ? Colors.black.withOpacity(0.2) : Colors.transparent,
                blurRadius: 5,
                spreadRadius: 3,
                offset: const Offset(0, 3),
              ),
            ],
            color: AppColor.primary,
          ),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            scrollDirection: Axis.horizontal,
            children: [
              textButton(page: "/", text: "Home"),
              textButton(page: "3d-printed-parts", text: "3D Printed Part"),
              textButton(page: Routes.design, text: "3D Model"),
              textButton(page: Routes.spare, text: "Spares"),
            ],
          ),
        )
      ],
    );
  }
  Widget textButton({required String page, required String text}) {
    return InkWell(
      onTap: () {
        if (page == "/") {
          context.beamToNamed("/$page");
        } else {
          context.beamToNamed("/$page?page=0");
        }
      },
      onHover: (value) {
        if (value) {
          setState(() {
            tab = text;
          });
        } else {
          setState(() {
            tab = '';
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        color: route == text
            ? AppColor.btnColor
            : tab == text
                ? AppColor.btnColor.withOpacity(0.5)
                : Colors.transparent,
        padding: const EdgeInsets.all(12),
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: "pop",
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget searchTextField(double width, Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.primary),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              SizedBox(
                  width: width,
                  height: 40,
                  child: TextField(
                    controller: controller,
                    onChanged: (value) {
                      setState(() {
                        search = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Search Product",
                      border: InputBorder.none,
                      isDense: true,
                      suffixIcon: search.isEmpty
                          ? const SizedBox()
                          : InkWell(
                              onTap: () {
                                setState(() {
                                  search = "";
                                  controller.clear();
                                });
                              },
                              child: const Icon(Icons.close),
                            ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    ),
                  )),
              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 7),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(6), bottomRight: Radius.circular(6)),
                  color: AppColor.primary,
                ),
                child: const Icon(Icons.search, color: Colors.white),
              ),
            ],
          ),
        ),
        if (size.width < 830) sellBtn()
      ],
    );
  }

  Widget loginBtn(Function onTap, Size size) {
    return Row(
      children: [
        InkWell(
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            isCart.value = false;
            Scaffold.of(context).openEndDrawer();
            // showDialog(
            //   context: context,
            //   builder: (context) {
            //     return AlertDialog(
            //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            //       contentPadding: EdgeInsets.zero,
            //       content: const SignUpScreen(),
            //     );
            //   },
            // );
            // context.beamToNamed("/${Routes.login}");
            onTap();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            margin: const EdgeInsets.only(right: 8),
            color: Colors.transparent,
            child: const Row(
              children: [
                Text(
                  "Login ",
                  style: TextStyle(
                    fontFamily: "pop",
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                Icon(Icons.person_2_outlined)
              ],
            ),
          ),
        ),
        IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_outline)),
        const SizedBox(width: 8),
        IconButton(
          onPressed: () {
            isCart.value = true;
            Scaffold.of(context).openEndDrawer();
          },
          icon: const Icon(Icons.shopping_cart_outlined),
        ),
        const SizedBox(width: 8),
        if (size.width >= 830) sellBtn()
      ],
    );
  }

  Widget sellBtn() {
    return CustomInkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColor.primary, width: 2),
          color: const Color(0xFFD7D7F6),
        ),
        child: Texts.headingText(
          text: "+ SELL",
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
