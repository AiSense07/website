import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:three_connects/utils/app_color.dart';

import '../../utils/helper.dart';

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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColor.primary,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: responsivePaddingWidth(constraints, context),
          ),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Center(
                child: Text(
                  "Welcome to 3D Connects!",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        fontSize: constraints.maxWidth <= 900 ? 25 : 32,
                      ),
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
                  style: GoogleFonts.poppins(color: Colors.white, letterSpacing: 1, fontSize: constraints.maxWidth <= 900 ? 12 : 15),
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
              widget.isHideFooter == true ? const SizedBox(height: 1) : Container(height: 1.5, color: Color(0xFFEADACE)),
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
                                      style: GoogleFonts.poppins(fontWeight: FontWeight.w900, color: Colors.white, fontSize: constraints.maxWidth <= 900 ? 25 : 32),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      "2nd Floor, SBR CV Towers, HUDA Techno Enclave, Madhapur, Hyderabad. 500081. ",
                                      style: GoogleFonts.poppins(color: Colors.white.withOpacity(0.8), letterSpacing: 1, fontSize: constraints.maxWidth <= 900 ? 13 : 13),
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
                                  Text(
                                    "Company",
                                    style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
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
                                              // pushReplacement(context, const HomeScreen("Home"));
                                            } else if (index == 1) {
                                              // await AppDialog.aboutUs(context);
                                            } else if (index == 2) {
                                              // await AppDialog.contactUs(context, MediaQuery.of(context).size);
                                            }
                                          },
                                          onHover: (value) {
                                            if(value){
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
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              color: Colors.white.withOpacity(0.8),
                                              decoration: company == index ? TextDecoration.underline : TextDecoration.none,
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
                                  Text(
                                    "Informations",
                                    style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
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
                                              Navigator.pushNamed(context, "/refund-and-cancellation");
                                            }
                                          },
                                          onHover: (value) {
                                            if(value){
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
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white.withOpacity(0.8),
                                              decoration: info == index ? TextDecoration.underline : TextDecoration.none,
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
                                    style: GoogleFonts.poppins(fontSize: constraints.maxWidth <= 900 ? 25 : 30, fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    "2nd Floor, SBR CV Towers, HUDA Techno Enclave, Madhapur, Hyderabad. 500081. ",
                                    style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          letterSpacing: 1,
                                          fontSize: constraints.maxWidth <= 900 ? 13 : 13,
                                        ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                            ],
                          ),
                        ),
              const SizedBox(height: 30),
              widget.isHideFooter == true ? const SizedBox(height: 1) : Container(height: 1.5, color: const Color(0xFFEADACE)),
              const SizedBox(height: 5),
              // const Spacer(),
              Center(
                child: Text(
                  "© 2023 3D Connects. All Rights Reserved",
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              ),
              // const Spacer(),
            ],
          ),
        );
      },
    );
  }
}
