import 'dart:async';
import 'package:flutter/material.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:three_connects/utils/app_color.dart';

import '../../../utils/helper.dart';
import '../../widgets/custom_btn.dart';

class OTPScreen extends StatefulWidget {
  final String mobile;

  const OTPScreen({Key? key, required this.mobile}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  OtpTimerButtonController controller = OtpTimerButtonController();
  TextEditingController otp = TextEditingController();

  bool iosOtpSend = false;

  requestOtp() {
    controller.loading();
    Future.delayed(const Duration(seconds: 1), () {
      controller.startTimer();
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        pop(context);
        return Future(() => false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: const Image(
                image: AssetImage("assets/email.png"),
              ),
            ),
            Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: size.width * 0.6,
                      width: size.width,
                      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                      decoration: const BoxDecoration(
                        color: AppColor.primary,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: const ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        child: Image(
                          image: AssetImage("assets/login.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 15, left: 15),
                      child: InkWell(
                        onTap: () {
                          pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColor.primary)),
                          child: const Icon(Icons.arrow_back, color: AppColor.primary, size: 18),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        // padding: size.width * 0.06,
                        children: [
                          const SizedBox(height: 15),
                          Text(
                            "OTP Verification",
                            style: TextStyle(
                              color: AppColor.primary,
                              fontSize: size.width * 0.06,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            'Please enter the OTP received to your mobile number +91 ${widget.mobile}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: size.width * 0.04,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 30),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
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
                                fieldHeight: size.width * 0.13,
                                fieldWidth: size.width * 0.11,
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
                            style: TextStyle(fontSize: size.width * 0.04, color: Colors.black.withOpacity(0.6)),
                          ),
                          // const Spacer(),
                          OtpTimerButton(
                            loadingIndicatorColor: AppColor.primary,
                            backgroundColor: AppColor.primary,
                            buttonType: ButtonType.text_button,
                            controller: controller,
                            onPressed: () async {
                              /*setState(() {
                                iosOtpSend = true;
                                Future.delayed(const Duration(seconds: 2)).then((_) {
                                  iosOtpSend = false;
                                  setState(() {});
                                });
                              });*/
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text("Otp sent successfully"),
                                backgroundColor: AppColor.primary,
                              ));
                              requestOtp();
                              // popup(context, size, AppText.otpSendSuccessfully, AppColor.green.withOpacity(0.8));
                            },
                            text: Text(
                              "Resend Otp",
                              style: TextStyle(
                                fontSize: size.width * 0.037,
                              ),
                            ),
                            duration: 30,
                          ),
                          const SizedBox(height: 25),
                          CustomBtn(
                            radius: 10,
                            btnColor: AppColor.primary,
                            size: size,
                            title: "Submit",
                            onTap: () {},
                          ),
                          SizedBox(height: MediaQuery.of(context).padding.bottom + 15),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
