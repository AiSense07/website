import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:three_connects/presentation/widgets/common_text.dart';
import 'package:three_connects/utils/app_color.dart';

import '../../utils/app_image.dart';
import '../../utils/helper.dart';
import 'custom_widgets.dart';

class FooterBoard extends StatefulWidget {
  final bool isHideFooter;

  const FooterBoard([this.isHideFooter = false]);

  @override
  State<FooterBoard> createState() => _FooterBoardState();
}

List<String> companyFooterList = [
  "Home",
  "About us",
  "Contact us",
];

List<String> useFulLinkFooterList = [
  "App Store",
  "Play Store",
  "Book Appointment",
  "Register as vendor",
];

List<String> informationFooterList = [
  "Terms & Conditions",
  "Privacy Policy",
  "Disclaimer",
];

class _FooterBoardState extends State<FooterBoard> {
  int company = -1;
  int info = -1;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColor.primary,
            borderRadius:
                BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: responsivePaddingWidth(constraints, context),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: size.width,
                margin: const EdgeInsets.only(top: 25,bottom: 20),
                padding: EdgeInsets.symmetric(
                  horizontal: contentSize(
                      size, (size.width - 1250) / 2, sizes(size, 25, size.width > 450 ? 30 : 10)),
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
                      width:
                      sizes(size, 500, size.width > 450 ? size.width - 135 : size.width - 25),
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
                                    width: sizes(size, 400,
                                        size.width > 450 ? size.width - 250 : size.width - 70),
                                    height: 50,
                                    child: TextField(
                                      controller: controller,
                                      decoration: const InputDecoration(
                                        hintText: "Enter your email...",
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(color: Colors.white),
                                        isDense: true,
                                        contentPadding:
                                        EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
              Text(
                "Welcome to 3D Connects!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "pop",
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: constraints.maxWidth <= 900 ? 25 : 32,
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: responsiveBoolean(constraints, context)
                        ? 20
                        : constraints.maxWidth <= 900
                            ? 50
                            : MediaQuery.of(context).size.width * 0.1),
                child: Text(
                  "We take pride in offering"
                  " a wide range of top-notch 3D printer parts, "
                  "carefully selected to meet the needs of both "
                  "professionals and hobbyists. Our extensive collection "
                  "includes everything from essential components to "
                  "upgrade kits, ensuring you have the tools necessary to"
                  " bring your creative ideas to life.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "pop",
                    color: Colors.white70,
                    fontSize: constraints.maxWidth <= 900 ? 12 : 15,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              /*  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      // html.window.open("https://apps.apple.com/us/app/makeupcentral/id1640697780", "_blank");
                    },
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Container(
                        height: 50,
                        width: 140,
                        color: Colors.black,
                        child: Image.asset("assets/social/app.png"),
                      ),
                    ),
                  ),
                  const SizedBox(width: 27),
                  InkWell(
                    onTap: () {},
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Container(
                        height: 50,
                        width: 140,
                        color: Colors.black,
                        child: Image.asset("assets/social/playstore.png"),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),*/
              widget.isHideFooter == true
                  ? const SizedBox(height: 1)
                  : Container(height: 1.5, color: Color(0xFFEADACE)),
              widget.isHideFooter == true ? const SizedBox(height: 1) : const SizedBox(height: 30),
              widget.isHideFooter == true
                  ? const SizedBox(height: 1)
                  : constraints.maxWidth >= 850
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 50),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "3D Connects",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: "pop",
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: constraints.maxWidth <= 900 ? 25 : 32,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      "2nd Floor, SBR CV Towers, HUDA Techno "
                                      "Enclave, Madhapur, Hyderabad. 500081. ",
                                      style: TextStyle(
                                        fontFamily: "pop",
                                        color: Colors.white70,
                                        fontSize: constraints.maxWidth <= 900 ? 12 : 15,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Texts.headingText(
                                    text: "Company",
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                  const SizedBox(height: 35),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: List.generate(
                                      companyFooterList.length,
                                      (index) => Padding(
                                        padding: const EdgeInsets.only(bottom: 15),
                                        child: InkWell(
                                          onTap: () async {
                                            if (index == 0) {
                                              context.beamToNamed("/");
                                              // pushReplacement(context, const HomeScreen("Home"));
                                            } else if (index == 1) {
                                              // await AppDialog.aboutUs(context);
                                            } else if (index == 2) {
                                              // await AppDialog.contactUs(context, MediaQuery.of(context).size);
                                            }
                                          },
                                          onHover: (value) {
                                            if (value) {
                                              setState(() {
                                                company = index;
                                              });
                                            } else {
                                              setState(() {
                                                company = -1;
                                              });
                                            }
                                          },
                                          child: Text(
                                            companyFooterList[index],
                                            style: TextStyle(
                                              fontFamily: "pop",
                                              fontSize: 14,
                                              color: Colors.white.withOpacity(0.8),
                                              decoration: company == index
                                                  ? TextDecoration.underline
                                                  : TextDecoration.none,
                                              decorationColor: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Texts.headingText(
                                    text: "Information",
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                  const SizedBox(height: 35),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: List.generate(
                                      informationFooterList.length,
                                      (index) => Padding(
                                        padding: const EdgeInsets.only(bottom: 15),
                                        child: InkWell(
                                          onTap: () {
                                            if (index == 0) {
                                              // html.window.open(
                                              //     AppConfig.terms_and_conditions,
                                              //     "_blank");
                                              Navigator.pushNamed(context, "/terms-and-conditions");
                                            } else if (index == 1) {
                                              // html.window.open(
                                              //     AppConfig.privacy_policy,
                                              //     "_blank");
                                              Navigator.pushNamed(context, "/privacy-policy");
                                            } else if (index == 2) {
                                              Navigator.pushNamed(context, "/disclaimer");
                                            } else if (index == 3) {
                                              Navigator.pushNamed(
                                                  context, "/refund-and-cancellation");
                                            }
                                          },
                                          onHover: (value) {
                                            if (value) {
                                              setState(() {
                                                info = index;
                                              });
                                            } else {
                                              setState(() {
                                                info = -1;
                                              });
                                            }
                                          },
                                          child: Text(
                                            informationFooterList[index],
                                            style: TextStyle(
                                              fontFamily: "pop",
                                              fontSize: 14,
                                              color: Colors.white.withOpacity(0.8),
                                              decoration: info == index
                                                  ? TextDecoration.underline
                                                  : TextDecoration.none,
                                              decorationColor: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "3D Connects",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: "pop",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: constraints.maxWidth <= 900 ? 25 : 32,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    "2nd Floor, SBR CV Towers, HUDA Techno "
                                    "Enclave, Madhapur, Hyderabad. 500081. ",
                                    style: TextStyle(
                                      fontFamily: "pop",
                                      color: Colors.white70,
                                      fontSize: constraints.maxWidth <= 900 ? 12 : 15,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                            ],
                          ),
                        ),
              const SizedBox(height: 30),
              widget.isHideFooter == true
                  ? const SizedBox(height: 1)
                  : Container(height: 1.5, color: const Color(0xFFEADACE)),
              const SizedBox(height: 5),
              // const Spacer(),
              Texts.small13Text(
                size: MediaQuery.of(context).size,
                text: "© 2023 3D Connects. All Rights Reserved",
                color: Colors.white,
              ),
              // const Spacer(),
            ],
          ),
        );
      },
    );
  }
}
