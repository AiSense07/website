import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    Key? key,
    required this.icon,
    required this.hintText,
    required this.controller,
    this.readOnly = false,
    this.onTap,
    required this.title,
    this.textInputType, this.width,
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
                contentPadding: const EdgeInsets.only(right: 15,left: 15,bottom: 3),
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