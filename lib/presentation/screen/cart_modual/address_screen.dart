import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:three_connects/presentation/screen/cart_modual/edit_address.dart';
import 'package:three_connects/utils/app_color.dart';
import 'package:three_connects/utils/navigation_string.dart';

import '../../../utils/helper.dart';
import '../../widgets/common_text.dart';
import 'cart_screen.dart';

class AddressScreen extends StatefulWidget {
  final String userId;
  final bool isCartScreen;
  final int? totalPrice;
  final int length;
  final Widget? widget;

  const AddressScreen({
    Key? key,
    required this.userId,
    required this.isCartScreen,
    this.widget,
    this.totalPrice,
    required this.length,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  String payment = "COD";

  @override
  void initState() {
    super.initState();
  }

  int selectedIndex = 0;
  String addressId = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 1,
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemBuilder: (BuildContext context, int index) {
                      // addressId = state.addressList.first.addressesId;
                      return InkWell(
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width < 350 ? size.width * 0.01 : 15, vertical: 10),
                          margin: const EdgeInsets.only(top: 15),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: size.width > 450 ? 10 : size.width * 0.03,
                                backgroundColor: Colors.black.withOpacity(0.1),
                                child: !widget.isCartScreen
                                    ? Text(
                                        '${index + 1}',
                                        style: const TextStyle(color: Colors.black, fontSize: 14),
                                      )
                                    : CircleAvatar(
                                        radius: size.width > 450 ? 7 : size.width * 0.017,
                                        backgroundColor: selectedIndex == index
                                            ? AppColor.primary
                                            : Colors.black.withOpacity(0.1),
                                      ),
                              ),
                              SizedBox(width: size.width < 350 ? size.width * 0.01 : 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Texts.headingText(
                                    text: "Tag",
                                    fontFamily: 'bold',
                                    fontSize: 15,
                                    height: 1.4,
                                  ),
                                  const SizedBox(height: 5),
                                  Texts.headingText(
                                    text: "User Name",
                                    fontFamily: 'medium',
                                    fontSize: size.width > 450 ? 15 : 13,
                                    height: 1.4,
                                  ),
                                  const SizedBox(height: 2),
                                  SizedBox(
                                    width: size.width > 450 ? 300 : size.width * 0.62,
                                    child: Texts.headingText(
                                      text: "47, surat society, surat, Gujarat.",
                                      fontFamily: 'medium',
                                      fontSize: size.width > 450 ? 15 : 13,
                                      fontWeight: FontWeight.w600,
                                      maxLine: 10,
                                    ),
                                  ),
                                  Texts.headingText(
                                    text: "Surat, Gujarat 395006.",
                                    fontFamily: 'medium',
                                    fontSize: size.width > 450 ? 14 : 12,
                                    height: 1.4,
                                  ),
                                  Texts.headingText(
                                    text: "Mobile no.: 9875641233",
                                    fontFamily: 'medium',
                                    fontSize: size.width > 450 ? 14 : 12,
                                    height: 1.4,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              popup(size, index),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  InkWell(
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      context.beamToNamed("/${Routes.address}");
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: size.width > 450 ? 10 : size.width * 0.03,
                            backgroundColor: Colors.black.withOpacity(0.1),
                            child: Icon(Icons.add,
                                size: size.width > 450 ? 18 : size.width * 0.05,
                                color: Colors.black),
                          ),
                          const SizedBox(width: 10),
                          Texts.headingText(
                            text: "Add new address",
                            fontFamily: 'medium',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          widget.isCartScreen
              ? cartContainer(
                  context: context,
                  length: widget.length,
                  totalPrice: widget.totalPrice.toString(),
                  onTap: () {},
                  size: size,
                  isAddressScreen: true,
                  bottomPad: MediaQuery.of(context).padding.bottom + 10)
              : const SizedBox()
        ],
      ),
    );
  }

  popup(Size size, int index) {
    return PopupMenuButton(
      tooltip: '',
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: AppColor.primary,
      icon: Icon(Icons.more_vert, color: Colors.black.withOpacity(0.5)),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: customContainer(
              size: size,
              name: "Edit address",
              icon: Icons.edit,
              color: Colors.white,
              onTap: () {
                context.beamToNamed("/${Routes.address}");
              }),
        ),
        PopupMenuItem(
          child: customContainer(
              size: size,
              name: "Delete address",
              icon: Icons.delete,
              color: Colors.red,
              onTap: () async {
                pop(context);
              }),
        ),
      ],
    );
  }
}

Widget customContainer({
  required String name,
  required IconData icon,
  required Color color,
  required Function onTap,
  required Size size,
}) {
  return InkWell(
    hoverColor: Colors.transparent,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    onTap: () {
      onTap();
    },
    child: Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: size.width > 450 ? 22 : size.width * 0.06,
          ),
          const SizedBox(width: 15),
          Text(
            name,
            style: TextStyle(
                fontSize: size.width > 450 ? 15 : size.width * 0.045, color: Colors.white),
          )
        ],
      ),
    ),
  );
}
