
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:three_connects/presentation/widgets/custom_widgets.dart';

import '../../../utils/app_color.dart';
import '../../../utils/app_validators.dart';
import '../../widgets/custom_btn.dart';
import '../../widgets/footer.dart';

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

  requestOtp() {
    controller.loading();
    Future.delayed(const Duration(seconds: 1), () {
      controller.startTimer();
    });
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController mobile = TextEditingController();
  bool isMobileValid = false;
  bool isOTPScreen = true;
  FocusNode focusNode = FocusNode();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary.withOpacity(0.1),
      body: GestureDetector(
          onDoubleTap: () {},
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Scaffold(
                backgroundColor: Colors.white,
                body: ListView(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(25),
                      color: AppColor.primary.withOpacity(0.1),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset("assets/logo.png", height: 80),
                                  const SizedBox(height: 40),
                                  Row(
                                    children: [
                                      if (!isOTPScreen) const SizedBox(width: 5),
                                      if (!isOTPScreen)
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                isOTPScreen = true;
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.arrow_back_ios_new,
                                              color: AppColor.primary,
                                            )),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: isOTPScreen ? 20 : 8),
                                        child: Text(
                                          isOTPScreen ? "Welcome!" : "OTP Verification",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: AppColor.primary,
                                              letterSpacing: 0),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Text(
                                      isOTPScreen
                                          ? "Please enter mobile number to Login yourself."
                                          : "Please enter the OTP received to your mobile number +91 ${mobile.text}",
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Colors.black45,
                                          letterSpacing: 0),
                                    ),
                                  ),
                                  Container(
                                    // height: isRegisterScreen ? 650 : 250,
                                    width: 350,
                                    decoration: const BoxDecoration(color: Colors.transparent),
                                    child: isOTPScreen ? phoneNumberScreen() : verifyOTPScreen(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if(constraints.maxWidth > 650)
                               Expanded(
                                  flex: 2,
                                  child: Container(
                                    color: Colors.black,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset("assets/login.jpg"),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                    const FooterBoard(true)
                  ],
                ),
              );
            },
          )),
    );
  }

  bool agreeCheckboxValue = true;

  Widget phoneNumberScreen() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
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
          const SizedBox(height: 15),
          Form(
            key: _formKey,
            child: TextFormField(
                focusNode: _focusNode,
                controller: mobile,
                maxLength: 10,
                buildCounter: null,
                validator: Validators.phoneNumber,
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  hintText: _focusNode.hasFocus ? '9123123123' : '+91 9123123123',
                  prefixText: _focusNode.hasFocus
                      ? '+91 '
                      : mobile.text.isNotEmpty
                          ? '+91 '
                          : null,
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
                onChanged: (_) {
                  setState(() {});
                },
                onTap: () {
                  setState(() {});
                }),
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
                child: Text.rich(TextSpan(children: [
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
                ])),
              ),
            ],
          ),
          const SizedBox(height: 20),
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
                  "Get OTP",
                  style: TextStyle(
                      fontSize: 18, color: !agreeCheckboxValue ? Colors.grey.shade300 : Colors.white, letterSpacing: 0),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget verifyOTPScreen() {
    return Column(
      children: [
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: PinCodeTextField(
            controller: otp,
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
              fieldHeight: 64,
              fieldWidth: 50,
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
        const SizedBox(height: 15),
        Text(
          "Haven't received the verification code?",
          style: TextStyle(fontSize: 15, color: Colors.black.withOpacity(0.6)),
        ),
        // const Spacer(),
        OtpTimerButton(
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
              fontSize: 18,
            ),
          ),
          duration: 30,
        ),
          CustomBtn(
            radius: 10,
            btnColor: AppColor.primary,
            size: MediaQuery.of(context).size,
            title:  "Submit",
            onTap: () {},
          )
      ],
    );
  }
}
