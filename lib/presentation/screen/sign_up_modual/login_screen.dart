import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_color.dart';
import '../../../utils/app_validators.dart';
import '../../../utils/helper.dart';
import '../../widgets/custom_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController mobile = TextEditingController();
  bool isMobileValid = false;

  bool agreeCheckboxValue = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textField(
          controller: mobile,
          name: "mobile/email",
        ),
        const Text(
          "Please enter mobile no / email",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 0,
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 45,
          child: TextFormField(
            controller: mobile,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              hintText: 'mobile/email',
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
                          color: Colors.black,
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
          onTap: () => pop(context),
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

  OutlineInputBorder border = OutlineInputBorder(
    borderSide: const BorderSide(width: 1, color: AppColor.primary),
    borderRadius: BorderRadius.circular(8),
  );

  textField({
    required TextEditingController controller,
    String? hint,
    required String name,
    TextInputType? keyboard,
    Function? onTap,
    double? width,
    EdgeInsets? pad,
    String? Function(String?)? validator,
    Function(String value)? onChange,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(color: Colors.black, letterSpacing: 0, fontSize: 13),
        ),
        const SizedBox(height: 5),
        SizedBox(
          width: width,
          // height: 45,
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
            decoration: InputDecoration(
              contentPadding: pad ?? const EdgeInsets.symmetric(horizontal: 15),
              hintText: hint ?? '',
              enabledBorder: border,
              errorBorder: border,
              focusedBorder: border,
              border: border,
            ),
            validator: validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
