import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:three_connects/presentation/widgets/common_text.dart';
import 'package:three_connects/presentation/widgets/custom_widgets.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_validators.dart';
import '../../../utils/helper.dart';
import '../../../utils/value_notifier.dart';
import '../../widgets/text_input.dart';

class RegisterScreen extends StatefulWidget {
  final String mobile;

  const RegisterScreen({Key? key, required this.mobile}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool agreeCheckboxValue = false;

  bool isEmailVerify = false;
  bool isMobileVerify = false;

  TextEditingController fnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController emailOtp = TextEditingController();
  TextEditingController mobileOtp = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Create your Account.",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.black45,
                  letterSpacing: 0,
                ),
              ),
              const SizedBox(height: 15),
              RegisterTextField(
                  controller: fnameController,
                  name: "Full Name",
                  validator: Validators.commonString),
              Stack(
                alignment: Alignment.topRight,
                children: [
                  RegisterTextField(
                    controller: emailController,
                    name: "Email",
                    isEmail: true,
                    keyboard: TextInputType.emailAddress,
                    validator: Validators.email,
                    pad: const EdgeInsets.only(left: 15, right: 65),
                  ),
                  verify(
                    size,
                    () {
                      final String? email = Validators.email(emailController.text);
                      if (email == null) {
                        setState(() {
                          isEmailVerify = true;
                        });
                      } else {
                        commonToast(context, email);
                      }
                    },
                    isVerify: isEmailVerify,
                  )
                ],
              ),
              if (isEmailVerify)
                RegisterTextField(
                  hint: "Email OTP",
                  controller: emailOtp,
                  name: "Please enter the OTP received to "
                      "your email id ${emailController.text}",
                ),
              const Text(
                "Mobile number",
                style: TextStyle(color: Colors.black, letterSpacing: 0, fontSize: 13),
              ),
              const SizedBox(height: 5),
              Stack(
                children: [
                  SizedBox(
                    child: TextFormField(
                      controller: mobileController,
                      maxLength: 10,
                      validator: Validators.phoneNumber,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                        hintText: '9123123123',
                        prefixText: '       ',
                        counterText: '',
                        enabledBorder: border,
                        errorBorder: border,
                        focusedBorder: border,
                        border: border,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                    child: Text("+91"),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: verify(size, () {
                      if (mobileController.text.length == 10) {
                        setState(() {
                          isMobileVerify = true;
                        });
                      } else {
                        commonToast(context, "PLease enter valid mobile no.");
                      }
                    }, pad: const EdgeInsets.only(top: 15, right: 15), isVerify: isMobileVerify),
                  )
                ],
              ),
              const SizedBox(height: 10),
              if (isMobileVerify)
                RegisterTextField(
                  hint: "Mobile OTP",
                  controller: mobileOtp,
                  name: "Please enter the OTP received to "
                      "your phone number ${mobileController.text}",
                ),
              const SizedBox(height: 10),
              if (size.width > 330)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RegisterTextField(
                      width: size.width > 450 ? 180 : size.width * 0.3,
                      controller: cityController,
                      name: "City",
                    ),
                    RegisterTextField(
                        width: size.width > 450 ? 180 : size.width * 0.3,
                        controller: stateController,
                        name: "State",
                        onTap: () {
                          _showListState(context);
                        }),
                  ],
                ),
              if (size.width <= 330)
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RegisterTextField(
                      controller: cityController,
                      name: "City",
                    ),
                    RegisterTextField(
                        controller: stateController,
                        name: "State",
                        onTap: () {
                          _showListState(context);
                        }),
                  ],
                ),
              const SizedBox(height: 5),
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
                            color: AppColor.btnColor,
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
                            color: AppColor.btnColor,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {}),
                    ])),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              InkWell(
                onTap: !agreeCheckboxValue
                    ? () {
                        commonToast(
                          context,
                          "You must agree our Terms & Conditions"
                          " and Privacy Policy before signing up",
                        );
                      }
                    : () {
                        if (!_formKey.currentState!.validate()) {
                          commonToast(context, "Please fix the errors above!!");
                          return;
                        } else if (!isEmailVerify) {
                          commonToast(context, "Please verify Email");
                          return;
                        } else if (emailOtp.text.isEmpty) {
                          commonToast(context, "Please enter otp sent to your Email");
                          return;
                        } else if (!isMobileVerify) {
                          commonToast(context, "Please verify Mobile number");
                          return;
                        } else if (mobileOtp.text.isEmpty) {
                          commonToast(context, "Please enter otp sent to your mobile number");
                          return;
                        }

                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isOtp.value = true;
                            mobile.value = mobileController.text;
                          });
                          EasyLoading.show();
                        }
                      },
                child: Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                    color: !agreeCheckboxValue ? Colors.grey.shade500 : AppColor.primary,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Center(
                    child: Text(
                      ("Sign Up"),
                      style: TextStyle(
                        fontSize: 18,
                        color: !agreeCheckboxValue ? Colors.grey.shade300 : Colors.white,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30)
            ],
          ),
        ],
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
                      style: const TextStyle(
                          color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w400),
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

  Widget verify(Size size, Function onTap, {EdgeInsets? pad, bool isVerify = false}) {
    return CustomInkWell(
      onTap: () => onTap(),
      child: Container(
        color: Colors.transparent,
        padding: pad ?? const EdgeInsets.only(top: 38, right: 15, left: 15),
        child: Texts.small13Text(
          text: isVerify ? "Re-Verify" : "Verify",
          size: size,
          fontWeight: FontWeight.bold,
          color: AppColor.btnColor,
        ),
      ),
    );
  }
}
