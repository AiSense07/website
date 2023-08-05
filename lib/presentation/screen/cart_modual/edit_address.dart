import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:three_connects/presentation/widgets/custom_widgets.dart';
import 'package:three_connects/utils/app_color.dart';
import '../../../utils/helper.dart';
import '../../widgets/appbar.dart';
import '../../widgets/common_text.dart';
import '../../widgets/custom_btn.dart';
import '../../widgets/footer.dart';
import '../../widgets/show_state.dart';
import '../../widgets/text_input.dart';
import 'cart_screen.dart';

class EditAddress extends StatefulWidget {
  final String addressID, address, landmark, tag;
  final bool isUpdate;
  final int? index;

  const EditAddress({
    super.key,
    required this.addressID,
    required this.address,
    required this.landmark,
    required this.tag,
    this.isUpdate = false,
    this.index,
  });

  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final mobile = TextEditingController();
  final addressController = TextEditingController();
  final area = TextEditingController();
  final landmark = TextEditingController();
  final pinCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final tagController = TextEditingController();

  String? latitude, longitude;

  final homeScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    setState(() {
      addressController.text = widget.address;
      landmark.text = widget.landmark;
      tagController.text = widget.tag;
    });
  }

  final GlobalKey<ScaffoldState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    log("${size.width}");
    return Scaffold(
      endDrawer: const CartScreen(),
      body: SafeArea(
        child: Column(
          children: [
            const CommonAppbar(),
            Container(width: size.width * 0.9, height: 2, color: Colors.black.withOpacity(0.1)),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        width: contentSize(size, 1250, size.width),
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: Row(
                          children: [
                            Texts.headingText(
                                text: "Add/Edit Address",
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ],
                        ),
                      ),
                      size.width > 750
                          ? SizedBox(
                              width: contentSize(size, 1250, size.width),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextInput(
                                        width: contentSize(size, 550, size.width * 0.4),
                                        title: "Full name",
                                        controller: name,
                                        icon: const Icon(Icons.person),
                                        hintText: "",
                                      ),
                                      TextInput(
                                        width: contentSize(size, 550, size.width * 0.4),
                                        title: "Mobile number",
                                        textInputType: TextInputType.phone,
                                        controller: mobile,
                                        icon: const Icon(Icons.call),
                                        hintText: "e.g., 1234567890",
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextInput(
                                        width: contentSize(size, 550, size.width * 0.4),
                                        title: "Flat, House no., Building, Apartment, Company",
                                        textInputType: TextInputType.phone,
                                        controller: addressController,
                                        icon: const Icon(Icons.location_city),
                                        hintText: "e.g., 123, apartment..",
                                      ),
                                      TextInput(
                                        width: contentSize(size, 550, size.width * 0.4),
                                        title: "Area, Street, Sector, Village",
                                        controller: area,
                                        icon: const Icon(Icons.area_chart_outlined),
                                        hintText: "",
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextInput(
                                        width: contentSize(size, 550, size.width * 0.4),
                                        title: "Landmark",
                                        textInputType: TextInputType.phone,
                                        controller: landmark,
                                        icon: const Icon(Icons.landscape_rounded),
                                        hintText: "e.g., near hospital",
                                      ),
                                      TextInput(
                                        width: contentSize(size, 550, size.width * 0.4),
                                        title: "Pin code",
                                        textInputType: TextInputType.phone,
                                        controller: pinCode,
                                        icon: const Icon(Icons.pin_drop),
                                        hintText: "e.g., 123456",
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextInput(
                                        width: contentSize(size, 550, size.width * 0.4),
                                        title: "City/Town",
                                        textInputType: TextInputType.phone,
                                        controller: city,
                                        icon: const Icon(Icons.add),
                                        hintText: "",
                                      ),
                                      TextInput(
                                        width: contentSize(size, 550, size.width * 0.4),
                                        title: "State",
                                        textInputType: TextInputType.phone,
                                        controller: state,
                                        icon: const Icon(Icons.add),
                                        hintText: "",
                                        readOnly: true,
                                        onTap: () async {
                                          showDialog(
                                            context: context,
                                            builder: (context) => ShowState(
                                              onTap: (index) {
                                                setState(() {
                                                  state.text = statesListTitles[index];
                                                });
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextInput(
                                        width: contentSize(size, 550, size.width * 0.4),
                                        title: "Save As",
                                        controller: tagController,
                                        icon: const Icon(Icons.discount),
                                        hintText: "e.g., Home / Office / Delhi Home",
                                      ),
                                      SizedBox(
                                        width: contentSize(size, 550, size.width * 0.4),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 50),
                                  CustomBtn(
                                    width: 200,
                                    size: size,
                                    title: "Save",
                                    btnColor: AppColor.primary,
                                    radius: 10,
                                    onTap: () async {},
                                  ),
                                  const SizedBox(height: 100),
                                ],
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              width: size.width > 500 ? 450 : size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const SizedBox(height: 20),
                                  TextInput(
                                    title: "Full name",
                                    controller: name,
                                    icon: const Icon(Icons.person),
                                    hintText: "",
                                  ),
                                  TextInput(
                                    title: "Mobile number",
                                    textInputType: TextInputType.phone,
                                    controller: mobile,
                                    icon: const Icon(Icons.call),
                                    hintText: "e.g., 1234567890",
                                  ),
                                  TextInput(
                                    title: "Flat, House no., Building, Apartment, Company",
                                    textInputType: TextInputType.phone,
                                    controller: addressController,
                                    icon: const Icon(Icons.location_city),
                                    hintText: "e.g., 123, apartment..",
                                  ),
                                  TextInput(
                                    title: "Area, Street, Sector, Village",
                                    controller: area,
                                    icon: const Icon(Icons.area_chart_outlined),
                                    hintText: "",
                                  ),
                                  TextInput(
                                    title: "Landmark",
                                    textInputType: TextInputType.phone,
                                    controller: landmark,
                                    icon: const Icon(Icons.landscape_rounded),
                                    hintText: "e.g., near hospital",
                                  ),
                                  TextInput(
                                    title: "Pin code",
                                    textInputType: TextInputType.phone,
                                    controller: pinCode,
                                    icon: const Icon(Icons.pin_drop),
                                    hintText: "e.g., 123456",
                                  ),
                                  TextInput(
                                    title: "City/Town",
                                    textInputType: TextInputType.phone,
                                    controller: city,
                                    icon: const Icon(Icons.add),
                                    hintText: "",
                                  ),
                                  TextInput(
                                    title: "State",
                                    textInputType: TextInputType.phone,
                                    controller: state,
                                    icon: const Icon(Icons.add),
                                    hintText: "",
                                    readOnly: true,
                                    onTap: () async {
                                      showDialog(
                                        context: context,
                                        builder: (context) => ShowState(
                                          onTap: (index) {
                                            setState(() {
                                              state.text = statesListTitles[index];
                                            });
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                  TextInput(
                                    title: "Save As",
                                    controller: tagController,
                                    icon: const Icon(Icons.discount),
                                    hintText: "e.g., Home / Office / Delhi Home",
                                  ),
                                  const SizedBox(height: 50),
                                  CustomBtn(
                                    width: 200,
                                    size: size,
                                    title: "Save",
                                    btnColor: AppColor.primary,
                                    radius: 10,
                                    onTap: () async {},
                                  ),
                                  const SizedBox(height: 100),
                                ],
                              ),
                            ),
                      const FooterBoard(false)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
