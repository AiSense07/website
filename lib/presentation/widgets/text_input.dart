import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/app_color.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    Key? key,
    required this.icon,
    required this.hintText,
    required this.controller,
    this.readOnly = false,
    this.onTap,
    required this.title,
    this.textInputType,
    this.width,
  }) : super(key: key);
  final String hintText;
  final Widget icon;
  final bool readOnly;
  final String title;
  final double? width;
  final TextInputType? textInputType;
  final Function()? onTap;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: size.width > 450 ? 15 : 13),
          ),
          Container(
            margin: const EdgeInsets.only(top: 3, bottom: 0),
            padding: const EdgeInsets.only(right: 10),
            width: width ?? double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black.withOpacity(0.3))),
            child: TextFormField(
              onTap: onTap,
              readOnly: readOnly,
              controller: controller,
              keyboardType: textInputType ?? TextInputType.name,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(right: 15, left: 15, bottom: 3),
                // prefixIcon: icon,
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RegisterTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final String name;
  final TextInputType? keyboard;
  final Function? onTap;
  final double? width;
  final bool obscureText;
  final bool isEmail;
  final EdgeInsets? pad;
  final String? Function(String?)? validator;
  final Function(String value)? onChange;

  const RegisterTextField({
    Key? key,
    required this.controller,
    this.hint,
    required this.name,
    this.keyboard,
    this.onTap,
    this.width,
    this.pad,
    this.validator,
    this.onChange,
    this.obscureText = false,
    this.isEmail = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          child: TextFormField(
            obscureText: obscureText,
            controller: controller,
            onTap: () {
              if (onTap != null) {
                onTap!();
              }
            },
            onChanged: (String value) {
              if (onChange != null) {
                onChange!(value);
              }
            },
            keyboardType: keyboard ?? TextInputType.name,
            inputFormatters: [if (!isEmail) UpperCaseTextFormatter()],
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

OutlineInputBorder border = OutlineInputBorder(
  borderSide: const BorderSide(width: 1, color: AppColor.primary),
  borderRadius: BorderRadius.circular(8),
);

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
