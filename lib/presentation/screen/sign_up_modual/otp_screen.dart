import 'package:flutter/material.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../utils/app_color.dart';
import '../../../utils/helper.dart';
import '../../widgets/custom_btn.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  requestOtp() {
    controller.loading();
    Future.delayed(const Duration(seconds: 1), () {
      controller.startTimer();
    });
  }

  OtpTimerButtonController controller = OtpTimerButtonController();

  @override
  Widget build(BuildContext context) {
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
