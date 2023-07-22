import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:three_connects/utils/app_color.dart';
import 'package:three_connects/utils/app_image.dart';
import 'package:three_connects/utils/navigation_string.dart';

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
      setState(() {
        route = Uri.base.path == "/" ? "Home" : Uri.base.path.replaceAll("/", "").replaceAll("%20", " ");
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
          color: AppColor.primary,
          padding: const EdgeInsets.all(8),
          child: Text(
            "Welcome to 3D Connects & Get the best product",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(color: Colors.white.withOpacity(0.8), fontSize: 10),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: size.width > 750
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(AppImage.logo, width: 80),
                    searchTextField(400),
                    loginBtn(() {}),
                  ],
                )
              : Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(AppImage.logo, width: 60),
                        loginBtn(() {}),
                      ],
                    ),
                    const SizedBox(height: 15),
                    searchTextField(size.width - 90),
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
            padding: const EdgeInsets.symmetric(horizontal: 10),
            scrollDirection: Axis.horizontal,
            children: [
              textButton(page: "/", text: "Home"),
              textButton(page: Routes.spare, text: "Spare Parts & Accessories"),
              textButton(page: Routes.filament, text: "Filaments"),
              textButton(page: Routes.nozzles, text: "Nozzles"),
              textButton(page: Routes.design, text: "Design"),
            ],
          ),
        )
      ],
    );
  }

  Widget textButton({required String page, required String text}) {
    return InkWell(
      onTap: () {
        context.beamToNamed("/$page");
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
          style: GoogleFonts.oxygen(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget searchTextField(double width) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.primary),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(
              width: width,
              height: 50,
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
              borderRadius: BorderRadius.only(topRight: Radius.circular(6), bottomRight: Radius.circular(6)),
              color: AppColor.primary,
            ),
            child: const Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget loginBtn(Function onTap) {
    return Row(
      children: [
        InkWell(
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            onTap();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            margin: const EdgeInsets.only(right: 8),
            color: Colors.transparent,
            child: Row(
              children: [
                Text(
                  "Login ",
                  style: GoogleFonts.oxygen(fontSize: 14, fontWeight: FontWeight.w600, color: AppColor.primary),
                ),
                 Icon(Icons.person_outline_sharp)
              ],
            ),
          ),
        ),
        IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_outline)),
        const SizedBox(width: 8),
        IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart_outlined)),
      ],
    );
  }
}
