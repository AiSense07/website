import 'package:flutter/material.dart';

import 'custom_widgets.dart';

class CommonTitle extends StatelessWidget {
  final String title;
  const CommonTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: sizes(size, 20, 15), vertical: 10),
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(child: Divider(color: Colors.black54, thickness: 2)),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: sizes(size, 100, size500(size, 80, size.width > 400 ? 40 : 10)),
            ),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: sizes(size, 32, size500(size, 28, 24)),
                  fontWeight: FontWeight.w700),
            ),
          ),
          const Expanded(child: Divider(color: Colors.black54, thickness: 2)),
        ],
      ),
    );
  }
}
