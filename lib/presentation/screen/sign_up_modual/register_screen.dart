import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:three_connects/presentation/widgets/custom_widgets.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_validators.dart';
import '../../../utils/helper.dart';
import '../../widgets/footer.dart';

class RegisterScreen extends StatefulWidget {
  final String mobile;

  const RegisterScreen({Key? key, required this.mobile}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool agreeCheckboxValue = true;

  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // FilePickerResult? image;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: size.width <= 700
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {});
                                },
                                icon: const Icon(
                                  Icons.arrow_back_ios_new,
                                  color: AppColor.primary,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                "Create Account",
                                style: TextStyle(color: AppColor.primary, letterSpacing: 0, fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          textField(
                            controller: fnameController,
                            name: "First Name",
                          ),
                          textField(
                            controller: lnameController,
                            name: "last Name",
                          ),
                          textField(
                            controller: emailController,
                            name: "Email",
                          ),
                          textField(
                            controller: dobController,
                            name: "Date of Birth",
                            onTap: () async {
                              await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      builder: (context, child) {
                                        return Theme(
                                          data: ThemeData.light().copyWith(
                                            colorScheme: const ColorScheme.light(
                                                // change the border color

                                                primary: AppColor.primary,
                                                // change the text color
                                                onSurface: Colors.black,
                                                background: Color(0xFFF5F1EE)),
                                            // button colors
                                            buttonTheme: const ButtonThemeData(
                                              colorScheme: ColorScheme.light(
                                                // change the border color

                                                primary: AppColor.primary,
                                                // change the text color
                                                onSurface: Colors.black,
                                              ),
                                            ),
                                          ),
                                          child: child!,
                                        );
                                      },
                                      firstDate: DateTime.now().subtract(const Duration(days: 27275)),
                                      lastDate: DateTime.now()) //what will be the up to supported date in picker
                                  .then((pickedDate) {
                                //then usually do the future job
                                if (pickedDate == null) {
                                  //if user tap cancel then this function will stop
                                  return;
                                }
                                setState(() {

                                  var startdate0 = DateFormat('dd-MM-yyyy').format(pickedDate);

                                  dobController.text = startdate0;
                                });
                              });
                            },
                          ),
                          textField(
                            controller: cityController,
                            name: "City",
                          ),
                          textField(
                              controller: stateController,
                              name: "State",
                              onTap: () {
                                _showListState(context);
                              }),
                          textField(
                            controller: pincodeController,
                            name: "Pincode",
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Checkbox(
                                  value: agreeCheckboxValue,
                                  onChanged: (value) {
                                    setState(() {
                                      agreeCheckboxValue = value ?? false;
                                    });
                                  }),
                              Expanded(
                                child: Text.rich(TextSpan(children: [
                                  const TextSpan(
                                    text: "By signing up you agree our ",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                      text: "Conditions",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: AppColor.primary,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          // commonLaunchURL(Uri.parse(
                                          //     "https://makeupcentral.in/terms-and-conditions.php"));
                                          // Navigator.pushNamed(context, "/terms-and-conditions");
                                        }),
                                  const TextSpan(
                                    text: " and ",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                      text: " Privacy Policy.",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: AppColor.primary,
                                      ),
                                      recognizer: TapGestureRecognizer()..onTap = () {}),
                                ])),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: InkWell(
                              onTap: !agreeCheckboxValue
                                  ? () {
                                      commonToast(context,
                                          "You must agree our Terms & Conditions and Privacy Policy before signing up");
                                    }
                                  : () {
                                      if (!_formKey.currentState!.validate()) {
                                        commonToast(context, "Please fix the errors above!!");
                                        return;
                                      }

                                      if (_formKey.currentState!.validate()) {
                                        EasyLoading.show();
                                      }
                                    },
                              child: Container(
                                height: 50,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: !agreeCheckboxValue ? Colors.grey.shade500 : AppColor.primary,
                                    borderRadius: const BorderRadius.all(Radius.circular(15))),
                                child: Center(
                                  child: Text(
                                    ("Sign Up"),
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: !agreeCheckboxValue ? Colors.grey.shade300 : Colors.white,
                                        letterSpacing: 0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30)
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: size.width / 1.5 + 45,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {});
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back_ios_new,
                                    color: AppColor.primary,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  "Create Account",
                                  style: TextStyle(color: AppColor.primary, letterSpacing: 0, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              textField(
                                controller: fnameController,
                                name: "First Name",
                                width: size.width / 3,
                              ),
                              const SizedBox(width: 20),
                              textField(
                                controller: lnameController,
                                name: "last Name",
                                width: size.width / 3,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              textField(
                                controller: emailController,
                                name: "Email",
                                width: size.width / 3,
                              ),
                              const SizedBox(width: 20),
                              textField(
                                controller: dobController,
                                name: "Date of Birth",
                                width: size.width / 3,
                                onTap: () async {
                                  await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          builder: (context, child) {
                                            return Theme(
                                              data: ThemeData.light().copyWith(
                                                colorScheme: const ColorScheme.light(
                                                    // change the border color

                                                    primary: AppColor.primary,
                                                    // change the text color
                                                    onSurface: Colors.black,
                                                    background: Color(0xFFF5F1EE)),
                                                // button colors
                                                buttonTheme: const ButtonThemeData(
                                                  colorScheme: ColorScheme.light(
                                                    // change the border color

                                                    primary: AppColor.primary,
                                                    // change the text color
                                                    onSurface: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              child: child!,
                                            );
                                          },
                                          firstDate: DateTime.now().subtract(const Duration(days: 27275)),
                                          lastDate: DateTime.now()) //what will be the up to supported date in picker
                                      .then((pickedDate) {
                                    //then usually do the future job
                                    if (pickedDate == null) {
                                      //if user tap cancel then this function will stop
                                      return;
                                    }
                                    setState(() {
                                      var startdate = DateFormat('dd-MM-yyyy').format(pickedDate);

                                      dobController.text = startdate;
                                    });
                                  });
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textField(
                                controller: cityController,
                                name: "City",
                                width: size.width / 3,
                              ),
                              const SizedBox(width: 20),
                              textField(
                                  controller: stateController,
                                  name: "State",
                                  width: size.width / 3,
                                  onTap: () {
                                    _showListState(context);
                                  }),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textField(
                                controller: pincodeController,
                                name: "Pincode",
                                width: size.width / 3,
                              ),
                              SizedBox(width: size.width / 3 + 20)
                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Checkbox(
                                  value: agreeCheckboxValue,
                                  onChanged: (value) {
                                    setState(() {
                                      agreeCheckboxValue = value ?? false;
                                    });
                                  }),
                              Text.rich(TextSpan(children: [
                                const TextSpan(
                                  text: "By signing up you agree our ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                    text: "Conditions",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColor.primary,
                                    ),
                                    recognizer: TapGestureRecognizer()..onTap = () {}),
                                const TextSpan(
                                  text: " and ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                    text: " Privacy Policy.",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColor.primary,
                                    ),
                                    recognizer: TapGestureRecognizer()..onTap = () {}),
                              ])),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomInkWell(
                                onTap: (){},
                                child: Container(
                                  height: 50,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: !agreeCheckboxValue ? Colors.grey.shade500 : AppColor.primary,
                                      borderRadius: const BorderRadius.all(Radius.circular(15))),
                                  child: Center(
                                    child: Text(
                                      ("Sign Up"),
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: !agreeCheckboxValue ? Colors.grey.shade300 : Colors.white,
                                          letterSpacing: 0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30)
                        ],
                      ),
              ),
              const SizedBox(
                height: 450,
                child: FooterBoard(true),
              )
            ],
          ),
        ),
      ),
    );
  }

  _showListState(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Text(
              'Select State',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            actions: [
              InkWell(
                onTap: () {
                  pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
            content: SizedBox(
              width: 300,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: statesListTitles.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                      statesListTitles[index],
                      style: const TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w400),
                    ),
                    onTap: () {
                      setState(() {
                        stateController.text = statesListTitles[index];
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          );
        });
  }

  textField(
      {required TextEditingController controller,
      String? hint,
      required String name,
      TextInputType? keyboard,
      Function? onTap,
      double? width,
      Function(String value)? onChange}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(color: AppColor.primary, letterSpacing: 0, fontSize: 16),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: width,
          child: TextFormField(
            controller: controller,
            onTap: () {
              if (onTap != null) {
                onTap();
              }
            },
            onChanged: (String value) {
              if (onChange != null) {
                onChange(value);
              }
            },
            keyboardType: keyboard ?? TextInputType.name,
            inputFormatters: [if (name != "Email") UpperCaseTextFormatter()],
            decoration: InputDecoration(
              hintText: hint ?? '',
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: AppColor.primary),
                borderRadius: BorderRadius.circular(8),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: AppColor.primary),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: AppColor.primary),
                borderRadius: BorderRadius.circular(8),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: AppColor.primary),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            validator: Validators.commonString,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  List<String> statesListTitles = [
    "Maharashtra",
    "Karnataka",
    "Andhra Pradesh",
    "Gujarat",
    "Andaman and Nicobar Island (UT)",
    "Arunachal Pradesh",
    "Assam",
    "Bihar",
    "Chandigarh (UT)",
    "Chhattisgarh",
    "Dadra and Nagar Haveli (UT)",
    "Daman and Diu (UT)",
    "Delhi (NCT)",
    "Goa",
    "Haryana",
    "Himachal Pradesh",
    "Jammu and Kashmir",
    "Jharkhand",
    "Kerala",
    "Lakshadweep (UT)",
    "Madhya Pradesh",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Puducherry (UT)",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttar Pradesh",
    "Uttarakhand",
    "West Bengal"
  ];
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: capitalize(newValue.text),
      selection: newValue.selection,
    );
  }
  String capitalize(String value) {
    if (value.trim().isEmpty) return "";
    return "${value[0].toUpperCase()}${value.substring(1).toLowerCase()}";
  }
}
