import 'package:flutter/material.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:three_connects/presentation/screen/sign_up_modual/login_screen.dart';
import 'package:three_connects/presentation/screen/sign_up_modual/set_pass_screen.dart';
import 'package:three_connects/presentation/screen/sign_up_modual/register_screen.dart';
import 'package:three_connects/presentation/widgets/common_text.dart';
import 'package:three_connects/presentation/widgets/custom_widgets.dart';
import 'package:three_connects/utils/helper.dart';

import '../../../utils/app_color.dart';
import '../../../utils/value_notifier.dart';

class SignUpScreen extends StatefulWidget {
  final bool isLogout;

  const SignUpScreen({Key? key, this.isLogout = false}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  OtpTimerButtonController controller = OtpTimerButtonController();
  TextEditingController otp = TextEditingController();

  bool iosOtpSend = false;

  @override
  void initState() {
    isOtp.value = false;
    screen.value = "Login";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
      width: 450,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  color: AppColor.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Texts.headingText(
            text: "Welcome to 3D Connect!",
            fontWeight: FontWeight.bold,
            fontFamily: "bold",
            maxLine: 2,
            fontSize: 22,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Texts.small13Text(
            size: size,
            text: "We take pride in offering"
                " a wide range of top-notch 3D printer parts, "
                "carefully selected to meet the needs of both "
                "professionals and hobbyists.",
            maxLine: 10,
            color: Colors.black45,
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              btnContainer(size, "Signup"),
              btnContainer(size, "Login"),
            ],
          ),
          ValueListenableBuilder(
              valueListenable: isOtp,
              builder: (context, otp, value) {
                return Row(
                  children: [
                    if (otp)
                      CustomInkWell(
                        onTap: () {
                          setState(() {
                            isOtp.value = false;
                          });
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: AppColor.primary,
                          ),
                        ),
                      ),
                    if ((screen.value) != "Signup" || otp)
                      Container(
                        width: size.width > 450 ? 300 : size.width * 0.5,
                        margin: const EdgeInsets.only(top: 10),
                        child: Text(
                          !otp
                              ? "Please enter mobile number or email to Login yourself."
                              : "Please enter the 8 digit New Password to protect your account.",
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black45,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                  ],
                );
              }),
          const SizedBox(height: 15),
          ValueListenableBuilder(
              valueListenable: isOtp,
              builder: (context, value, _) {
                return Container(
                  width: 350,
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: (screen.value) == "Signup"
                      ? value
                          ? const SetPassScreen()
                          : const RegisterScreen(mobile: "mobile")
                      : const LoginScreen(),
                );
              }),
        ],
      ),
    );
  }

  Widget btnContainer(Size size, String text) {
    return CustomInkWell(
      onTap: () {
        setState(() {
          screen.value = text;
          isOtp.value = false;
        });
      },
      child: Column(
        children: [
          Texts.headingText(
            text: text,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          const SizedBox(height: 5),
          Container(
            height: 1.5,
            color: (screen.value) == text ? AppColor.primary : Colors.transparent,
            width: size.width > 450 ? 100 : size.width * 0.25,
          )
        ],
      ),
    );
  }
}
