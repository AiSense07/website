import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:three_connects/presentation/screen/sign_up_modual/register_screen.dart';
import 'package:three_connects/presentation/widgets/common_text.dart';
import 'package:three_connects/presentation/widgets/custom_widgets.dart';
import 'package:three_connects/utils/helper.dart';

import '../../../utils/app_color.dart';
import '../../../utils/app_validators.dart';
import '../../widgets/custom_btn.dart';

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

  String screen = "Login";

  requestOtp() {
    controller.loading();
    Future.delayed(const Duration(seconds: 1), () {
      controller.startTimer();
    });
  }

  TextEditingController mobile = TextEditingController();
  bool isMobileValid = false;
  bool isOTPScreen = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height > 450 ? 432 : size.height * 0.7,
      width: 450,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        children: [
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
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              btnContainer(size, "Signup"),
              btnContainer(size, "Login"),
            ],
          ),
          Row(
            children: [
              if (!isOTPScreen && screen != "Signup")
                CustomInkWell(
                  onTap: () {
                    setState(() {
                      isOTPScreen = true;
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
              if (screen != "Signup")
                Container(
                  width: size.width > 450 ? 300 : size.width * 0.5,
                  margin: const EdgeInsets.only(top: 10),
                  child: Text(
                    isOTPScreen
                        ? "Please enter mobile number to Login yourself."
                        : "Please enter the OTP received to "
                            "your mobile number +91 ${mobile.text}",
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
          ),
          const SizedBox(height: 15),
          Container(
            // height: isRegisterScreen ? 650 : 250,
            width: 350,
            decoration: const BoxDecoration(color: Colors.transparent),
            child: screen == "Signup"
                ? const RegisterScreen(mobile: "mobile")
                : isOTPScreen
                    ? phoneNumberScreen()
                    : verifyOTPScreen(),
          ),
        ],
      ),
    );
  }

  Widget btnContainer(Size size, String text) {
    return CustomInkWell(
      onTap: () {
        setState(() {
          screen = text;
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
            color: screen == text ? AppColor.primary : Colors.transparent,
            width: size.width > 450 ? 100 : size.width * 0.25,
          )
        ],
      ),
    );
  }

  bool agreeCheckboxValue = true;

  Widget phoneNumberScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Phone No.",
          style: TextStyle(
            color: AppColor.primary,
            letterSpacing: 0,
          ),
        ),
        const SizedBox(height: 5),
        Stack(
          children: [
            SizedBox(
              height: 45,
              child: TextFormField(
                controller: mobile,
                maxLength: 10,
                validator: Validators.phoneNumber,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  hintText: '9123123123',
                  prefixText: '       ',
                  counterText: '',
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
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12.2),
              child: Text("+91"),
            )
          ],
        ),
        const SizedBox(height: 20),
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
              child: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: "I have read and agree to the ",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                        text: "Terms and Conditions.",
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColor.primary,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {}),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        CustomInkWell(
          onTap: () {
            setState(() {
              isOTPScreen = false;
            });
          },
          child: Container(
            height: 40,
            width: 150,
            decoration: BoxDecoration(
              color: !agreeCheckboxValue ? Colors.grey.shade500 : AppColor.primary,
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: Center(
              child: Text(
                "Get OTP",
                style: TextStyle(
                  fontSize: 16,
                  color: !agreeCheckboxValue ? Colors.grey.shade300 : Colors.white,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget verifyOTPScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: PinCodeTextField(
            // controller: otp,
            appContext: context,
            pastedTextStyle: TextStyle(
              color: Colors.green.shade600,
              fontWeight: FontWeight.bold,
            ),
            length: 4,
            blinkWhenObscuring: true,
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
              inactiveFillColor: Colors.white,
              inactiveColor: Colors.black.withOpacity(0.5),
              activeColor: Colors.transparent,
              selectedFillColor: AppColor.primary.withOpacity(0.1),
              selectedColor: AppColor.primary,
              shape: PinCodeFieldShape.box,
              fieldHeight: 50,
              fieldWidth: 40,
              activeFillColor: Colors.black12,
              borderRadius: BorderRadius.circular(10),
            ),
            cursorColor: Colors.black,
            enableActiveFill: true,
            animationDuration: const Duration(milliseconds: 300),
            keyboardType: TextInputType.phone,
            onChanged: (String value) {},
          ),
        ),
        Center(
          child: Text(
            "Haven't received the verification code?",
            style: TextStyle(fontSize: 13, color: Colors.black.withOpacity(0.6)),
          ),
        ),
        // const Spacer(),
        Center(
          child: OtpTimerButton(
            loadingIndicatorColor: AppColor.primary,
            backgroundColor: AppColor.primary,
            buttonType: ButtonType.text_button,
            controller: controller,
            onPressed: () async {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Otp sent successfully"),
                backgroundColor: AppColor.primary,
              ));
              requestOtp();
            },
            text: const Text(
              "Resend Otp",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            duration: 30,
          ),
        ),
        CustomBtn(
          width: 150,
          radius: 10,
          btnColor: AppColor.primary,
          size: MediaQuery.of(context).size,
          title: "Submit",
          onTap: () {
            pop(context);
          },
        )
      ],
    );
  }
}
