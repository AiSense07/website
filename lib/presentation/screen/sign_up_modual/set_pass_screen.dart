import 'package:flutter/material.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:three_connects/presentation/widgets/text_input.dart';
import 'package:three_connects/utils/app_validators.dart';

import '../../../utils/app_color.dart';
import '../../../utils/helper.dart';
import '../../widgets/custom_btn.dart';

class SetPassScreen extends StatefulWidget {
  const SetPassScreen({Key? key}) : super(key: key);

  @override
  State<SetPassScreen> createState() => _SetPassScreenState();
}

class _SetPassScreenState extends State<SetPassScreen> {
  requestOtp() {
    controller.loading();
    Future.delayed(const Duration(seconds: 1), () {
      controller.startTimer();
    });
  }

  OtpTimerButtonController controller = OtpTimerButtonController();

  TextEditingController passController = TextEditingController();
  TextEditingController rePassController = TextEditingController();

  bool passHide = false;
  bool rePassHide = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            RegisterTextField(
              controller: passController,
              name: "New Password",
              obscureText: passHide,
              isEmail: true,
              hint: "Enter 8 digit new password",
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28, right: 10),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    passHide = !passHide;
                  });
                },
                icon: Icon(passHide ? Icons.remove_red_eye_outlined : Icons.remove_red_eye),
              ),
            )
          ],
        ),
        Stack(
          alignment: Alignment.topRight,
          children: [
            RegisterTextField(
              isEmail: true,
              controller: rePassController,
              name: "Confirm Password",
              obscureText: rePassHide,
              hint: "Re-enter your password",
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28, right: 10),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    rePassHide = !rePassHide;
                  });
                },
                icon: Icon(rePassHide ? Icons.remove_red_eye_outlined : Icons.remove_red_eye),
              ),
            )
          ],
        ),
        const SizedBox(height: 35),
        CustomBtn(
          width: 150,
          radius: 10,
          btnColor: AppColor.primary,
          size: MediaQuery.of(context).size,
          title: "Submit",
          onTap: () {
            final pass = Validators.pass(passController.text);

            if (pass != null) {
              commonToast(context, pass);
            } else if (rePassController.text.isEmpty) {
              commonToast(context, "Please enter confirm password");
            } else if (rePassController.text != passController.text) {
              commonToast(context, "Password and Confirm password not match");
            } else {
              pop(context);
            }
          },
        )
      ],
    );
  }
}
